structure Spectrum :> SPECTRUM =
struct
  val c       = 2.99792458e8
  val h       = 6.62607015e~34
  val eVJoule = 1.602176634e~19
  val rInf    = 1.0973731568e7

  fun wavelengthToFreq lam = c / lam
  fun freqToWavelength nu  = c / nu
  fun wavenumber lam       = 1.0 / lam

  fun photonEnergyJ lam    = h * c / lam
  fun photonEnergyEv lam   = photonEnergyJ lam / eVJoule

  fun dopplerClassical {restM, vMs} = restM * (1.0 + vMs / c)

  fun dopplerRelativistic {restM, beta} =
    restM * Math.sqrt ((1.0 + beta) / (1.0 - beta))

  fun redshiftFromWavelength {observed, rest} = (observed - rest) / rest

  fun velocityFromZ z = c * (z*z + 2.0*z) / (z*z + 2.0*z + 2.0)

  fun rydberg {n1, n2} =
    let
      val n1r = Real.fromInt n1
      val n2r = Real.fromInt n2
      val invLam = rInf * (1.0/(n1r*n1r) - 1.0/(n2r*n2r))
    in 1.0 / invLam end
end
