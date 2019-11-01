<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"

	xmlns:gpx="http://www.topografix.com/GPX/1/1"
	xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1"
	xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3"

	xmlns:tcx="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2"
>

	<xsl:output method="text" omit-xml-declaration="yes" indent="no" />

	<!-- override the default template that prints all text -->
	<xsl:template match="text()|@*" />

	<!-- Output all the data from gpx track points -->
	<xsl:template match="gpx:trkpt">
		<xsl:value-of select="concat(gpx:time,',',@lat,',',@lon,',',gpx:ele,',',gpx:extensions/gpxtpx:TrackPointExtension/gpxtpx:hr)" />
		<xsl:text>&#xA;</xsl:text>
	</xsl:template>

	<!-- Output all the data from tcx track points -->
	<xsl:template match="tcx:Trackpoint">
		<xsl:value-of select="concat(tcx:Time,',',tcx:Position/tcx:LatitudeDegrees,',',tcx:Position/tcx:LongitudeDegrees,',',tcx:AltitudeMeters,',',tcx:HeartRateBpm/tcx:Value)" />
		<xsl:text>&#xA;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
