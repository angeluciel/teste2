import 'patient.dart';

class MortalityCalculator {
  int calculateScore(Patient patient) {
    int score = 0;

    if (!patient.hasBiliaryColic) {
      if (patient.age > 55) score++;
      if (patient.leucocytes > 16000) score++;
      if (patient.glicemia > 11) score++;
      if (patient.ast > 250) score++;
      if (patient.ldh > 350) score++;
    } else {
      if (patient.age > 70) score++;
      if (patient.leucocytes > 18000) score++;
      if (patient.glicemia > 12.2) score++;
      if (patient.ast > 250) score++;
      if (patient.ldh > 400) score++;
    }

    return score;
  }

  double calculateMortality(int score) {
    if (score >= 7) {
      return 1.0; // 100% mortality
    } else if (score >= 5) {
      return 0.4; // 40% mortality
    } else if (score >= 3) {
      return 0.15; // 15% mortality
    } else {
      return 0.02; // 2% mortality
    }
  }
}