JSONObject loadTheUniverse() {
  JSONObject json;
  String url = baseURL + "?apikey=" + apiKey;
  
  url+= "&size=0&aggregation={\"by_classification\":{\"terms\":{\"field\":\"classification.exact\",\"size\":0},\"aggs\":{\"by_century\":{\"terms\":{\"field\":\"century\",\"size\":0}}}}}"; 
  
  json = loadJSONObject(url);
  
  return json;
}

SolarSystem[] loadData() {
  SolarSystem[] solarSystems_;
  JSONObject data;
  
  data = loadTheUniverse();
  
  JSONObject info = data.getJSONObject("info");
  int totalRecords = info.getInt("totalrecords");
  
  universePopulation = totalRecords;
  
  JSONObject facets = data.getJSONObject("aggregations");
  JSONObject facet = facets.getJSONObject("by_classification");
  JSONArray terms = facet.getJSONArray("buckets");  
    
  solarSystems_ = new SolarSystem[terms.size()];
  
  for(int i=0; i<terms.size(); i++) {
    JSONObject term = terms.getJSONObject(i); 
    
    SolarSystem solarSystem = new SolarSystem(term.getString("key"), map(term.getInt("doc_count"), 0, totalRecords, 0, 5000), term.getInt("doc_count"));

    solarSystems_[i] = solarSystem;
    
    // Load the planets and add them to the solar system
    JSONObject planetData = term.getJSONObject("by_century");
     
    int totalPlanetRecords = term.getInt("doc_count");
    
    JSONArray planetTerms = planetData.getJSONArray("buckets");      
    
    int planetCount = 0;
    for(int p=0; p<planetTerms.size(); p++) {
      JSONObject planetTerm = planetTerms.getJSONObject(p); 
      
      if (planetTerm.getInt("doc_count") > 0) {
        planetCount+=1;
        solarSystem.addPlanet(new Planet(planetTerm.getString("key"), map(planetTerm.getInt("doc_count"), 0, totalPlanetRecords, 0, 1000), planetTerm.getInt("doc_count"), planetCount));
      }
    }
    
    println(solarSystem.name + ", " + solarSystem.size + ", " + solarSystem.population + ", " + solarSystem.planets.length);
  }
  
  return solarSystems_;
}
