import 'utils/decision_utils_style.dart';

class DecisionSdkStyle extends DecisionSdkUtilsStyle {
  final String _textFont;
  final String _bigTxtFontFamily;
  final String _leftImage;
  final String _rightImage;

  DecisionSdkStyle({
    textFont = 'NunitoSans',
    bigTxtFontFamily = 'Koara',
    leftImage = 'yes',
    rightImage = 'no'})
      : _textFont = textFont,
        _bigTxtFontFamily = bigTxtFontFamily,
        _leftImage = leftImage,
        _rightImage = rightImage;

  String get textFont => _textFont;
  String get bigTxtFontFamily => _bigTxtFontFamily;
  String get leftImage => _leftImage;
  String get rightImage => _rightImage;
}
