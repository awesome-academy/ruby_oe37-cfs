$(document).on("click", "#submit", function () {
  let locale = $(location).attr("pathname")
  let clickedOption = $("#status").val();
  let clickedOption2 = $("#month").val();
  $("#export").attr("href", locale + ".xls?status=" + clickedOption + "&month=" + clickedOption2);
});
