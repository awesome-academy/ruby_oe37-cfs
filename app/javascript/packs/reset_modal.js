$(document).on("hidden.bs.modal", "#myModal", () => {
  $("#myModal form")[0].reset();
  $(".notice").remove();

  $.ajax({
    dataType: "json",
    type: "GET",
    cache: false,
    url: "/plans/reload_categories",
    error: function(XMLHttpRequest, errorTextStatus, error){
        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
    },
    success: (categories) => {
      $("#plan_category_id option").remove();
      $.each(categories, (i, category) => {
        row = "<option value=" + category.id + ">" + category.name + "</option>";
        $(row).appendTo("#plan_category_id");
      });
    }
  });
});
