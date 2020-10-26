class Result {
  DateTime time;
  int numberOfQuestions;
  int numberOfCorrectResponse;

  double get percentage {
    return 100 * (numberOfCorrectResponse / numberOfQuestions);
  }

  Result(this.time, this.numberOfCorrectResponse, this.numberOfQuestions);
}
