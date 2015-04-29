From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/10] regulator: max77693: Add support for MAX77843
 device
Date: Wed, 29 Apr 2015 18:58:45 +0100
Message-ID: <20150429175845.GS22845@sirena.org.uk>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430305114-23598-10-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bqR6j9rbojULRSO5"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43086 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030924AbbD2R7C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 13:59:02 -0400
Content-Disposition: inline
In-Reply-To: <1430305114-23598-10-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org


--bqR6j9rbojULRSO5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 07:58:34PM +0900, Krzysztof Kozlowski wrote:

> The charger and safeout part of MAX77843 is almost the same as MAX77693.
> From regulator point of view the only differences are the constraints
> and register values related to these constraints. Now the max77693
> regulator driver can be used for MAX77843.

Acked-by: Mark Brown <broonie@kernel.org>

--bqR6j9rbojULRSO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQRvVAAoJECTWi3JdVIfQ9jUH/idddzq9+Zc/kfkRPh20u6YD
CCHTYz8JUGSQ24iTRGSv/GCaxAneuI7xFzLK18N4zqQ9I9PoTM43JNFCRprm/CYq
uVCwr6VX+4JtD6C5wGpLxg9C2o6nP7dBf2gu1O62RbLCCy4EO9L/4whN/pbzSwis
ZQmXRNLCaxUtlp1pH1cjJhX2wxY3QHBoWlI+Z60CpLTXIWhNHPY82kF6YGsL3+H6
KUtHglKDm/ResCeN6I6vQJWOd1opUfd4QrMBmCzISLOIcxLDgqI4NP05V/lzmIz8
waOtnsUfYPJBfWafXylJ0dQSBWrGBk8L/sC/vKiVJM300K5L3jglofARBXzrvqU=
=pqYR
-----END PGP SIGNATURE-----

--bqR6j9rbojULRSO5--
