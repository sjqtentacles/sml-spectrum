structure Tests =
struct
  open Harness
  fun close name (e, a, eps) = check name (Real.abs (e - a) <= eps)
  fun closeRel name (e, a, eps) =
    check name (Real.abs (e - a) / (Real.abs e + 1e~300) <= eps)

  fun run () =
  let
    val () = section "wavelength <-> frequency"
    val nu = Spectrum.wavelengthToFreq 500.0e~9
    val () = closeRel "500nm->freq" (5.9958e14, nu, 1e~4)
    val lam = Spectrum.freqToWavelength nu
    val () = close "round-trip wavelength" (500.0e~9, lam, 500.0e~9 * 1e~9)

    val () = section "photon energy"
    val eV = Spectrum.photonEnergyEv 500.0e~9
    val () = close "500nm photon eV" (2.48, eV, 0.01)
    val () = check "photon energy finite" (Real.isFinite eV)

    val () = section "Rydberg H-alpha"
    val lymanAlpha = Spectrum.rydberg {n1=1, n2=2}
    val () = close "Lyman alpha ~121.6nm" (121.6e~9, lymanAlpha, 1.0e~9)
    val hAlpha = Spectrum.rydberg {n1=2, n2=3}
    val () = close "H-alpha ~656.3nm" (656.3e~9, hAlpha, 1.0e~9)

    val () = section "Doppler"
    val () = close "Doppler v=0" (500.0e~9,
               Spectrum.dopplerClassical {restM=500.0e~9, vMs=0.0}, 1e~20)
    val () = close "Rel Doppler beta=0" (500.0e~9,
               Spectrum.dopplerRelativistic {restM=500.0e~9, beta=0.0}, 1e~20)

    val () = section "redshift"
    val z = Spectrum.redshiftFromWavelength {observed=600.0e~9, rest=500.0e~9}
    val () = close "z from 600/500" (0.2, z, 1e~9)
    val v = Spectrum.velocityFromZ 0.1
    val () = check "velocity from z>0 is positive" (v > 0.0)
    val () = check "velocity from z < c" (v < Spectrum.c)

  in Harness.run () end
end
