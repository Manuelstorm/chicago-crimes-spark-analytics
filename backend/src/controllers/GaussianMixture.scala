
import org.apache.spark.ml.clustering.GaussianMixture
import org.apache.spark.sql.{DataFrame, SparkSession}

//ID,Case Number,Date,Block,IUCR,Primary Type,Description,Location Description,
// Arrest,Domestic,Beat,District,Ward,Community Area,FBI Code,X Coordinate,Y Coordinate,
// Year,Updated On,Latitude,Longitude,Location

object GaussianMixtureOnCrimes extends App{
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

  val df = dataFrame.select("Year").cache()

  val gmm = new GaussianMixture().setK(3).setSeed(0L)

  // Addestramento del modello
  val model = gmm.fit(df)

  // Previsioni sui nuovi dati
  val predictions = model.transform(df)

  predictions.show()

}
