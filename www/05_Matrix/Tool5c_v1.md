
    
<p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'>Computer models can be used for Transition Assessments by
comparing which particular site risk profiles would improve if additional mass
removal projects <span class=GramE>are</span> implemented; or if the progress
toward reaching remediation goals is constrained by matrix diffusion effects. Therefore,
if modeling is being considered for a Transition Assessment it is important
that a model that can account for matrix diffusion effects be used. As of early
2022, there are several general approaches for performing matrix diffusion
modeling for analyzing remediation scenarios.<o:p></o:p></span></p>

<p class=MsoNormal><b><span style='font-size:12.0pt;line-height:107%;
font-family:"Arial",sans-serif'>Problems with Conventional Models and Matrix
Diffusion</span></b><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'>With the knowledge that significant accumulation of
contaminants can occur in low-k zones at sites, there has been the concurrent
desire to apply groundwater models to estimate future impacts to groundwater
affected by matrix diffusion processes. However, most conventional groundwater
transport models in the 2022 timeframe either do not have the capability to
directly model matrix diffusion, or if they do, they may have accuracy problems
in some cases (Farhat et al., 2020).<o:p></o:p></span></p>

<p class=MsoNormal><b><span style='font-size:12.0pt;line-height:107%;
font-family:"Arial",sans-serif'>Models Less Useful for Transition Assessment
Modeling</span></b><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'>In general, most standard advection-dispersion groundwater
transport models do not simulate matrix diffusion. Both the BIOSCREEN (Newell
et al., 1996) and the BIOCHLOR models (Aziz et al., 1999) do not simulate
remediation scenarios (they are both MNA models) and do not simulate matrix
diffusion. <o:p></o:p></span></p>

<p class=MsoNormal><b><span style='font-size:12.0pt;line-height:107%;
font-family:"Arial",sans-serif'>Potential Problems with Finite Difference
Models</span></b><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'>Conventional applications of most numerical models (like
MODFLOW-MT3D) may not accurately simulate matrix diffusion when applied at
typical field scales (layer thicknesses on the order of meters). Chapman et al.
(2012) describes the problem with conventional numerical models this way:<o:p></o:p></span></p>

<p class=MsoNormal><i><span style='font-size:12.0pt;line-height:107%;
font-family:"Arial",sans-serif'>“A major challenge of diffusion as a governing
process, both in terms of field characterization efforts and incorporation in
numerical models, is that it occurs over small scales relative to the typical
dimensions of plumes. The response of plumes at the scale of 100s to 1000s of
meters can be dependent on concentration gradients that evolve over dimensions
of centimeters or less.”</span></i><span style='font-size:12.0pt;line-height:
107%;font-family:"Arial",sans-serif'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'>Carey et al. (2015) re-emphasized the need for small grid
spacing and <span class=GramE>small time</span> steps when using a finite
difference groundwater transport model like MT3D to simulate matrix diffusion
effects:<o:p></o:p></span></p>

<p class=MsoNormal><i><span style='font-size:12.0pt;line-height:107%;
font-family:"Arial",sans-serif'>“The use of numerical models to simulate
diffusion between transmissive and low-permeability zones requires small grid
spacing and time steps (Chapman et al., 2012; Weatherill et al., 2008).
Modeling vertical diffusion in a silt or clay lens may require the addition of
dozens to hundreds of model layers, depending on the thickness and number of
low-permeability lenses to be represented. This can be computationally
prohibitive for a numerical model, particularly three-dimensional (3-D) models
which already incorporate small horizontal grid spacing or multiple solutes.</span></i><span
style='font-size:12.0pt;line-height:107%;font-family:"Arial",sans-serif'><o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
"Arial",sans-serif'>Farhat et al. (2020) then provided an example of how much
error can occur when using conventional finite difference numerical models to
simulate matrix diffusion. They concluded:<o:p></o:p></span></p>

<p class=MsoNormal><i><span style='font-size:12.0pt;line-height:107%;
font-family:"Arial",sans-serif'>“…conventional vertical discretization of
numerical groundwater transport models at contaminated sites (with layers that
are greater than one meter thick) can lead to significant errors when compared
to more accurate high-resolution vertical discretization schemes (layers that
are centimeters thick).”</span></i><span style='font-size:12.0pt;line-height:
107%;font-family:"Arial",sans-serif'><o:p></o:p></span></p>

                                                                                                                                                                                                                   