<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><strong><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>Eight Ways to Simulate Matrix Diffusion and Remediation</span></strong></p>
<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>As of 2022, there are eight general ways to model the impact of matrix diffusion on remediation for Transition Assessments (Table 1). Links to key resources (ESTCP project pages or key papers) are provided. A quick selection guide is provided below:</span></p>
<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>For a <strong>quick screening&nbsp;</strong>model approach:&nbsp;</span></p>
<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>Use Model 1, SERDP Remediation Timeframe Tool in this web page (SERDP TA<sup>2</sup> Tool 3).</span></p>
<ul style="list-style-type: undefined;margin-left:0in;">
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Key Application: How long does it take to reach cleanup goals after a source is completely removed?</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Typical time required: 2-6 hours.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Advantages: Simplest, quickest model. Provides uncertainty limit.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Disadvantages: Only applicable to a subset of site data, cannot simulate partial source in-situ remediation projects*, assumes 1-D groundwater flow.</span></li>
</ul>
<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>For a <strong>mid-level model,&nbsp;</strong>use Model 2, REMChlor-MD (Falta et al., 2018, Farhat et al., 2018). See the next tab for more detailed instructions on how to use REMChlor-MD for TAs.</span></p>
<ul style="list-style-type: undefined;margin-left:0in;">
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Key Application: How long does it take to reach cleanup goals after a source and/or plume remediation project?</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Typical time required: 2-4 days.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Advantages: Detailed guidance, including the last tab in SERDP TA<sup>2</sup> Tool 5. Can simulate in-situ source remediation projects that typically don&rsquo;t remove all the mass.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Disadvantages: Calibration can be time consuming. Assumes 1-D groundwater flow. Requires estimate of total contaminant mass released to the subsurface and initial source concentration when the release first started. Cannot simulate multiple source remediation projects.&nbsp;</span></li>
</ul>
<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>For more <strong>complex modeling</strong>, use Model 3, MODFLOW 6 or MODFLOW-USG with the Matrix Diffusion Transport Package (MDT).</span></p>
<ul style="list-style-type: undefined;margin-left:0in;">
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Key Application: How long does it take to reach cleanup goals after a source and/or plume remediation project?</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Typical time required: 2-4 weeks.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Advantages: Existing MODFLOW / MT3D datasets can be used and augmented with matrix diffusion model input. Can simulate in-situ source remediation projects that typically don&rsquo;t remove all the mass. Can handle 3-D groundwater flow patterns and pumping wells. Best tool for modeling pump and treat systems.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Disadvantages: More complex model setup, calibration. Source concentration / mass flux input data often need to develop externally outside the model. Only a beta version available now with no document. Complete version likely not available until Fall 2022.&nbsp;</span></li>
</ul>

<style>
figcaption {
  text-align: center;
  font-size: 18pt;
}
</style>

<div class="col-md-4" style = "text-align: center;">
<a href="#top" onclick="$('li:eq(5) a').tab('show');" role="button">
<figure>
  <img src="05_Matrix/FIG/Tool5c_fig1.png" width= 468 height=459 class="center">
  <figcaption>Model 1</figcaption>
</figure>
</a>
</div>

<div class="col-md-4" style = "text-align: center;">
<a href="https://serdp-estcp.org/Program-Areas/Environmental-Restoration/Contaminated-Groundwater/Persistent-Contamination/ER-201426/(language)/eng-US" target="_blank">
<figure>
  <img src="05_Matrix/FIG/Tool5c_fig2.png" width= 468 height=291 class="center">
  <figcaption>Model 2</figcaption>
</figure>
</a>
</div>

<div class="col-md-4" style = "text-align: center;">
<a href="https://serdp-estcp.org/Tools-and-Training/Environmental-Restoration/Groundwater-Plume-Treatment/Matrix-Diffusion-Tool-Kit" target="_blank">
<figure>
  <img src="05_Matrix/FIG/Tool5c_fig3.png" width= 468 height=421 class="center">
  <figcaption>Model 3</figcaption>
</figure>
</a>
</div>



<div class="col-md-12" style = "text-align: justify;">

