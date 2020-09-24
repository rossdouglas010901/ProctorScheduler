/**
 * makeRequest
 *   Make an HTTP request in JavaScript using one of GET, POST, PUT, DELETE methods
 * 
 *@param url String - the URL to make request to
 *@param _params String - (OPTIONAL) parameters or message body, defaults to blank
 *@param _method String - (OPTIONAL) method through which to send request, defaults to 'GET'
 *@param _format String - (OPTIONAL) return format
 *@return XML or Text
 */
function makeRequest(url, _params, _method, _format) {
   var params = _params || "";
   var method = _method || "GET";
   if (window.XMLHttpRequest) {
       xhttp = new XMLHttpRequest(); /* FF, Chrome, Opera, Safari, IE9+ */
   } else {  
       var client = ["MSXML2.XMLHTTP.5.0", "MSXML2.XMLHTTP.4.0", "MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP", "Microsoft.XMLHTTP"];
       var i = 0;
       for (i = 0; i < client.length; ++i) {
           if (new ActiveXObject(client[i]))  {
               xhttp = new ActiveXObject(client[i]); /* IE 5-8 */
               break;
           }
        }
   }
   /* simple query parameter-based GET requests */
   if (method.toUpperCase() === "GET" || method.toUpperCase() === "DELETE") {
       xhttp.open(method, url+params, false);
       xhttp.send();	
   } else { /* POST, PUT, DELETE params being sent should not be empty and will be added in “request BODY” not appended to URL */
       xhttp.open(method, url, false);
       xhttp.send(params);
   }
   return (_format === "xml") ? xhttp.responseXML : xhttp.responseText; /* parse as XML or Text (JSON, CSV, plaintext, etc) */
}