import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_constants.dart';
import '../../helpers/audio_player.dart';
import '../../utils/app_logger.dart';
import '../bloc/audio_control_bloc.dart';

part 'audio_player_state.dart';

const _maxThemeVolume = 0.30;
const _clickVolume = 0.80;
const _visibilityVolume = 0.30;
const _countDownVolume = 0.30;
const _tapVolume = 0.40;
const _completionVolume = 0.70;

// max size allowed is 5x5
const _maxTiles = 25;

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioControlBloc _audioBloc;

  // audio players
  // theme music player
  final _themeMusicSource = AssetSource(AppAssets.themeMusic);
  final AudioPlayer _themeMusicPlayer = getAudioPlayer();

  // button click player
  final _buttonClickSource = AssetSource(AppAssets.buttonClick);
  final AudioPlayer _buttonClickPlayer = getAudioPlayer();

  // visibility player
  final _visibilitySource = AssetSource(AppAssets.visibility);
  final AudioPlayer _visibilityPlayer = getAudioPlayer();

  // count down begin player
  final _countDownBeginSource = AssetSource(AppAssets.countDownBegin);
  final AudioPlayer _countDownBeginPlayer = getAudioPlayer();

  // completion player
  final _completionSource = AssetSource(AppAssets.completion);
  final AudioPlayer _completionPlayer = getAudioPlayer();

  final _tileTapSucessSource = AssetSource(AppAssets.tileTapSuccess);
  final _tileTapErrorSource = AssetSource(AppAssets.tileTapError);

  // tile tap player
  final Map<int, AudioPlayer> _tileTapSuccess = {};
  final Map<int, AudioPlayer> _tileTapError = {};

  Timer? _timer;

  AudioPlayerCubit(this._audioBloc) : super(const AudioPlayerLoading()) {
    _init();
  }

  void _init() {
    _timer = Timer(AppConstants.kMS200, () async {
      await _themeMusicPlayer.setSource(_themeMusicSource);
      await _themeMusicPlayer.setVolume(_maxThemeVolume);

      emit(const AudioPlayerReady());

      await _buttonClickPlayer.setSource(_buttonClickSource);
      await _buttonClickPlayer.setVolume(_clickVolume);

      await _visibilityPlayer.setSource(_visibilitySource);
      await _visibilityPlayer.setVolume(_visibilityVolume);

      await _countDownBeginPlayer.setSource(_countDownBeginSource);
      await _countDownBeginPlayer.setVolume(_countDownVolume);

      await _completionPlayer.setSource(_completionSource);
      await _completionPlayer.setVolume(_completionVolume);

      for (int i = 0; i < _maxTiles; i++) {
        final tileTapSuccess = getAudioPlayer();
        await tileTapSuccess.setSource(_tileTapSucessSource);
        await tileTapSuccess.setVolume(_tapVolume);
        _tileTapSuccess[i] = tileTapSuccess;

        final tileTapError = getAudioPlayer();
        await tileTapError.setSource(_tileTapErrorSource);
        await tileTapError.setVolume(_tapVolume);
        _tileTapError[i] = tileTapError;
      }
    });

    _audioBloc.stream.listen(_onAudioControlStateChanged);
  }

  void onBackToHome() {
    _countDownBeginPlayer.stop();
    _visibilityPlayer.stop();
  }

  void playThemeMusic() {
    _themeMusicPlayer.setReleaseMode(ReleaseMode.loop);
    unawaited(_themeMusicPlayer.play(_themeMusicSource));
  }

  void _onAudioControlStateChanged(AudioControlState audioControlState) {
    // sound effect related settings
    // count down sound effect
    if (audioControlState.isSoundEffectEnabled) {
      _countDownBeginPlayer.setVolume(_countDownVolume);
    } else {
      _countDownBeginPlayer.setVolume(0.0);
    }

    if (audioControlState.isMusicEnabled) {
      playThemeMusic();
    } else {
      unawaited(_themeMusicPlayer.pause());
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _themeMusicPlayer.dispose();
    _buttonClickPlayer.dispose();
    _tileTapSuccess.forEach((_, audioPlayer) => audioPlayer.dispose());
    _tileTapError.forEach((_, audioPlayer) => audioPlayer.dispose());
    return super.close();
  }

  bool get _isSoundEffectEnabled => _audioBloc.state.isSoundEffectEnabled;

  // public methods

  void tileTappedAudio(int tileValue, {isError = false}) {
    AppLogger.log('AudioPlayerCubit :: tileTappedAudio');
    if (!_isSoundEffectEnabled) return;
    if (isError) {
      unawaited(_tileTapError[tileValue]!.replay(_tileTapErrorSource));
    } else {
      unawaited(_tileTapSuccess[tileValue]!.replay(_tileTapSucessSource));
    }
  }

  void clickAudio() {
    if (_isSoundEffectEnabled) {
      unawaited(_buttonClickPlayer.replay(_buttonClickSource));
    }
  }

  void beginCountDown() {
    unawaited(_countDownBeginPlayer.replay(_countDownBeginSource));
  }

  void onVisibilityShown() {
    if (_isSoundEffectEnabled) {
      unawaited(_visibilityPlayer.replay(_visibilitySource));
    }
  }

  void completion() {
    if (_isSoundEffectEnabled) {
      unawaited(_completionPlayer.replay(_completionSource));
    }
  }
}
