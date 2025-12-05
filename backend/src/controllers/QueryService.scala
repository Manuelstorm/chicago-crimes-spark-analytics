package com.crimes.controllers

import org.apache.spark.sql.functions._
import org.apache.spark.sql.{DataFrame, SparkSession}

//ID,Case Number,Date,Block,IUCR,Primary Type,Description,Location Description,
// Arrest,Domestic,Beat,District,Ward,Community Area,FBI Code,X Coordinate,Y Coordinate,
// Year,Updated On,Latitude,Longitude,Location

class QueryService {
  val sparkSession: SparkSession = SparkSession.builder
    .appName("test")
    .master("local[6]")
    .getOrCreate()

  import sparkSession.implicits._

  val dataFrame = sparkSession.read.format("csv")
    .option("sep", ",")
    .option("inferSchema", "true")
    .option("header", "true")
    .load("C:\\Users\\jacop\\Downloads\\Crimes_-_2001_to_Present.csv")
    //.load("C:\\Users\\jacop\\Downloads\\ProveCrimini.csv").cache()

  val df = dataFrame.select("Date","Primary Type", "Community Area", "Year").cache()

  def crimeAnno(dataf: DataFrame, anno: Int): DataFrame = {
    dataf.filter(s"Year==$anno").toDF()
  }

  def raggruppaMeseInAnno(dataf: DataFrame, anno: Int): DataFrame = {
    val specificYear = crimeAnno(dataf, anno)
    val specificMonth = specificYear.withColumn("Date", substring(col("Date"), 0, 2))
    specificMonth.groupBy(col("Date")).count().sort(col("Date").asc)  //sorted
  }

  def generaClassifica(dataf: DataFrame, colName: String, n: Int): DataFrame = {
    val conteggiati = dataf.groupBy(colName).count()
    val countToList = conteggiati.select("count").map(f => f.getAs[Long](0)).collect().toList
    conteggiati.filter(col("count").geq(sortList(countToList, n))).toDF()
  }

  def sortList(items: List[Long], n: Int): Long = {
    items.distinct.sorted(Ordering[Long].reverse).apply(n - 1)
  }

  def groupByAnno(dataf: DataFrame): DataFrame = {
    val conteggiati = dataf.groupBy("Year").count().sort(col("Year").asc)
    conteggiati
  }

  def firstFiveTypes(dataFrame: DataFrame) = {
    generaClassifica(dataFrame, "Primary Type", 5)
  }

  def distribuzioneOrario(dataf: DataFrame): DataFrame = {
    val numMattina = crimedHours(dataf,"mattina")
    val numPomeriggio = crimedHours(dataf,"pomeriggio")
    val numSera = crimedHours(dataf,"sera")
    val numNotte = crimedHours(dataf,"notte")

    val lista: List[Long] = List(numMattina, numPomeriggio, numSera, numNotte)
    val rdd = sparkSession.sparkContext.parallelize(lista)
    val indexRdd = rdd.zipWithIndex.map { case (index,value) => (s"$index", value) }
    indexRdd.toDF()
  }

  def crimedHours(dataf: DataFrame, fascia: String): Long = {
    val regex = getFasciaOraria(fascia)
    val result = dataf.select($"Date", regexp_extract($"Date", regex, 0).alias("match"))
      .filter(col("match").startsWith("0").or(col("match").startsWith("1"))).count()
    result
  }

  def getFasciaOraria(fascia: String): String = {
    fascia match {
      case "mattina" =>
        "07:\\d{2}(:\\d{2})? AM|08:\\d{2}(:\\d{2})? AM|09:\\d{2}(:\\d{2})? AM|10:\\d{2}(:\\d{2})? AM|11:\\d{2}(:\\d{2})? AM|12:\\d{2}(:\\d{2})? AM"
      case "pomeriggio" =>
        "01:\\d{2}(:\\d{2})? PM|02:\\d{2}(:\\d{2})? PM|03:\\d{2}(:\\d{2})? PM|04:\\d{2}(:\\d{2})? PM|05:\\d{2}(:\\d{2})? PM|06:\\d{2}(:\\d{2})? PM"
      case "sera" =>
        "07:\\d{2}(:\\d{2})? PM |08:\\d{2}(:\\d{2})? PM|09:\\d{2}(:\\d{2})? PM|10:\\d{2}(:\\d{2})? PM|11:\\d{2}(:\\d{2})? PM|12:\\d{2}(:\\d{2})? PM"
      case "notte" =>
        "01:\\d{2}(:\\d{2})? AM|02:\\d{2}(:\\d{2})? AM|03:\\d{2}(:\\d{2})? AM|04:\\d{2}(:\\d{2})? AM|05:\\d{2}(:\\d{2})? AM|06:\\d{2}(:\\d{2})? AM"
    }
  }

  def getOrderedCA(dataf: DataFrame): DataFrame={
    dataf.groupBy("Community Area").count().sort(col("Community Area").asc).toDF()
  }

  df.count()

}


