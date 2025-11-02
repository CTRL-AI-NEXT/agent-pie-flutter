enum APIResultType {
  loading,
  success,
  failure,
  sessionExpired,
  noInternet,
  unauthorised,
  cacheError,
  notFound,
  timeOut
}

enum NetworkResultType {
  success,
  error,
  cacheError,
  timeOut,
  noInternet,
  unauthorised,
  notFound
}


enum UploadStep {
  idle,
  uploadingPDF,
  generatingQuiz,
  generatingTraining,
  completed,
}
