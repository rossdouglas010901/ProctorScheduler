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
   var params = _params || '';
   var method = _method || 'GET';
   if (window.XMLHttpRequest) {
       xhttp = new XMLHttpRequest(); /* FF, Chrome, Opera, Safari, IE9+ */
   } else {
	   /* IE 5-8 */
       var client = ['MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP', 'Microsoft.XMLHTTP'];
       var i = 0;
       for (i = 0; i < client.length; ++i) {
           if (new ActiveXObject(client[i]))  {
               xhttp = new ActiveXObject(client[i]);
               break;
           }
        }
   }
   /* simple query parameter-based GET, DELETE requests */
   if (method.toUpperCase() === 'GET' || method.toUpperCase() === 'DELETE' || method.toUpperCase() === 'PUT') {
       xhttp.open(method, url+params, false);
       xhttp.send();	
   } else { /* POST params being sent should not be empty and will be added in “request BODY” not appended to URL */
       xhttp.open(method, url, false);
       xhttp.send(params);
   }
   return (_format.toUpperCase().indexOf('XML') !== -1) ? xhttp.responseXML : xhttp.responseText; /* parse as XML or Text (JSON, CSV, plaintext, etc) */
}

/**
 * Filters any list of Search Results (structured in <ul> or <ol> with child <li> elements)
 * @param input  text to match the in-page/client-side search term filter on
 */
function filterSearchResults(input) {
    var filter, ul, li, a, i, txtValue;
    filter = input.value.toUpperCase();
    ul = document.getElementById('results');
    li = ul.getElementsByTagName('li');
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName('a')[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = 'block';
        } else {
            li[i].style.display = 'none';
        }
    }
}
