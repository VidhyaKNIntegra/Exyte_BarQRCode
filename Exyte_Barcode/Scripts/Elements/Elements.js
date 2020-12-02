function GetControlElements(control, controlLbl, refreshControl, level, url, ids) {
   
    if ($('#' + (control + ids)).val() === "choose" && level !== "1" && level !== "100" && level !== "101" && level !== "102") {
        $('#' + (controlLbl + ids)).text('Please select item');
    }
    else {
        $('#' + (controlLbl + ids)).text('');
        var parent = $('#' + (control + ids)).val();
        $("#" + (refreshControl + ids)).empty();
        $("#" + (refreshControl + ids)).append($("<option></option>").val("choose").html("choose"));
        $.ajax({
            type: "GET",
            //url: "/Elements/GetElements",
            url: url,
            data: (level !== "100" && level !== "101" && level !== "102") ? { "level": level, "parent": parent } : "",
            contentType: "application/json",
            success: function (data) {
                $.each(data, function (key, value) {                    
                    if (level === "101") // Manufacturer
                        $("#" + (refreshControl + ids)).append($("<option></option>").val(value.Manufacturer).html(value.Manufacturer));
                    else if (level === "102") // UOM
                        $("#" + (refreshControl + ids)).append($("<option></option>").val(value.UOM).html(value.UOM));
                    else if (level === "100")
                        $("#" + (refreshControl + ids)).append($("<option></option>").val(value.Slno).html(value.GroupElement));
                    else
                        $("#" + (refreshControl + ids)).append($("<option></option>").val(value.Element).html(value.Description));
                    //$("#" + refreshControl).append($("<option></option>").val(value).html(value));
                });
                $("#" + (refreshControl + ids)).focus();
            }
        });
    }
}
function editControlBind(values, refreshControl, level, url, ids,selectedVal) {
        $("#" + (refreshControl + ids)).empty();
        $("#" + (refreshControl + ids)).append($("<option></option>").val("choose").html("choose"));
        $.ajax({
            type: "GET",
            //url: "/Elements/GetElements",
            url: url,
            data: { "level": level, "parent": values },
            contentType: "application/json",
            success: function (data) {
                $.each(data, function (key, value) {
                    if (selectedVal===value.Element)
                        $("#" + (refreshControl + ids)).append($("<option selected='selected'></option>").val(value.Element).html(value.Description));
                    else
                        $("#" + (refreshControl + ids)).append($("<option></option>").val(value.Element).html(value.Description));
                });
            }
        });
      
}
function levelChange(control, ids)
{
    $("#" + (control + ids)).empty();
    $("#" + (control + ids)).append($("<option></option>").val("choose").html("choose"));
}
function changeElementID(control, controlLbl, newid)
{    
    var i;
    for (i = 0; i <= 9; i++) {
        var cntrl = document.getElementById((control+i));
        cntrl.id = (control+i) + newid;
        var cntrlbl = document.getElementById((controlLbl+i));
        cntrlbl.id = (controlLbl+i) + newid;       
    }
}
function clearControlElements(control, id)
{
    var i;
    for(i=0;i<=9;i++)
    {
        $("#" + (control+i+ id)).val("choose");
    }
}
function validatePartial(control, controlLbl,id,isMep)
{
    var returnVal = true;
    var i;
    for (i = 0; i <= 9; i++) {
        if ($('#'+isMep).val() == 'MEP' && i==5) {
            $('#' + (controlLbl + i + id)).text('');
        }
        else {
            if ($('#' + (control + i + id)).val() == "choose") {
                $('#' + (controlLbl + i + id)).text('Please select item');
                returnVal = false;
            }
            else {
                $('#' + (controlLbl + i + id)).text('');
            }
        }
        
    }
    return returnVal;
}
//function loadMaterials() {    

//}
//function loadPipeComponents() {

//}