<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>The other five models have different strengths and applicability.&nbsp;</span></p>
<ul style="list-style-type: undefined;margin-left:0in;">
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Model 4 (ESTCP Matrix Diffusion Toolkit) in Table 1 is a free ESTCP spreadsheet tool with two different matrix diffusion models are applicable to sites where a plume is in contact with a low-k aquitard overlying or underlying the plume. The &ldquo;Square Root Model&rdquo; in this toolkit is relatively easy to run.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Models 5, 6, and 7 in Table 1 are all &ldquo;fixes&rdquo; or &ldquo;hacks&rdquo; to use existing MODFlOW/MT3D type finite differences so that they can more accurately account for matrix diffusion. As described above, current finite difference groundwater transport models can have problems modeling matrix diffusion unless relatively thin vertical layers are used. Note that Model 3 (MODFLOW with the Matrix Diffusion Transport Package (MDT)) will likely supersede Models 5, 6, and 7 when it is completed in the Fall of 2022.</span></li>
    <li><span style='line-height:107%;font-family:"Arial",sans-serif;font-size:16px;'>Model 8 is a note on one of the first models that approximated matrix diffusion effects, the original REMChlor model. It has now been superseded by Model 2, REMChlor-MD.</span></li>
</ul>
<p style='margin-top:0in;margin-right:0in;margin-bottom:8.0pt;margin-left:0in;line-height:107%;font-size:15px;font-family:"Calibri",sans-serif;'><span style='font-size:16px;line-height:107%;font-family:"Arial",sans-serif;'>*(complete source remediation is unlikely in many cases, see SERDP TA<sup>2</sup> Tool 4)</span></p>
</div>

