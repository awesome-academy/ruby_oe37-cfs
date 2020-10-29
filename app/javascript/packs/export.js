$(document).on("click", "#submit", function () {
  let locale = $(location).attr("pathname")
  let clickedOption = $("#q_status_eq").val();
  let clickedOption2 = $("#q_month_eq").val();
  $("#export").attr("href", locale + ".xls?status=" + clickedOption + "&month=" + clickedOption2);
});
