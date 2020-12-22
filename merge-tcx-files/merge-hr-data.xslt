<!--
	Note that this XSLT "works", but appears to scan the heart rate
	data for each data point.  Not sure if that's because of the
	substring() call or if xsltproc never indexes the values, but
	the performance of this transformation is only acceptable when
	there ~1000 or fewer workout data points.
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gar="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2"
>

	<!-- heart rate trackpoint data from here -->
	<xsl:param name="hrFile" select="'hr.tcx'" />
	<xsl:param name="hrData" select="document($hrFile)" />
	<xsl:variable name="hr" select="$hrData//gar:Trackpoint" />

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="gar:Time">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()[not(local-name() = 'HeartRateBpm')]"/>
			<xsl:copy>
				<xsl:apply-templates select="$hr[substring(gar:Time,1,19) = substring(current(),1,19)]/HeartRateBpm" />
			</xsl:copy>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
