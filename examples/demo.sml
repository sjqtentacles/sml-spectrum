(* demo.sml - spectroscopy and astrophysics calculations: unit conversions,
   Doppler shifts, cosmological redshift, and the hydrogen Rydberg series.
   Deterministic: identical output on every run and both compilers. *)

structure S = Spectrum

fun fmtR x = Real.fmt (StringCvt.FIX (SOME 6)) (if Real.== (x, 0.0) then 0.0 else x)
fun fmtR4 x = Real.fmt (StringCvt.FIX (SOME 4)) (if Real.== (x, 0.0) then 0.0 else x)

val () = print "Physical constants:\n"
val () = print ("  c       = " ^ fmtR S.c ^ " m/s\n")
val () = print ("  h       = " ^ fmtR (S.h * 1.0e34) ^ "  (x1e-34 J*s)\n")
val () = print ("  eVJoule = " ^ fmtR (S.eVJoule * 1.0e19) ^ "  (x1e-19 J)\n")
val () = print ("  rInf    = " ^ fmtR (S.rInf * 1.0e~7) ^ "  (x1e7 /m)\n")

val () = print "\nVisible light at 500 nm:\n"
val lam0 = 500.0e~9
val freq0 = S.wavelengthToFreq lam0
val () = print ("  frequency        = " ^ fmtR4 (freq0 / 1.0e12) ^ " THz\n")
val lamBack = S.freqToWavelength freq0
val () = print ("  round-trip       = " ^ fmtR4 (lamBack * 1.0e9) ^ " nm\n")
val () = print ("  wavenumber       = " ^ fmtR (S.wavenumber lam0 * 1.0e~6) ^ "  (x1e6 /m)\n")
val eJ = S.photonEnergyJ lam0
val eEv = S.photonEnergyEv lam0
val () = print ("  photon energy    = " ^ fmtR4 (eJ * 1.0e19) ^ "  (x1e-19 J) = " ^ fmtR4 eEv ^ " eV\n")

val () = print "\nH-alpha (656.3 nm) Doppler shift at 300 km/s recession:\n"
val restM = 656.3e~9
val vMs = 3.0e5
val beta = vMs / S.c
val () = print ("  beta (v/c)       = " ^ fmtR beta ^ "\n")
val shiftedClassical = S.dopplerClassical {restM=restM, vMs=vMs}
val () = print ("  classical shift  = " ^ fmtR4 (shiftedClassical * 1.0e9) ^ " nm\n")
val shiftedRel = S.dopplerRelativistic {restM=restM, beta=beta}
val () = print ("  relativistic     = " ^ fmtR4 (shiftedRel * 1.0e9) ^ " nm\n")

val () = print "\nCosmological redshift, observed 658.0 nm vs rest 656.3 nm:\n"
val z = S.redshiftFromWavelength {observed=658.0e~9, rest=656.3e~9}
val () = print ("  z                = " ^ fmtR z ^ "\n")
val recVel = S.velocityFromZ z
val () = print ("  recession vel    = " ^ fmtR4 (recVel / 1.0e3) ^ " km/s\n")

val () = print "\nHydrogen Rydberg series, n=3 -> n=2 (H-alpha check):\n"
val lamHa = S.rydberg {n1=2, n2=3}
val () = print ("  wavelength       = " ^ fmtR4 (lamHa * 1.0e9) ^ " nm\n")
