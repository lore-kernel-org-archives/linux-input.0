Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9423E7BB6;
	Mon, 13 Jul 2026 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942580; cv=none; b=lFjeeh7Yuay3ew6u6X8n5sHC5HyH2dyqeC9mkSu6AhxN5espUx4yzUEFVFShqIS8qwfUeednfVMZaBiNzIqD0mLEg7cQD/x0a67SjOTtFYPeajKXw00iw7b5bKBux74k1//0D00MWUOj7zQW9Pv8+OkB/7CKXU0inZbtrHVIwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942580; c=relaxed/simple;
	bh=4gsuP0hVnICCC2D2maZvzGNrct6hCtitUX+7fShaHE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmdDHQoUncjsnti+DLPq0boDivQiR4tGHPXrZTS1ewYpnOsrCNhrp/kJkGmiobSpihOF9S3f85fYXzRprpr8X/dRutuLHYrZ0A74lxaorL2gwHDNecnjouDCXeNVV6s2AS4sZhA8meg9EDa21oCMTPWwbDqu5psU0ZcsFvcKUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F291F00A3A;
	Mon, 13 Jul 2026 11:36:18 +0000 (UTC)
Date: Mon, 13 Jul 2026 12:36:15 +0100
From: Mark Brown <broonie@debian.org>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Input/SPI: fixes for MacBook8,1 DMA timeout, UAF,
 and NULL pointer dereference
Message-ID: <790e9cea-5a4d-4199-9d50-f46adebd485a@sirena.org.uk>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QGtCEai1V2o90k3X"
Content-Disposition: inline
In-Reply-To: <20260711131140.18777-1-fourdollars@debian.org>
X-Cookie: Courage is grace under pressure.


--QGtCEai1V2o90k3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 09:11:37PM +0800, Shih-Yuan Lee wrote:
> Hi Dmitry, Mark, and the linux-input/linux-spi community,
>=20
> This patch series addresses a long-standing DMA initialization timeout on=
 the=20
> early 2015 12" MacBook (MacBook8,1) on any boot (including cold boot), as=
 well=20
> as two pre-existing, high-severity UAF/NULL-pointer bugs in the applespi =
driver.

Are there any dependencies between the SPI and input parts of the
series?  There's nothing visible...

--QGtCEai1V2o90k3X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpUza4ACgkQJNaLcl1U
h9Brfgf/asnNFesIIXl0F4zYLxdSDTfJq5dX9DwgbfMsMkbrgpAijHi3m2eUatPq
9xLPiaKpu46LkGmMlLqATqIG57Xqj5HgecDvaGN+Pnt+yXAjsa/vA3M1hrOFa8XV
wC+UEDj03VJ+1dlcLlL6w/464P7VcWwB9PqMtlWqMfCBCju/gFG8CnViCnCfAUzY
DFiE4+R6ITVvccYI7vk95U3y4PXckerEelDi3j3ez3T9DsH0+ZI9VoJ5KxmDFkC5
SjYpV2olSbnv1lYTyswMXncg/RnD7c6pcWu42mSbkrjy9hQTHz4xdsw0DQjwYA+/
roo9PEQBqMauZiXF1T4/8ndqUEw2fQ==
=Fbsv
-----END PGP SIGNATURE-----

--QGtCEai1V2o90k3X--
