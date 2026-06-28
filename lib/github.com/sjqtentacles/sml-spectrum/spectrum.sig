signature SPECTRUM =
sig
  val c        : real   (* speed of light: 2.99792458e8 m/s *)
  val h        : real   (* Planck: 6.62607015e-34 J*s *)
  val eVJoule  : real   (* 1 eV in Joules: 1.602176634e-19 *)
  val rInf     : real   (* Rydberg constant: 1.0973731568e7 /m *)

  (* Wavelength <-> frequency conversions *)
  val wavelengthToFreq : real -> real   (* m -> Hz *)
  val freqToWavelength : real -> real   (* Hz -> m *)

  (* Wavenumber = 1/lambda (m^-1) *)
  val wavenumber : real -> real

  (* Photon energy in Joules and electronvolts from wavelength in metres *)
  val photonEnergyJ  : real -> real
  val photonEnergyEv : real -> real

  (* Classical Doppler shift: restM=rest wavelength (m), vMs=velocity (m/s, positive=away)
     Returns shifted wavelength *)
  val dopplerClassical   : {restM:real, vMs:real} -> real

  (* Relativistic Doppler shift: beta=v/c (positive=receding) *)
  val dopplerRelativistic : {restM:real, beta:real} -> real

  (* Redshift from observed and rest wavelengths: z = (obs-rest)/rest *)
  val redshiftFromWavelength : {observed:real, rest:real} -> real

  (* Velocity from cosmological redshift (relativistic): v = c*(z^2+2z)/(z^2+2z+2) *)
  val velocityFromZ : real -> real

  (* Hydrogen Rydberg series: wavelength of transition n2 -> n1 (n2 > n1)
     1/lambda = R_inf * (1/n1^2 - 1/n2^2) *)
  val rydberg : {n1:int, n2:int} -> real
end
