$(document).on("click", "#submit", function () {
  let clickedOption = $("#status").val();
  let clickedOption2 = $("#month").val();
  $("#export").attr("href", "/en/plans.xls?status=" + clickedOption + "&month=" + clickedOption2);
});
