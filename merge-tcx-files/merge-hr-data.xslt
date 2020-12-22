<!--
	Replace any existing heart rate data in a TCX workout file with
	data from a separate TCX file containing the heart rate data for
	the same time period.

	Assumes that the times are not identical, but
	- both _start with_ yyyy-mm-ddTHH:MM:SS
	- both have the same offset from UTC
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gar="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2"
>

	<!-- heart rate trackpoint data from this file -->
	<xsl:param name="hrFile" select="'hr.tcx'"/>

	<xsl:variable name="hrData" select="document($hrFile)"/>

	<!-- build an index for quick lookups in the template below.
	     Only the first 19 chars will match between the files (yyyy-mm-ddTHH:MM:SS) -->
	<xsl:key name="dt2pt" match="//gar:Trackpoint" use="substring(gar:Time,1,19)"/>

	<xsl:output indent="yes"/>

	<!-- identity transform; overridden by more specific templates below -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- replace any heart rate info from the workout file with that in the heart rate file -->
	<xsl:template match="gar:Trackpoint">
		<xsl:copy>
			<!-- process all nodes under the Trackpoint, except for heart rate data -->
			<xsl:apply-templates select="@* | node()[not(local-name() = 'HeartRateBpm')]"/>

			<xsl:variable name="currDt" select="substring(gar:Time,1,19)"/>
			<!-- use "for-each" trick to change context to the lookup file, and pull the heart rate data -->
			<xsl:for-each select="$hrData">
				<xsl:copy-of select="key('dt2pt',$currDt)/gar:HeartRateBpm"/>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
