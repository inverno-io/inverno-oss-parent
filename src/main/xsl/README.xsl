<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pom="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform https://www.w3.org/2007/schema-for-xslt20.xsd
		http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"
	xmlns:xslFormatting="urn:xslFormatting">

<xsl:output indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="/">
# Winter OSS Parent

The Winter OSS parent POM provides OSS dependencies and plugin management to Winter components and applications.

<xsl:apply-templates select="/pom:project/pom:dependencyManagement/pom:dependencies"/>
<xsl:text>
</xsl:text>
<xsl:apply-templates select="/pom:project/pom:build/pom:pluginManagement/pom:plugins"/>

</xsl:template>

<xsl:template match="pom:dependencies">
## Dependencies

<table style="margin: auto;">
	<tr>
		<th>GroupId</th>
		<th>ArtifactId</th>
		<th>Version</th>
	</tr>
	<xsl:apply-templates select="pom:dependency">
		<xsl:sort select="pom:groupId"/>
		<xsl:sort select="pom:artifactId"/>
	</xsl:apply-templates>
</table>
</xsl:template>

<xsl:template match="pom:dependency">
<tr>
	<td><xsl:value-of select="pom:groupId"/></td>
	<td><xsl:value-of select="pom:artifactId"/></td>
	<td><xsl:call-template name="getVersion"><xsl:with-param name="versionTag" select="pom:version"/></xsl:call-template></td>
</tr>
</xsl:template>

<xsl:template match="pom:plugins">
## Maven Plugins

<table style="margin: auto;">
	<tr>
		<th>GroupId</th>
		<th>ArtifactId</th>
		<th>Version</th>
	</tr>
	<xsl:apply-templates select="pom:plugin">
		<xsl:sort select="pom:groupId"/>
		<xsl:sort select="pom:artifactId"/>
	</xsl:apply-templates>
</table>
</xsl:template>

<xsl:template match="pom:plugin">
<tr>
	<td><xsl:value-of select="pom:groupId"/></td>
	<td><xsl:value-of select="pom:artifactId"/></td>
	<td><xsl:call-template name="getVersion"><xsl:with-param name="versionTag" select="pom:version"/></xsl:call-template></td>
</tr>
</xsl:template>

<xsl:template name="getVersion">
<xsl:param name="versionTag"/>
<xsl:choose>
	<xsl:when test="starts-with($versionTag, '${')">
		<xsl:value-of select="/pom:project/pom:properties/child::node()[local-name() = substring-after(substring-before($versionTag, '}'), '${')]"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$versionTag"/>
	</xsl:otherwise>
</xsl:choose>

</xsl:template>

</xsl:stylesheet>