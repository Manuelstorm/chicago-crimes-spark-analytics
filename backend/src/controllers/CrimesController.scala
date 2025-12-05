package com.crimes.controllers
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions.col
import org.springframework.web.bind.annotation.{GetMapping, RequestMapping, RequestParam, RestController}

@RestController
@RequestMapping()
class CrimesController {

  val queryService = new QueryService()

  @GetMapping(Array("/types"))
  def getPrimaryTypes: String = {
    val classificaTipi = queryService.firstFiveTypes(queryService.df)
    tojsonString(classificaTipi)
  }

  @GetMapping(Array("/areas"))
  def getByArea() : String = {
    val classificaArea = queryService.generaClassifica(queryService.df, "Community Area", 5)
    tojsonString(classificaArea)
  }

  @GetMapping(Array("/years"))
  def getByYear(): String = {
    val groupedByYear = queryService.groupByAnno(queryService.df)
    tojsonString(groupedByYear)
  }

  @GetMapping(Array("/months"))
  def getMonthsByYear(@RequestParam(value = "year", defaultValue = "2001") year: Int): String = {
    val groupedByMonth = queryService.raggruppaMeseInAnno(queryService.df, year)
    tojsonString(groupedByMonth)
  }

  @GetMapping(Array("/yearsByType"))
  def getYearsByType(@RequestParam(value = "tipo") tipo: String): String = {
    val specificType = queryService.df.filter(col("Primary Type").equalTo(tipo))
    val typeGroupedByYear = queryService.groupByAnno(specificType)
    tojsonString(typeGroupedByYear)
  }

  @GetMapping(Array("/yearsByArea"))
  def getYearsByArea(@RequestParam(value = "area") area: String): String = {
    val specificArea = queryService.df.filter(col("Community Area").equalTo(area))
    val areaGroupedByYear = queryService.groupByAnno(specificArea)
    tojsonString(areaGroupedByYear)
  }

  @GetMapping(Array("/getMonthByType"))
  def getMonthsByYearAndTipo(@RequestParam(value = "year") year: Int, @RequestParam( value = "tipo") tipo: String): String = {
    val specificType = queryService.df.filter(col("Primary Type").equalTo(tipo))
    val typeGroupedByMonth = queryService.raggruppaMeseInAnno(specificType, year)
    tojsonString(typeGroupedByMonth)
  }

  @GetMapping(Array("/getMonthByArea"))
  def getMonthsByYearAndArea(@RequestParam(value = "year") year: Int, @RequestParam( value = "area") area: String): String = {
    val specificArea = queryService.df.filter(col("Community Area").equalTo(area))
    val areaGroupedByMonth = queryService.raggruppaMeseInAnno(specificArea, year)
    tojsonString(areaGroupedByMonth)
  }

  @GetMapping(Array("/getTypesByArea"))
  def getTypesByArea(@RequestParam( value = "area") area: String): String = {
    val specificArea = queryService.df.filter(col("Community Area").equalTo(area))
    val areaRankedByType = queryService.firstFiveTypes(specificArea)
    tojsonString(areaRankedByType)
  }

  @GetMapping(Array("/getOrariByType"))
  def getOrari(@RequestParam(value="tipo") tipo: String): String = {
    val specificType = queryService.df.filter(col("Primary Type").equalTo(tipo))
    val fasceOrarieByType = queryService.distribuzioneOrario(specificType)
    tojsonString(fasceOrarieByType)
  }

  @GetMapping(Array("/getAreas"))
  def getAreas():String={
    val orderedCommunityAreas = queryService.getOrderedCA(queryService.df)
    tojsonString(orderedCommunityAreas)
  }

  def tojsonString(dataFrame: DataFrame) :String = {
    val jsonresult = dataFrame.toJSON.collect().mkString(",")
    "[" + jsonresult + "]"
  }


}
