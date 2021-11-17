
<h1 class="fit-head" style="font-weight: bold;" >Tool 8. Select a good next-generation groundwater model for Transition Assessments.</h1>

<div class="row">

  <div class="col-md-4" style = "text-align: justify;">
  
    <h3><b>Matrix Diffusion Modeling</b></h3>
    
    <h4>There has been an increased recognition that matrix diffusion processes are a significant factor controlling the success of groundwater remediation.  New field techniques and site characterization approaches have, consequently, been developed to measure contaminants that have diffused into low permeability (“low-k”) zones and assess their impact on groundwater quality.</h4>
    
    <h3><b>Problems with Conventional Models and Matrix Diffusion</b></h3>
    <h4>With the knowledge that significant accumulation of contaminants can occur in low-k zones at sites, there has been the concurrent desire to apply groundwater models to estimate future impacts to groundwater affected by matrix diffusion processes.   However, most conventional groundwater transport models in the 2020 timeframe either do not have the capability to directly model matrix diffusion, or if they do, they simulate this process accurately under field scale modeling simulations (Farhat et al., 2020).</h4>
    <h4>For example, almost all conventional analytical groundwater transport models, such as BIOCHLOR or the plume module in the original REMChlor groundwater transport model, simply do not account for matrix diffusion and, therefore, ignore these critical back diffusion processes.</h4>
    <h4>Similarly, conventional applications of most numerical models (like MODFLOW-MT3D) do not accurately simulate matrix diffusion when applied at typical field scales (layer thicknesses on the order of meters).  Chapman et al. (2012) describes the problem with conventional numerical models this way:</h4>
    <h4 style="padding-left: 36px;"><i>“A major challenge of diffusion as a governing process, both in terms of field characterization efforts and incorporation in numerical models, is that it occurs over small scales relative to the typical dimensions of plumes. The response of plumes at the scale of 100s to 1000s of meters can be dependent on concentration gradients that evolve over dimensions of centimeters or less.”</i></h4>
    <h4>Farhat et al., 2020 showed how much error can occur when using conventional finite difference numerical models to simulate matrix diffusion.  They concluded:</h4>
    <h4 style="padding-left: 36px;"><i>“…conventional vertical discretization of numerical groundwater transport models at contaminated sites (with layers that are greater than one meter thick) can lead to significant errors when compared to more accurate high-resolution vertical discretization schemes (layers that are centimeters thick).”</i></h4>
    
    <h3><b>Dual Domain Approaches and Issues</b></h3>
    <h4>Even existing dual-domain approaches in common transport models like MT3D have significant limitations modeling matrix diffusion.  As described by Falta, Panday, Farhat, and Lemon  (2018):</h4>
    <h4 style="padding-left: 36px;"><i>“A dual porosity mass transfer modeling approach is sometimes used to simulate matrix diffusion (Feehley et al., 2000).  However, the dual porosity mass transfer model typically requires calibration of the mass transfer coefficient, and the first-order representation of the matrix diffusion concentration gradient is accurate only under a limited set of circumstances (Gaun et al., 2008).”</i></h4>
    
    <h3><b>Six Solutions to These Problems</b></h3>
    <h4>This is one of the reasons that ESTCP recently funded Falta et al.’s <i>“Incorporating Matrix Diffusion in The New MODFLOW Flow and Transport Model for Unstructured Grids”</i>  (ESTCP Project ER-201426).</h4>
    <h4>Overall, in the 2021 timeframe there are six broad ways to simulate matrix diffusion for groundwater contaminant transport issues (see table to right).</h4>
  
  
 
  
  </div>
  
  <div class="col-md-8">
  
    <h3 style = "text-align: center;"><b>Matrix Diffusion Modeling Options in the 2021 Timeframe</b></h3>
    
    <h4><table>
      <tr>
        <th>Modeling Alternative</th>
        <th>Description</th>
        <th>Input Data</th>
        <th>Comments</th>
      </tr>
      <tr>
        <th>1.  Analytical “gamma” model for source zones (Falta et al., 2005a, b; Falta et al., 2008)</th>
        <td>A single parameter “gamma” is used to relate mass flux over time to source mass.  A gamma of two or more will create a “long tail” representative of matrix diffusion.  </td>
        <td>Gamma term. Is not directly linked to site stratigraphy, loading history, type of contaminant but is general way to generate “long tail”.</td>
        <td>For source zone only, not plumes.  Used in REMChlor and REMChlor-MD for the source zone.</td>
      </tr>
      <tr>
        <th>2.  ESCTP Matrix Diffusion Toolkit (Farhat et al., 2012)</th>
        <td>Two separate analytical matrix diffusion models:  1) “Square Root model” and 2) “Dandy-Sale Model”</td>
        <td>Loading duration and time when transmissive zone is remediated; low-k unit properties; contaminant diffusion properties; transmissive zone properties.</td>
        <td>Assumes two layers:  a transmissive unit and a low-k unit.  Cannot simulate low-k lenses or other stratigraphic scenarios.  Used for Navy Whidbey Island dioxane modeling.</td>
      </tr>
      <tr>
        <th>3.  REMChlor-MD (Falta et al., 2018)</th>
        <td>The plume component of this newly released model (Dec. 2018) can now simulate matrix diffusion using a semi-analytical model based on heat transfer equations (Falta et al., 2018)</td>
        <td>The heterogeneity calculator in REMChlor-MD (developed by GSI) asks users to enter boring logs to generate three key values:  1) transmissive zone volume fraction; 2) average diffusion length; and 3) surface area of low-k interfaces.</td>
        <td>REMChlor-MD is first the model to specifically relate stratigraphic data to matrix diffusion input parameters, but assumes entire plume has the same type of heterogeneity and assumes 1-dimensional groundwater flow.  Can simulate low-k layers, different configurations / density of low-k lenses based on boring logs.</td>
      </tr>
      <tr>
        <th>4a.  MT3D / RT3D 2-D “Bread Slices” (e.g., Rasa et al., 2011; Farhat et al., 2020)</th>
        <td>Existing numerical groundwater contaminant transport model, but modeled in a vertical, 2-dimensional form (X-Z), hence the term “bread slice”.  With this approach very fine vertical discretization can be employed. </td>
        <td>Matrix diffusion can be modeled successfully if hundreds of very thin layers are used (on centimeter scale).  </td>
        <td>Because of need for many thin layers, only 2-D simulations are feasible.  This approach has been applied successfully by Rasa et al. 2011 and Farhat et al., 2020.</td>
      </tr>
      <tr>
        <th>4b.  MT3D / RT3D 3-D Model with Thin Layers but Small Grid</th>
        <td>Existing numerical groundwater contaminant transport model</td>
        <td>Matrix diffusion can be modeled successfully if very thin layers are used (on centimeter scale).  </td>
        <td>Small 3-D model domains with centimeter sized layers may run fast enough to apply for limited modeling / analysis problems. For example, Falta (2018) reported that a 3-D MT3D simulation of a DNAPL site (3400 ft x 2000 ft x 135 ft thickness required 2.8 million grid blocks (400 layers) and took “several days” for one simulation.</td>
      </tr>
      <tr>
        <th>5.  ISR-MT3DMS (Carey et al., 2015)</th>
        <td>Incorporates local domain approach into MT3D numerical model.</td>
        <td>Grid array with many thin layers to represent site stratigraphy for plume.  Source depletion data not calculated in model but entered manually.</td>
        <td>No publicly available code as of late 2018.  Beta version tested only in 2-D?</td>
      </tr>
      <tr>
        <th>6. MODFLOW UnStructured Grid (USG) Transport Model with Matrix Diffusion (R. Falta of Clemson, S. Panday and S. Farhat of GSI, and A. Lemon of Aquaveo)</th>
        <td>Soon to be released new version of the public domain MODFLOW-USG / MT3DMS model but with matrix diffusion method used in REMChlor-MD to efficiently model matrix diffusion in a finite difference model. </td>
        <td>Unstructured grid array with many thin layers to represent site stratigraphy for plume.  Source depletion data not calculated in model but entered manually.</td>
        <td>Project is anticipated to be complete in 2021.  Early beta version may be available at some point in 2019. </td>
      </tr>
    </table></h4>

  
  </div>

</div>

 <h3><b>References</b></h3>
  
  <div>
    <h4>Carey, G.R., Chapman, S.W., Parker, B.L. and McGregor, R., 2015. Application of an adapted version of MT3DMS for modeling back‐diffusion remediation timeframes. Remediation Journal, 25(4), pp.55-79.</h4>
    <h4>Chapman, S.W., Parker, B.L., Sale, T.C. and Doner, L.A., 2012. Testing high resolution numerical models for analysis of contaminant storage and release from low permeability zones. Journal of contaminant hydrology, 136, pp.106-116.</h4>
    <h4>Falta, R.W., Rao, P.S. and Basu, N., 2005. Assessing the impacts of partial mass depletion in DNAPL source zones: I. Analytical modeling of source strength functions and plume response. Journal of Contaminant Hydrology, 78(4), pp.259-280.</h4>
    <h4>Falta, R.W., 2008. Methodology for comparing source and plume remediation alternatives. Groundwater, 46(2), pp.272-285.</h4>
    <h4>Falta, R., S. Panday, S. Farhat, and A. Lemon, 2018.  Incorporating Matrix Diffusion in The New MODFLOW Flow and Transport Model for Unstructured Grids, ESTCP Proposal Number: ER19-B3-5028.</h4>
    <h4>Falta, R W, S K Farhat, C J Newell, and K Lynch. 2018. “REMChlor-MD Software Tool.” Environmental Security Technology Certification Program (ESTCP) Project ER-201426.</h4>
    <h4>Farhat, S K, Charles J Newell, R W Falta, and K Lynch. 2018. “REMChlor-MD Users Manual .” Environmental Security Technology Certification Program (ESTCP) Project ER-201426.</h4>
    <h4>Farhat, Shahla K., David T. Adamson, Arun R. Gavaskar, Sophia A. Lee, Ronald W. Falta, and Charles J. Newell. 2020. “Vertical Discretization Impact in Numerical Modeling of Matrix Diffusion in Contaminated Groundwater.” Groundwater Monitoring and Remediation 40 (2): 52–64. https://doi.org/10.1111/gwmr.12373.</h4>
    <h4>Gaun, J., F.J. Molz, Q. Zhou, H.H. Liu, and C. Zheng, (2008), Behavior of the mass transfer coefficient during the MADE-2 experiment:  New insights, Water Resources Research, Vol 44, W02423. </h4>
    <h4>Feehley, C.E., C. Zheng, and F.J. Molz, (2000), A dual-domain mass transfer approach for modeling solute transport in heterogeneous aquifers:  Application to the Macrodispersion Experiment (MADE) site, Water Resources Research, 36, 2501-2515.</h4>
    <h4>Rasa, E., Chapman, S.W., Bekins, B.A., Fogg, G.E., Scow, K.M. and Mackay, D.M., 2011. Role of back diffusion and biodegradation reactions in sustaining an MTBE/TBA plume in alluvial media. Journal of contaminant hydrology, 126(3-4), pp.235-247.</h4>
  </div>


