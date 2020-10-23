$(document).ready( () => {
  $("#myModal").on("hidden.bs.modal", () => {
    $("#myModal form")[0].reset();
    $(".notice").remove();
  });
});