<div align=center>
<table class="center" class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width=1164
 style='width:872.7pt;border-collapse:collapse;mso-yfti-tbllook:1184;
 mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:25.25pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-bottom:
  solid white 3.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:25.25pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;text-align:center'><b><span
  style='color:white;mso-themecolor:background1'>MODEL / MODELING APPROACH</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 style='width:211.5pt;border-top:solid white 1.0pt;border-left:
  none;border-bottom:solid white 3.0pt;border-right:solid white 1.0pt;
  mso-border-left-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:25.25pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;text-align:center'><b><span
  style='color:white;mso-themecolor:background1'>DESCRIPTION</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=288 style='width:3.0in;border-top:solid white 1.0pt;border-left:
  none;border-bottom:solid white 3.0pt;border-right:solid white 1.0pt;
  mso-border-left-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:25.25pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;text-align:center'><b><span
  style='color:white;mso-themecolor:background1'>INPUT DATA</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=294 style='width:220.5pt;border-top:solid white 1.0pt;border-left:
  none;border-bottom:solid white 3.0pt;border-right:solid white 1.0pt;
  mso-border-left-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:25.25pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;text-align:center'><b><span
  style='color:white;mso-themecolor:background1'>COMMENTS</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:108.75pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 3.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:108.75pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>1.
  SERDP Transition Assessment Assistant Tool 3 - Borden Remediation Timeframe
  Model<br>
  </span><span style='color:yellow'>(SERDP TA<sup>2 </sup>Tool 3)<br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://www.sciencedirect.com/science/article/abs/pii/S0169772221001285?via%3Dihub" target="_blank"><b><span
  style='color:yellow'>(Borden and Cha, 2021)</span></b></a></span><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 3.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:108.75pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>A simple web-based model
  that estimates the number of years it will take to reduce source
  concentrations by 90%, 99%, or 99.9%. The Tool was developed by Dr. Bob
  Borden (Borden and Cha, 2021) and is based on the REMChlor-MD model.</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 3.0pt;mso-border-left-alt:solid white 1.0pt;background:#CCD2DE;
  padding:.75pt 5.4pt 0in 5.4pt;height:108.75pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Source release and source
  remediation dates. Hydrogeologic data to calculate seepage velocity.
  Transport data such as retardation factors. Distance to a point of
  compliance. Nature of geologic heterogeneity (aquitards or layers/lenses or
  both). </span><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 3.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:108.75pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>New model developed for this
  web tool. Includes an uncertainty calculation approach to describe the
  remediation timeframe results as a range of values. </span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:108.75pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:108.75pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>2.
  ESTCP REMChlor-MD Model<br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://www.serdp-estcp.org/Program-Areas/Environmental-Restoration/Contaminated-Groundwater/Persistent-Contamination/ER-201426" target="_blank"><b><span
  style='color:yellow'>(ESTCP Project ER-201426)</span></b></a></span><b><span
  style='color:yellow'> <br>
  (Falta et al., 2018; Farhat et al., 2018)</span></b><span style='color:white;
  mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:108.75pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>As of 2022, perhaps the best
  balance of simplicity and power for transition assessment modeling.
  REMChlor-MD simulates matrix diffusion using a semi-analytical model based on
  heat transfer equations (Falta et al., 2018). However, it can only simulate
  1-D flow fields</span><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#E7EAEF;
  padding:.75pt 5.4pt 0in 5.4pt;height:108.75pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Groundwater flow,
  contaminant transport, and source information. The user describes if any
  thick aquitards overlie or underlie the plume, and the heterogeneity
  calculator in REMChlor-MD provides users with an option to enter boring logs
  to generate three key values: 1) transmissive zone volume fraction; 2)
  average diffusion length; and 3) surface area of low-k interfaces.</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:108.75pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>REMChlor-MD is first the
  model to specifically relate stratigraphic data to matrix diffusion input
  parameters. It assumes the entire plume is in contact with the same geologic
  heterogeneity and assumes 1-dimensional groundwater flow. Can simulate low-k
  layers, different configurations / density of low-k lenses based on boring
  logs. Can simulate source remediation, plume remediation or both.</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:141.15pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:141.15pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>3.
  MODFLOW with Matrix Diffusion Transport (MDT) Package <br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://www.serdp-estcp.org/Program-Areas/Environmental-Restoration/Contaminated-Groundwater/Persistent-Contamination/ER19-5028" target="_blank"><b><span
  style='color:yellow'>(ESTCP ER-19-5028)</span></b></a></span><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>&nbsp;</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>&nbsp;</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>&nbsp;</span></b><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:141.15pt'>
  <p style='margin:0in'><span style='font-size:11.0pt;font-family:"Calibri",sans-serif;mso-ascii-theme-font:
  minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Commonly used numerical
  groundwater contaminant transport models (MODFLOW-USG and MODFLOW-6) with new
  Matrix Diffusion Transport (MDT) Package. This new package includes the matrix
  diffusion method that was developed for REMChlor-MD. It allows for much more
  efficient and accurate simulation of matrix diffusion. </span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#CCD2DE;
  padding:.75pt 5.4pt 0in 5.4pt;height:141.15pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>3-D stratigraphic,
  hydrogeologic, plume, and source data for a groundwater plume. Unstructured
  grid array with many thin layers to represent site stratigraphy for plume. </span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:141.15pt'>
  <p style='margin:0in'><span style='font-size:11.0pt;font-family:"Calibri",sans-serif;mso-ascii-theme-font:
  minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>In development as part of
  ESTCP Project ER-19-5028. A preliminary beta version for MODFLOW-USG was
  issued in 2021 This project will incorporate the semi-analytical matrix
  diffusion approach into open source, public domain, 3-D chemical transport
  codes for the unstructured grids (MODFLOW-USG and MODFLOW 6). These modified
  FORTRAN codes will then be incorporated into a widely used commercial
  groundwater modeling graphical user interface (Aquaveo Groundwater Modeling
  System [GMS]).</span><span style='font-size:11.0pt;font-family:"Calibri",sans-serif;
  mso-ascii-theme-font:minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-theme-font:
  minor-latin'><o:p></o:p></span></p>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>&nbsp;</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:65.55pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:65.55pt'>
  <p class=MsoNormal style='margin-bottom:0in'><b><span style='color:white;
  mso-themecolor:background1'>4. ESCTP Matrix Diffusion Toolkit <o:p></o:p></span></b></p>
  <p class=MsoNormal style='margin-bottom:0in'><span style='color:black;
  mso-color-alt:windowtext'><a
  href="https://www.serdp-estcp.org/Tools-and-Training/Environmental-Restoration/Groundwater-Plume-Treatment/Matrix-Diffusion-Tool-Kit" target="_blank"><b><span
  style='color:yellow'>(Farhat et al., 2012)</span></b></a></span><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:65.55pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>One of the first matrix
  diffusion focused modeling tools. Two separate analytical matrix diffusion
  models: 1) simpler “Square Root Model” and 2) more sophisticated “Dandy-Sale
  Model”, both spreadsheet-based models. </span><span style='mso-bidi-font-family:
  Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#E7EAEF;
  padding:.75pt 5.4pt 0in 5.4pt;height:65.55pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Loading duration and time
  when transmissive zone is remediated; low-k unit properties; contaminant
  diffusion properties; transmissive zone properties.</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:65.55pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Assumes two layers: a
  transmissive unit and a low-k unit. Cannot simulate low-k lenses or other
  stratigraphic scenarios. Assumes a constant source to groundwater, then
  assumes complete removal of the source.</span><span style='mso-bidi-font-family:
  Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:130.35pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:130.35pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>5.
  MT3DMS / RT3D <br>
  3-D Model with Thin Layers <br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://www.sciencedirect.com/science/article/abs/pii/S0169772212000599?via%3Dihub" target="_blank"><b><span
  style='color:yellow'>(Chapman et al., 2012)</span></b></a></span><b><span
  style='color:yellow'><br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://onlinelibrary.wiley.com/doi/10.1002/rem.21440" target="_blank"><b><span
  style='color:yellow'>(Carey et al., 2015)</span></b></a></span><b><span
  style='color:yellow'><br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://ngwa.onlinelibrary.wiley.com/doi/abs/10.1111/gwmr.12373/" target="_blank"><b><span
  style='color:yellow'>(Farhat et al., 2020)</span></b></a></span><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:130.35pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Existing numerical
  groundwater contaminant transport model. However, as indicated in Chapman et
  al. 2012), Carey et al. (2015) and Farhat et al. (2020) finite difference
  groundwater models may need very thin layering (on the order of centimeters)
  to accurately model matrix diffusion.</span><span style='mso-bidi-font-family:
  Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#CCD2DE;
  padding:.75pt 5.4pt 0in 5.4pt;height:130.35pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Matrix diffusion can be
  modeled successfully if very thin layers are used (on centimeter scale).
  Carey et al. (2015): “Modeling vertical diffusion in a silt or clay lens may
  require the addition of dozens to hundreds of model layers, depending on the
  thickness and number of low-permeability lenses to be represented. This can
  be computationally prohibitive for a numerical model, particularly
  three-dimensional (3-D) models which already incorporate small horizontal
  grid spacing or multiple solutes.”</span><span style='mso-bidi-font-family:
  Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:130.35pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>It may be difficult to model
  large field sites if hundreds of thin vertical grids are used. For example,
  Muskus and Falta (2018) reported that a 3-D MT3D simulation of a DNAPL site
  (3400 ft x 2000 ft x 135 ft thickness required 2.8 million grid blocks (400
  layers) and took “several days” for one simulation. </span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:76.35pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:76.35pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>6.
  MT3DMS / RT3D <br>
  2-D “Bread Slices”<br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3267905/" target="_blank"><b><span
  style='color:yellow'>(Rasa et al., 2011)</span></b></a></span><b><span
  style='color:yellow'><br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://ngwa.onlinelibrary.wiley.com/doi/abs/10.1111/gwmr.12373/" target="_blank"><b><span
  style='color:yellow'>(Farhat et al., 2020)</span></b></a></span><span
  style='color:white;mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:76.35pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Commonly used numerical
  groundwater contaminant transport model, but modeled in a vertical,
  2-dimensional form (X-Z), hence the term “bread slice”. With this approach
  very fine vertical discretization can be employed but only over a portion of
  a field site (typically the centerline of the plume).</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#E7EAEF;
  padding:.75pt 5.4pt 0in 5.4pt;height:76.35pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Centerline stratigraphic,
  hydrogeologic, plume, and source data for a groundwater plume but only for a
  2-D slice through the zone of interest.</span><span style='mso-bidi-font-family:
  Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:76.35pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>This approach has been
  applied successfully by Rasa et al. 2011 and Farhat et al., 2020. But 3-D
  groundwater flow (such as pumping wells or complex groundwater flow fields)
  cannot be simulated directly.</span><span style='mso-bidi-font-family:Calibri;
  mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:87.15pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:87.15pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>7.
  MT3DMS / RT3D <br>
  3-D Model with Dual Domain<br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="http://www.ees.nmt.edu/outside/courses/hyd547/supplemental/MODFLOW_Tutorial/MT3DMS-AdvancedTransport.pdf" target="_blank"><b><span
  style='color:yellow'>(GMS Tutorial)</span></b></a></span><b><span
  style='color:yellow'> </span></b><span style='color:white;mso-themecolor:
  background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:87.15pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Commonly used numerical
  groundwater contaminant transport model, but with a less commonly used
  dual-domain feature activated.</span><span style='mso-bidi-font-family:Calibri;
  mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#CCD2DE;
  padding:.75pt 5.4pt 0in 5.4pt;height:87.15pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>3-D stratigraphic,
  hydrogeologic, plume, and source data for a groundwater plume. In addition,
  the porosity of the immobile phase, initial concentration of the mobile
  phase, and a mass transfer coefficient are required.</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#CCD2DE;padding:.75pt 5.4pt 0in 5.4pt;height:87.15pt'>
  <p style='margin:0in'><span style='font-size:11.0pt;font-family:"Calibri",sans-serif;mso-ascii-theme-font:
  minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>The dual porosity mass
  transfer model typically requires calibration of the mass transfer
  coefficient, and the first-order representation of the matrix diffusion
  concentration gradient may be accurate only under a limited set of
  circumstances (Gaun et al., 2008).</span><span style='font-size:11.0pt;
  font-family:"Calibri",sans-serif;mso-ascii-theme-font:minor-latin;mso-hansi-theme-font:
  minor-latin;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>&nbsp;</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8;mso-yfti-lastrow:yes;height:87.15pt'>
  <td width=300 style='width:224.7pt;border:solid white 1.0pt;border-top:none;
  mso-border-top-alt:solid white 1.0pt;background:#0D609C;padding:.75pt 5.4pt 0in 5.4pt;
  height:87.15pt'>
  <p class=MsoNormal><b><span style='color:white;mso-themecolor:background1'>8.
  Analytical “gamma” model for source zones such as the first version of
  REMChlor (Falta et al., 2005a, b; Falta et al., 2008)</span><span
  style='color:yellow'><br>
  </span></b><span style='color:black;mso-color-alt:windowtext'><a
  href="https://www.epa.gov/water-research/remediation-evaluation-model-chlorinated-solvents-remchlor" target="_blank"
  title="https://www.epa.gov/water-research/remediation-evaluation-model-chlorinated-solvents-remchlor"><b><span
  style='color:yellow'>(USEPA)</span></b></a></span><span style='color:white;
  mso-themecolor:background1'><o:p></o:p></span></p>
  </td>
  <td width=282 valign=top style='width:211.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:87.15pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>A single parameter “gamma”
  is used to relate mass flux over time to source mass. A gamma of two or more
  will create a “long tail” representative of the persistent, slow decline in
  groundwater concentrations caused by matrix diffusion. </span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=288 valign=top style='width:3.0in;border-top:none;border-left:none;
  border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;mso-border-top-alt:
  solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;background:#E7EAEF;
  padding:.75pt 5.4pt 0in 5.4pt;height:87.15pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>Gamma term. Is not directly
  linked to site stratigraphy, loading history, type of contaminant but is a
  general way to generate matrix diffusion effects in a source zone.</span><span
  style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
  <td width=294 valign=top style='width:220.5pt;border-top:none;border-left:
  none;border-bottom:solid white 1.0pt;border-right:solid white 1.0pt;
  mso-border-top-alt:solid white 1.0pt;mso-border-left-alt:solid white 1.0pt;
  background:#E7EAEF;padding:.75pt 5.4pt 0in 5.4pt;height:87.15pt'>
  <p class=MsoNormal><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:
  minor-latin;color:black;mso-font-kerning:12.0pt'>For source zone only, not
  plumes. Used in the first version of REMChlor (before the REMChlor-MD
  version) for the source zone, where near source wells indirectly reflect
  matrix diffusion effects in the source zone. Users now typically use
  REMChlor-MD which accounts for matrix diffusion in both the source and plume.
  </span><span style='mso-bidi-font-family:Calibri;mso-bidi-theme-font:minor-latin'><o:p></o:p></span></p>
  </td>
 </tr>
</table>
</div>

