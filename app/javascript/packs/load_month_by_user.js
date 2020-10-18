$(document).ready( () => {
  $("#user_id").change( () => {
    var id_value_string = $("#user_id").val();
    if (id_value_string == "") {
      $("#month option").remove();
      var row = "<option value=" + "0" + ">" + "No Data" + "</option>";
      $(row).appendTo("#month");
    }
    else {
      $.ajax({
        dataType: "json",
        type: "GET",
        cache: false,
        url: "/shares/get_month_from_user_shared/" + id_value_string,
        error: function(XMLHttpRequest, errorTextStatus, error){
            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
        },
        success: (data) => {
          $("#month option").remove();
          if (data.length === 0){
            row = "<option value=" + "0" + ">" + "No Data" + "</option>";
            $(row).appendTo("#month");
          } else {
            $.each(data, (i, month) => {
              row = "<option value=" + month + ">" + month + "</option>";
              $(row).appendTo("#month");
            });
          }
        }
      });
    };
  });
});
