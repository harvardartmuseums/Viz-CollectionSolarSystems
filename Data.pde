JSONObject loadTerms(String termField, String filterField, String filterValue) {
  JSONObject json;
  String url = baseURL + "?apikey=" + apiKey;
  
  if (filterField != "") {
    try {
      url+= "&" + filterField + "=" + URLEncoder.encode(filterValue, "UTF-8");
    } catch (Exception e) {}
  }
  
  url+= "&size=0&facet=" + termField; 
  
  json = loadJSONObject(url);
  
  return json;
}

SolarSystem[] loadData() {
  SolarSystem[] solarSystems_;
  JSONObject data;
  
  data = loadTerms(facetField, "", "");
  
  JSONObject info = data.getJSONObject("info");
  int totalRecords = info.getInt("totalrecords");
  
  universePopulation = totalRecords;
  
  JSONObject facets = data.getJSONObject("facets");
  JSONObject facet = facets.getJSONObject(facetField);
  JSONArray terms = facet.getJSONArray("terms");  
    
  solarSystems_ = new SolarSystem[terms.size()];
  
  for(int i=0; i<terms.size(); i++) {
    JSONObject term = terms.getJSONObject(i); 
    
    SolarSystem solarSystem = new SolarSystem(term.getString("term"), map(term.getInt("count"), 0, totalRecords, 0, 5000), term.getInt("count"));

    solarSystems_[i] = solarSystem;
    
    // Load the planets and add them to the solar system
    JSONObject planetData = loadTerms(secondaryFacetField, facetField, solarSystem.name);
    
    JSONObject planetInfo = planetData.getJSONObject("info");
    int totalPlanetRecords = planetInfo.getInt("totalrecords");
    
    JSONObject planetFacets = planetData.getJSONObject("facets");
    JSONObject planetFacet = planetFacets.getJSONObject(secondaryFacetField);
    JSONArray planetTerms = planetFacet.getJSONArray("terms");      
    
    int planetCount = 0;
    for(int p=0; p<planetTerms.size(); p++) {
      JSONObject planetTerm = planetTerms.getJSONObject(p); 
      
      if (planetTerm.getInt("count") > 0) {
        planetCount+=1;
        solarSystem.addPlanet(new Planet(planetTerm.getString("term"), map(planetTerm.getInt("count"), 0, totalPlanetRecords, 0, 1000), planetTerm.getInt("count"), planetCount));
      }
    }
    
    println(solarSystem.name + ", " + solarSystem.size + ", " + solarSystem.population + ", " + solarSystem.planets.length);
  }
  
  return solarSystems_;
}
