<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isELIgnored="false"%>
<%@page language="java" import="java.sql.SQLException"%>
<%@page language="java" import="com.oultoncollege.db.DatabaseConnection"%>
<%@page language="java" import="com.oultoncollege.db.UserDAO"%>
<%@page language="java" import="com.oultoncollege.model.User"%>
<%@page language="java" import="com.oultoncollege.util.PreventXSS"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<%
// TODO: this scriptlet should be migrated to a View that forwards to the JSP/JSTL  
    User user = new User();
    String id = PreventXSS.filter(request.getParameter("id"));
    if (null != id && !id.isEmpty()) {
        int userID = Integer.parseInt(id);
        try {
            DatabaseConnection db = new DatabaseConnection();
            UserDAO userManager = new UserDAO(db.getConnection());
            user = userManager.getUserByID(userID);
            request.setAttribute("currentUser", user);
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
<jsp:include page="/head.jsp"></jsp:include>
<%-- flexbox split view --%>
<div id="main" class="flex-container">    
    <%-- REQUEST TO TEACHER FORM -- View, Add, Edit and Remove --%>
    <form id="Form" name="request-proctoring" class="flex-item" method="POST" action="${app}/contact">
        <div id="SelectedPartsFormContainer" class="clf-form" formcontainer="y">
            <input type="hidden" name="CampusID" value="220101" />
            <div id="FirstNameSet" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    First Name:<span class="clf-d-requiredmark">*</span>
                </div>
                <div id="FirstNameDiv" class="clf-d-control" formcontrol="y">
                    <input name="FirstName" type="text" id="FirstName" value="${empty currentUser ? '' : currentUser.firstName}" /><div>
                    </div>
                </div>
            </div>
            <div id="LastnameSet" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    Last Name:<span class="clf-d-requiredmark">*</span>
                </div>
                <div id="LastnameDiv" class="clf-d-control" formcontrol="y">
                    <input name="Lastname" type="text" id="Lastname" value="${empty currentUser ? '' : currentUser.lastName}" /><div>
                    </div>
                </div>
            </div>
            <div id="EmailSet" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    E-Mail:<span class="clf-d-requiredmark">*</span>
                </div>
                <div id="EmailDiv" class="clf-d-control" formcontrol="y">
                    <input name="Email" type="text" id="Email" value="${empty param.id ? '' : currentUser.email}" />
                </div>
            </div>
            <div id="TelephoneSet" class="clf-d-fieldset" fieldset="y">
				<label for="phoneNumber">Phone Number: </label>
                <div id="TelephoneDiv" class="clf-d-control clf-form-input-3parts-30-30-40" formcontrol="y">
                    <input type="tel" name="phoneNumber" id="phoneNumber" class="field" 
                      required="required" 
                      minlength="7" 
                      maxlength="18" 
                      value="${empty currentUser ? '' : currentUser.phoneNumber}"
                      placeholder=" "
                      title="Please fill out this field"
                      pattern="^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"
                      data-error-message="Please enter a valid Phone Number in the requested format: '+99 (999) 999-9999'" 
                      oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                      onchange="setCustomValidity('');" />
                    <input type="number" name="phoneExtension" id="ext" class="field" 
                  	  minlength="0" 
                  	  maxlength="4"
                  	  title="Extension (optional)"
                  	  placeholder="Ext."
                  	  value="${empty currentUser || empty currentUser.phoneExt ? '' : currentUser.phoneExt}" 
                  	/>
                </div>
            </div>
            <div id="PostalZipCodeSet" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    Postal Code:
                </div>
                <div id="PostalZipCodeDiv" class="clf-d-control" formcontrol="y">
                    <input name="PostalZipCode" type="text" id="PostalZipCode" />
                </div>
            </div>
            <div id="highestSchooling" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    School of most recent/relevant graduation:<span class="clf-d-requiredmark">*</span>
                </div>
                <div id="highestSchooling" class="clf-d-control" formcontrol="y">
                    <select name="HS_SchoolID" id="HS_SchoolID">
                        <option value="0">Select</option>
                        <optgroup label="Private">
	                        <option value="1402760">GED</option>
	                        <option value="1495269">other</option>
						</optgroup>
                        <optgroup label="High School">
	                        <option value="1137483">Abbotsford Senior Secondary School</option>
	                        <option value="1317598">Advocate District School</option>
	                        <option value="1402777">Alberta Education</option>
	                        <option value="1137484">All Saints Catholic Secondary School</option>
	                        <option value="1317597">Amherst Regional High</option>
	                        <option value="1102088">Annapolis Wet Educ. Centre</option>
	                        <option value="1102089">Apostolic Christian School</option>
	                        <option value="1402761">Archbishop Denis O'connor Catholic High School</option>
	                        <option value="1403156">Archbishop Jordan High School</option>
	                        <option value="1102091">Auburn High</option>
	                        <option value="1102092">Aux Quatre Vents</option>
	                        <option value="1102093">Avon View High School</option>
	                        <option value="2219075">Baddeck Academy</option>
	                        <option value="2219082">Barrington Municipal High School</option>
	                        <option value="1137486">Barton Secondary School</option>	                        
	                        <option value="1317560">Bathurst High School</option>
	                        <option value="1137491">Bay d'Espoir Academy</option>
	                        <option value="2436126">Beaverbrook Alternative</option>
	                        <option value="1137492">Belleisle Regional High</option>
	                        <option value="1137493">Belmont Secondary School</option>
	                        <option value="1102099">Bernice MacNaughton High School</option>
	                        <option value="1317566">Blackville High School</option>
	                        <option value="1102101">Bluefield High</option>
	                        <option value="1317568">Bonar Law Memorial High School</option>
	                        <option value="1137497">Bonaventure Polyvalente School</option>
	                        <option value="1102103">Breton Education Centre</option>
	                        <option value="1137500">Bridgetown Regional</option>
	                        <option value="2219080">Bridgewater High School</option>
	                        <option value="2715705">Bridgeway Academy</option>
	                        <option value="1102104">C.S.C. La Fontaine</option>
	                        <option value="1137501">Cabot Jr/Sr High School</option>
	                        <option value="1137502">Caledonia High School</option>
	                        <option value="1317684">Cambridge Narrows High School</option>
	                        <option value="1102107">Campobello Island Consolidated</option>
	                        <option value="2245462">Canso Academy</option>
	                        <option value="1317619">Canterbury High School</option>
	                        <option value="2219072">Cape Breton Highlands Academy</option>
	                        <option value="1402774">Cape Breton University</option>
	                        <option value="1317621">Carleton North High School</option>
	                        <option value="1102110">Carrefour Beausoleil</option>
	                        <option value="1137507">Central Kings Rural High School</option>
	                        <option value="1317688">Central New Brunswick Academy</option>
	                        <option value="1102111">Charles P. Allen</option>
	                        <option value="1102112">Charlottetown Rural High School</option>
	                        <option value="2244845">Chief Allison M. Bernard Memorial High School</option>
	                        <option value="1102113">Chignecto Adult High School</option>
	                        <option value="1300278">Chipman Forest Avenue School</option>
	                        <option value="1137509">Christ the King All Grade</option>
	                        <option value="2219071">Citadel High School</option>
	                        <option value="1137510">Cite des Jeunes High School</option>
	                        <option value="1137511">Clarenceville High School</option>
	                        <option value="1317593">Cobequid Educational Centre</option>
	                        <option value="1102117">Cole Harbour District High School</option>
	                        <option value="1102118">Colonel Gray High School</option>
	                        <option value="1137516">Dalbrae Academy</option>
	                        <option value="1317559">Dalhousie Regional High School</option>
	                        <option value="1137520">Dalhousie University</option>
	                        <option value="2233718">Dartmouth High School</option>
	                        <option value="2245203">Digby Regional High School</option>
	                        <option value="1102121">Doaktown Consolidated High School</option>
	                        <option value="1402762">Dr. John Hugh Gillis Regional</option>
	                        <option value="1137521">Dr. Phillips High School</option>
	                        <option value="2219063">Drumlin Heights Consolidated School</option>
	                        <option value="1317589">Duncan MacMillan High School</option>
	                        <option value="1137522">Earl Marriott Secondary School</option>
	                        <option value="1488489">East Antigonish Education Centre</option>
	                        <option value="1402771">East View Secondary High School</option>
	                        <option value="1317588">Eastern Shore District High School</option>
	                        <option value="1102097">École Beau-Port</option>
	                        <option value="1102116">École Clément-Cormier</option>
	                        <option value="2219077">Ecole Etoile de l'Acadie</option>
	                        <option value="1137537">École Evangeline High School</option>
	                        <option value="1137540">École François Buote</option>
	                        <option value="1137526">Ecole Grande Riviere</option>
	                        <option value="1137530">École L'Odyssée</option>
	                        <option value="1137620">Ecole Louis J Robichaud</option>
	                        <option value="1137528">Ecole Marie-Esther</option>
	                        <option value="1137529">École Mathieu-Martin</option>
	                        <option value="1137588">École Mgr-Marcel-François-Richard</option>
	                        <option value="2219067">Ecole NDA</option>
	                        <option value="1102188">Ecole Régionale de Baie Sainte-Anne</option>
	                        <option value="1137533">Ecole Sainte-Anne</option>
	                        <option value="1137638">École Samuel-de-Champlain</option>
	                        <option value="1137534">Ecole Secondaire Assomption</option>
	                        <option value="2219065">Ecole Secondaire de Clare</option>
	                        <option value="2219064">Ecole Secondaire de Par-en-Bas</option>
	                        <option value="2232792">Ecole Secondaire du Sommet</option>
	                        <option value="1102095">École secondaire Grande-RiviÃ¨re</option>
	                        <option value="1102123">Ecole Secondaire Nepisiquit</option>
	                        <option value="1137536">Elmira District Secondary School</option>
	                        <option value="1102124">Escuminac Intermediate School</option>
	                        <option value="1102125">Evangeline High School</option>
	                        <option value="1137538">F.H. Collins Secondary School</option>
	                        <option value="1102126">Fairview High School</option>
	                        <option value="1402782">Flexible Learning Education Centres (NS)</option>
	                        <option value="1102127">Forest Heights School</option>
	                        <option value="1137539">Frances Kelsey Secondary School</option>
	                        <option value="1317685">Fredericton High School</option>
	                        <option value="1137541">Fundy High School</option>
	                        <option value="2708772">GED (Elizabeth)</option>
	                        <option value="2708773">GED (Sebastien)</option>
	                        <option value="1137543">General Panet High School</option>
	                        <option value="1137544">Georgetown District High School</option>
	                        <option value="1102130">Glace Bay High School</option>
	                        <option value="1102131">Grand Manan Community School</option>
	                        <option value="1402788">Grossse Isle School</option>
	                        <option value="2245461">Guysborough Academy</option>
	                        <option value="1137547">Halifax West High School</option>
	                        <option value="1102133">Hampton High School</option>
	                        <option value="1317592">Hants East Rural High School</option>
	                        <option value="1317596">Hants North Rural High School</option>
	                        <option value="1137549">Harbourview High School</option>
	                        <option value="1299771">Harrison Trimble High School</option>
	                        <option value="1317620">Hartland Community School</option>
	                        <option value="1102138">Harvey High School</option>
	                        <option value="1137551">Highland Secondary School</option>
	                        <option value="1137554">Holland Memorial Central High School</option>
	                        <option value="1137555">Holy Cross High School</option>
	                        <option value="1137557">Holy Heart of Mary High School</option>
	                        <option value="1102139">Horton High School</option>
	                        <option value="1137558">Indian River High School</option>
	                        <option value="1137559">Innisdale Secondary School</option>
	                        <option value="1402781">International Career School Canada</option>
	                        <option value="2219073">Inverness Academy</option>
	                        <option value="1137560">Islands Consolidated School</option>
	                        <option value="1137561">J. Percy Page High School</option>
	                        <option value="1137562">J.L Ilsley High School</option>
	                        <option value="1402769">James Fowler High School</option>
	                        <option value="1317563">James M. Hill High School</option>
	                        <option value="1137566">Jens Haven Memorial School</option>
	                        <option value="1102141">JMA Armstrong High School</option>
	                        <option value="1317612">John Caldwell High School</option>
	                        <option value="1102143">Kennebecassis Valley High School</option>
	                        <option value="1102144">Kensington Intermediate Senior High School</option>
	                        <option value="2219086">Kings Edgehill</option>
	                        <option value="1102145">Kinkora Regional High School</option>
	                        <option value="1137679">L'École Polyvalente Roland-Pépin</option>
	                        <option value="1137573">Lafontaine High School</option>
	                        <option value="1402766">Lakeshore Catholic High School</option>
	                        <option value="1137574">Lawrence High School</option>
	                        <option value="1317687">Leo Hayes High School</option>
	                        <option value="1402780">Lester B. Pearson</option>
	                        <option value="1137575">Liverpool Regional High School</option>
	                        <option value="1137576">Livingstone School</option>
	                        <option value="2219081">Lockeport Regional High School</option>
	                        <option value="1317591">Lockview High School</option>
	                        <option value="1102148">Lorne Park Secondary School</option>
	                        <option value="1102150">Louis-Mailloux High School</option>
	                        <option value="1137577">Lowell High School (Mass, USA)</option>
	                        <option value="1102151">LS Eddy Memorial High School</option>
	                        <option value="1137580">Macklin School</option>
	                        <option value="1102152">Madawaska High School</option>
	                        <option value="1402768">Major Pratt School</option>
	                        <option value="1137581">Marie-Esther High School</option>
	                        <option value="1137582">Marystown Central High School (Newfoundland)</option>
	                        <option value="1137584">Matthew McNair Secondary</option>
	                        <option value="1102155">McAdam High School</option>
	                        <option value="1137586">Medicine Hat High School</option>
	                        <option value="1137587">Memorial Composite High</option>
	                        <option value="1137589">Middleton Regional High School</option>
	                        <option value="1137590">Millidgeville North High School</option>
	                        <option value="2219069">Millwood High School</option>
	                        <option value="1317691">Minto Memorial High School</option>
	                        <option value="1317564">Miramichi Valley High School</option>
	                        <option value="1137592">Moncton Christian Academy</option>
	                        <option value="1102159">Moncton High School</option>
	                        <option value="1102160">Montague Regional High School</option>
	                        <option value="1137593">Montego Bay High School</option>
	                        <option value="1137594">Morell Regional High School</option>
	                        <option value="1137595">Mount Allison University</option>
	                        <option value="1137598">Mount Baker Secondary School</option>
	                        <option value="1137596">Mount Carmel Secondary School</option>
	                        <option value="1137597">Mount Pearl Senior High School</option>
	                        <option value="1402773">Mount Saint Vincent University</option>
	                        <option value="1317590">Musquodoboit Rural High School</option>
	                        <option value="1317625">Nackawic High School</option>
	                        <option value="1137599">Nantyr Shores Secondary School</option>
	                        <option value="1402789">Nasir Ahmadiyya Muslim Secondary School</option>
	                        <option value="1439697">Nepisiguit</option>
	                        <option value="2219078">New Germany Rural High School</option>
	                        <option value="1317567">North &amp; South Esk Regional</option>
	                        <option value="1317594">North Colchester HS</option>
	                        <option value="1102165">North Nova Education Center</option>
	                        <option value="1137601">North Peace Secondary School</option>
	                        <option value="2219079">North Queens Rural High School</option>
	                        <option value="1102166">Northeast King Educ. Centre</option>
	                        <option value="1102167">Northumberland Regional High School</option>
	                        <option value="1137602">Notre Dame Catholic Secondary School</option>
	                        <option value="1137605">Oromocto High School</option>
	                        <option value="1317602">Oxford Regional High School</option>
	                        <option value="1102172">P.A.L.S.</option>
	                        <option value="1137609">Park View Education Centre</option>
	                        <option value="1317603">Parrsboro Regional High School</option>
	                        <option value="1137610">Pearce Regional High School</option>
	                        <option value="1137611">Peel Alternative North ISR</option>
	                        <option value="1317694">Petitcodiac Regional High School</option>
	                        <option value="1137616">Philippine Academy of Sakya</option>
	                        <option value="1137617">Pictou Academy</option>
	                        <option value="1137625">Pleasure Ridge Park High School</option>
	                        <option value="2264601">Polyvalente A.J. Savoie</option>
	                        <option value="1137619">Polyvalente Louis Mailloux</option>
	                        <option value="1137676">Polyvalente Roland-Pepin</option>
	                        <option value="1102203">Polyvalente Thomas-Albert</option>
	                        <option value="1102206">Polyvalente W.-A. Losier High School</option>
	                        <option value="1402787">Port Perry High</option>
	                        <option value="1102177">Prince Andrew High School</option>
	                        <option value="1317604">Pugwash District High School</option>
	                        <option value="1402799">Punjab School Education Board</option>
	                        <option value="1102179">Queen Elizabeth High School</option>
	                        <option value="1137626">Quinte Secondary School</option>
	                        <option value="2219076">Rankin School of the Narrows</option>
	                        <option value="1102180">Richmond Academy</option>
	                        <option value="1137627">Ridgeway North</option>
	                        <option value="1317599">River Hebert District High School</option>
	                        <option value="1102182">Riverdale High School</option>
	                        <option value="1137628">Riverview High School</option>
	                        <option value="2219074">Riverview High School (Cape Breton)</option>
	                        <option value="1102184">Rothesay High School</option>
	                        <option value="1317853">Rothesay-Netherwood School</option>
	                        <option value="1102185">Sackville High school</option>
	                        <option value="1137632">Sacred Heart High School</option>
	                        <option value="1488474">Saerc High School</option>
	                        <option value="1137633">Saint John High School</option>
	                        <option value="1102195">Saint Malachy's Memorial HS</option>
	                        <option value="1137635">Salisbury High School</option>
	                        <option value="1137636">Salmon Arm Secondary School</option>
	                        <option value="1137639">Shelburne Regional High School</option>
	                        <option value="1102189">Simonds High School</option>
	                        <option value="1137640">Sir Allen MacNab High School</option>
	                        <option value="1137641">Sir Frederick Banting Secondary School</option>
	                        <option value="1102190">Sir James Dunn Academy</option>
	                        <option value="2219070">Sir John A Macdonald High School</option>
	                        <option value="1137643">Sir John Franklin High School</option>
	                        <option value="1102191">Souris Regional High School</option>
	                        <option value="1317595">South Colchester High School</option>
	                        <option value="1402765">South East Regional Learning Board</option>
	                        <option value="1317615">Southern Victoria High School</option>
	                        <option value="1317601">Springhill High School</option>
	                        <option value="1137634">St Vincent's High School</option>
	                        <option value="1137647">St. Augustine High School</option>
	                        <option value="1137648">St. Mary's Academy</option>
	                        <option value="1137649">St. Mary's Catholic Secondary School</option>
	                        <option value="2219066">St. Marys Bay Academy</option>
	                        <option value="1137650">St. Patrick's High School</option>
	                        <option value="1137651">St. Paul High School</option>
	                        <option value="1102196">St. Stephen High School</option>
	                        <option value="1137652">St. Thomas University</option>
	                        <option value="1102197">St. Vincent's High School</option>
	                        <option value="1317689">Stanley Regional High School</option>
	                        <option value="1137653">Stella Maris High School</option>
	                        <option value="1102199">Strait Area Education Recreation Centre</option>
	                        <option value="1402784">Strait Regional School Board</option>
	                        <option value="1317555">Sugarloaf Senior High School</option>
	                        <option value="1317693">Sussex Christian School</option>
	                        <option value="1300196">Sussex Regional High School</option>
	                        <option value="1137660">Sydney Academy</option>
	                        <option value="1317606">Tantramar Regional High School</option>
	                        <option value="1137662">Terry Fox Secondary School</option>
	                        <option value="1137663">Thornhill Secondary</option>
	                        <option value="1102204">Three Oaks Senior High School</option>
	                        <option value="1317613">Tobique Valley High School</option>
	                        <option value="2708783">TSD Acadian Peninsula/Caraquet Coast</option>
	                        <option value="2708782">TSD Edmunston</option>
	                        <option value="2708779">TSD Fredericton/Oromocto</option>
	                        <option value="2708777">TSD Miramichi</option>
	                        <option value="2708775">TSD Moncton (Elizabeth)</option>
	                        <option value="2708774">TSD Moncton (Sebastien)</option>
	                        <option value="2708780">TSD Restigouche</option>
	                        <option value="2708778">TSD Saint John/Quispamsis/St. Stephen</option>
	                        <option value="2708776">TSD Shediac/Bouctouche</option>
	                        <option value="2708781">TSD Woodstock/Bath/Hartland</option>
	                        <option value="1137665">Unama 'Ki Training &amp; Education Centre</option>
	                        <option value="1137664">Université de Moncton</option>
	                        <option value="1402778">University of Guelph</option>
	                        <option value="1402764">University of Prince Edward Island</option>
	                        <option value="2244846">Waycobah First Nation Secondary School</option>
	                        <option value="1137668">West Kings District High School</option>
	                        <option value="1102207">West Pictou District High School</option>
	                        <option value="1102208">Westisle Composite High School</option>
	                        <option value="1102209">Westville High School</option>
	                        <option value="1137669">Westwood community high school</option>
	                        <option value="1402779">Windsor Regional High School</option>
	                        <option value="1137670">Woodlands Secondary School</option>
	                        <option value="1137671">Woodlawn Learning Center</option>
	                        <option value="1317617">Woodstock High School</option>
	                        <option value="1102211">Yarmouth High School</option>
	                        <option value="1137672">Young School</option>
						</optgroup>
						<optgroup label="College">
	                        <option value="1402770">Ascension Collegiate (NF)</option>
							<option value="1137487">Base Borden Collegiate (Ontario)</option>
	                        <option value="1137498">Botwood Collegiate</option>
	                        <option value="1137499">Brantford Collegate Institute</option>
	                        <option value="1402775">Brentwood College School</option>
	                        <option value="1137504">Campbellton Community College</option>
	                        <option value="1402767">CCNB</option>
	                        <option value="1137506">Cedarbrae Collegiate Institute</option>
	                        <option value="1402783">College of the North Atlantic</option>
	                        <option value="1137515">Daho College</option>
	                        <option value="1137513">Eastern College</option>
	                        <option value="1137542">Gander Collegiate</option>
	                        <option value="1402772">Harrington College of Canada (Qc)</option>
	                        <option value="1137553">Holland College</option>
	                        <option value="1137569">Kayin College</option>
	                        <option value="1137570">Korah Collegiate &amp; Vocational School</option>
	                        <option value="1137578">Loyola College Ibadan</option>
	                        <option value="1137600">New Brunswick Community College</option>
	                        <option value="1137603">Nova Scotia Community College</option>
	                        <option value="1137604">Orillia District Collegiate &amp; Vocational Institute</option>
	                        <option value="1137607">Oulton College</option>
	                        <option value="1137624">Prince of Wales Collegiate</option>
                        </optgroup>
                        <optgroup label="University">
							<option>Alberta University of the Arts 	Calgary</option>
							<option>Athabasca University</option>
							<option>MacEwan University</option>
							<option>Mount Royal University</option>
							<option>University of Alberta</option>
							<option>University of Calgary</option>
							<option>University of Lethbridge</option>
							<option>Capilano University</option>
							<option>Emily Carr University of Art and Design</option>
							<option>Kwantlen Polytechnic University</option>
							<option>Royal Roads University</option>
							<option>Simon Fraser University</option>
							<option>Thompson Rivers University</option>
							<option>University of British Columbia</option>
							<option>University of Victoria</option>
							<option>University of the Fraser Valley</option>
							<option>University of Northern British Columbia</option>
							<option>Vancouver Island University</option>
							<option>Brandon University</option>
							<option>University College of the North</option>
							<option>University of Manitoba</option>
							<option>University of Winnipeg</option>
							<option>Mount Allison University</option>
							<option>St. Thomas University</option>
							<option>University of New Brunswick</option>
							<option>Université de Moncton</option>
							<option>Memorial University of Newfoundland</option>
							<option value="1403204">Acadia University</option>
							<option>Cape Breton University</option>
							<option>Dalhousie University</option>
							<option>Mount Saint Vincent University</option>
							<option>Nova Scotia College of Art and Design</option>
							<option>Saint Francis Xavier University</option>
							<option>Saint Mary's University</option>
							<option>Université Sainte-Anne</option>
							<option>-University of King's College</option>
							<option>Algoma University</option>
							<option>Brock University</option>
							<option>Carleton University</option>
							<option>Lakehead University</option>
							<option>Laurentian University</option>
							<option>McMaster University</option>
							<option>Nipissing University</option>
							<option>Ontario College of Art and Design University</option>
							<option>Queen's University (at Kingston)</option>
							<option>Royal Military College of Canada</option>
							<option>Algoma University</option>
							<option>Brock University</option>
							<option>Carleton University</option>
							<option>Lakehead University</option>
							<option>Laurentian University</option>
							<option>McMaster University</option>
							<option>Nipissing University</option>
							<option>Ontario College of Art and Design University</option>
							<option>Queen's University at Kingston</option>
							<option>Royal Military College of Canada</option>
							<option>Ryerson University</option>
							<option>Trent University</option>
							<option>Université de l'Ontario</option>
							<option>University of Guelph</option>
							<option>Ontario Tech University</option>
							<option>University of Ottawa</option>
							<option>University of Toronto</option>
							<option>University of Waterloo</option>
							<option>University of Western Ontario</option>
							<option>University of Windsor</option>
							<option>Wilfrid Laurier University</option>
							<option>York University</option>
							<option>University of Prince Edward Island</option>
							<option>Bishop's University</option>
							<option>Concordia University</option>
							<option>École de technologie supérieure</option>
							<option>École nationale d'administration publique</option>
							<option>Institut national de la recherche scientifique</option>
							<option>McGill University</option>
							<option>Université de Montréal</option>
							<option>Université de Sherbrooke</option>
							<option>Université du Québec en Abitibi-Témiscamingue</option>
							<option>Université du Québec en Outaouais</option>
							<option>Université du Québec à Chicoutimi</option>
							<option>Université du Québec à Montréal</option>
							<option>Université du Québec à Rimouski</option>
							<option>Université du Québec à Trois-Rivières</option>
							<option>Université Laval</option>
							<option>University of Regina</option>
							<option>University of Saskatchewan</option>
							<option>Yukon University</option>
							<option>Fairleigh Dickinson University</option>
							<option>New York Institute of Technology</option>
							<option>Quest University</option>
							<option>Niagara University</option>
							<option>Trinity Western University</option>
							<option>University Canada West</option>
							<option>Booth University College</option>
							<option>Canadian Mennonite University</option>
							<option>Kingswood University</option>
							<option>Crandall University</option>
							<option>St. Stephen's University</option>
							<option>University of Fredericton</option>
							<option>Atlantic School of Theology</option>
							<option>Tyndale University 	Toronto</option>
							<option>Redeemer University College</option>
							<option>The King's University</option>
						</optgroup>
                    </select>
                </div>
            </div>
            <div id="HS_GradDateSet" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    Most recent graduation year:<span class="clf-d-requiredmark">*</span>
                </div>
                <div id="HS_GradDateDiv" class="clf-d-control" formcontrol="y">
                    <select name="HS_GradDate_Year" id="HS_GradDate_Year" controlname="HS_GradDate">
                        <option selected="selected" value="1900">Year</option>
                        <option value="2027">2027</option>
                        <option value="2026">2026</option>
                        <option value="2025">2025</option>
                        <option value="2024">2024</option>
                        <option value="2023">2023</option>
                        <option value="2022">2022</option>
                        <option value="2021">2021</option>
                        <option value="2020">2020</option>
                        <option value="2019">2019</option>
                        <option value="2018">2018</option>
                        <option value="2017">2017</option>
                        <option value="2016">2016</option>
                        <option value="2015">2015</option>
                        <option value="2014">2014</option>
                        <option value="2013">2013</option>
                        <option value="2012">2012</option>
                        <option value="2011">2011</option>
                        <option value="2010">2010</option>
                        <option value="2009">2009</option>
                        <option value="2008">2008</option>
                        <option value="2007">2007</option>
                        <option value="2006">2006</option>
                        <option value="2005">2005</option>
                        <option value="2004">2004</option>
                        <option value="2003">2003</option>
                        <option value="2002">2002</option>
                        <option value="2001">2001</option>
                        <option value="2000">2000</option>
                        <option value="1999">1999</option>
                        <option value="1998">1998</option>
                        <option value="1997">1997</option>
                        <option value="1996">1996</option>
                        <option value="1995">1995</option>
                        <option value="1994">1994</option>
                        <option value="1993">1993</option>
                        <option value="1992">1992</option>
                        <option value="1991">1991</option>
                        <option value="1990">1990</option>
                        <option value="1989">1989</option>
                        <option value="1988">1988</option>
                        <option value="1987">1987</option>
                        <option value="1986">1986</option>
                        <option value="1985">1985</option>
                        <option value="1984">1984</option>
                        <option value="1983">1983</option>
                        <option value="1982">1982</option>
                        <option value="1981">1981</option>
                        <option value="1980">1980</option>
                        <option value="1979">1979</option>
                        <option value="1978">1978</option>
                        <option value="1977">1977</option>
                        <option value="1976">1976</option>
                        <option value="1975">1975</option>
                        <option value="1974">1974</option>
                        <option value="1973">1973</option>
                        <option value="1972">1972</option>
                        <option value="1971">1971</option>
                        <option value="1970">1970</option>
                        <option value="1969">1969</option>
                        <option value="1968">1968</option>
                        <option value="1967">1967</option>
                        <option value="1966">1966</option>
                        <option value="1965">1965</option>
                        <option value="1964">1964</option>
                        <option value="1963">1963</option>
                        <option value="1962">1962</option>
                        <option value="1961">1961</option>
                        <option value="1960">1960</option>
                    </select>
                </div>
            </div>
            <div id="ProgramIDSet" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    Program:
                </div>
                <div id="ProgramIDDiv" class="clf-d-control" formcontrol="y">
                    <select name="ProgramID" id="ProgramID">
                        <option value="0">Select</option>
                        <option value="41149">Academic Upgrading</option>
                        <option value="41244">Business Management and Entrepreneurship (Jan)</option>
                        <option value="38795">Business Management and Entrepreneurship (Sept)</option>
                        <option value="37926">Child and Youth Care</option>
                        <option value="37903">Dental Assistant</option>
                        <option value="37920">Dental Hygiene</option>
                        <option value="37927">Early Childhood Education/EA</option>
                        <option value="39089">Human Services Counselor</option>
                        <option value="37921">Medical Laboratory Assistant</option>
                        <option value="41201">Medical Laboratory Technology</option>
                        <option value="37922">Medical Office Administration</option>
                        <option value="41194">Medical Office Administration - Integrated French</option>
                        <option value="39091">Optician</option>
                        <option value="37929">Paralegal/Legal Assistant</option>
                        <option value="41195">Paralegal/Legal Assistant - Integrated French</option>
                        <option value="37928">Policing and Corrections Foundation</option>
                        <option value="41172">Practical Nurse (Feb)</option>
                        <option value="38734">Practical Nurse (Sept)</option>
                        <option value="41175">Primary Care Paramedic (Feb)</option>
                        <option value="39708">Primary Care Paramedic (Sept)</option>
                        <option value="41245">Sales, Marketing and Business Development (Jan)</option>
                        <option value="39090">Sales, Marketing and Business Development (Sept)</option>
                        <option value="37931">Systems Management and Cybersecurity</option>
                        <option value="37932">Travel and Hospitality</option>
                        <option value="41061">Veterinary Assistant</option>
                        <option value="41243">Veterinary Technician (Feb)</option>
                        <option value="37925">Veterinary Technician (Sept)</option>
                        <option value="37930">Web and Mobile Development</option>
                    </select>
                </div>
            </div>
            <div id="Test" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    Test needing alternate arrangements (Proctor):
                </div>
                <div id="TestNeedingProctor" class="clf-d-control" formcontrol="y">
                    <input name="testTitle" id="testTitle" type="text" maxlength="50" />
                </div>
            </div>
            <div id="Comment1Set" class="clf-d-fieldset" fieldset="y">
                <div class="clf-d-label">
                    Questions or additional background information?
                </div><div id="Comment1Div" class="clf-d-control" formcontrol="y">
                    <textarea name="Comment1" rows="4" cols="20" id="Comment1"></textarea>
                </div>
            </div>
            <div id="ReceiveMessageFieldSet" class="clf-d-fieldset" fieldset="y">
                <div id="ReceiveMessageDiv" class="clf-d-control clf-form-crbox" formcontrol="y">
                    <div class="clf-text-italic clf-padding-small">
                        Please Email me information about your School and Programs. I may opt out at any time.        
                    </div>
                    <table id="ReceiveMessage" controlname="ReceiveMessage" border="0">
                        <tbody><tr>
                                <td><input id="ReceiveMessage_0" type="checkbox" name="ReceiveMessage$0"><label for="ReceiveMessage_0">Do you give permission for Oulton College to periodically email you news and updates? You may withdraw consent at any time. </label></td>
                            </tr><tr>
                                <td><input id="ReceiveMessage_1" type="checkbox" name="ReceiveMessage$1"><label for="ReceiveMessage_1">I would like to receive Text Messages about your School and Programs. I may opt out at any time.</label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <input type="hidden" name="FormToken" value="6af64553-f46d-49b4-a7b7-feb369b8c048" />
        <input type="submit" name="request" value="Request Proctoring" />
	</div>
</div>
<jsp:include page="/footer.jsp"></jsp:include>
