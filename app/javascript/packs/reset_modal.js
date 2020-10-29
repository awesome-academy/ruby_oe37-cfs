$(document).on("hidden.bs.modal", "#myModal", () => {
  $("#myModal form")[0].reset();
  $(".notice").remove();
});
