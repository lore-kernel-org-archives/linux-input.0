Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63D266EE9;
	Tue, 11 Aug 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452194; cv=none; b=RrUAbIBuWtZoMza6JbRVnP33D8VGT76QgKdtdzy0ND9rzC9CzXgIuE7xs4mhf55GpUQKYQclTPLyC2wC4VBaIcltZP48sLFSAFrFytaQa2L8qYBq2T9tdfHXJVj9I2QkNjCx/hWBn7SQWiIPkVmaZqIJ+zgwVeoOMQgYM2rIKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452194; c=relaxed/simple;
	bh=uAKaQ7A7Z3Zdb/s/aszQmMSxLxqbjQ8B64KjECCt4ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPyv3otNTAarGFx0US/iZzqBurDGWDFxrm1ljIisAMNk4biYSJ56D93CRI0MFdUeX4VwJjVphQqSX9OgWYY6gQNqbIpsH2MncaQxR7oDt1AYxJjN2pBkioDCRD9pl9JcEseJlOlQqHiX+8joZQjZhs5eFc+lFhjjmspQ5sLq14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op7S08Vp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op7S08Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAD41F000E9;
	Tue, 11 Aug 2026 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786452193;
	bh=4doV9GUIAy9xUM+AhC/KkssK6h0MHIlM0ziN846RuEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=op7S08VpI3MrH1h/maoaiUxk163dPSARrCqOWylNsQmtVHV+KnxK4GX8vEm6kwbWL
	 ntm5ElhUpUHiS4sSlN+gI77xvYnSbPQiqonQLrh3g0zDWKd3HMB6gl8M0JMh6mCTDT
	 wGovQw6wQfSpz4wO5uP0Mtlqjwwi+kcvmLVCCNXHVCjcbZvjFMaQEdvEJkxcFdcLAn
	 gU1wOk3RewFn3ukeZbekbefbLhtx9sxYiBjQsBMXQRhJbyo79cWQik9Y/kBA4DLNEs
	 bxDoaLOKdBWil1q6EOIavriIi6PqWS9UmfwybeZv/TQn20XWNkNaYtvy/dOeRXNrCb
	 uNLFK2CXeDLNg==
Date: Tue, 11 Aug 2026 13:43:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] regulator: core: Add "enable and wait" functions
Message-ID: <99ad23ba-f8f2-404b-960e-1c22a20c9ac4@sirena.org.uk>
References: <20260811122011.3539250-1-wenst@chromium.org>
 <20260811122011.3539250-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jN3Lu5VuliZs+Yka"
Content-Disposition: inline
In-Reply-To: <20260811122011.3539250-2-wenst@chromium.org>
X-Cookie: Take me drunk, I'm home again!


--jN3Lu5VuliZs+Yka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2026 at 08:20:01PM +0800, Chen-Yu Tsai wrote:
> In device power sequencing and initialization use cases, it is common
> for the driver to enable the regulator and then wait for a certain
> period of time to pass before continuing.

Please don't bury core changes for subsystems in the middle of random
other serieses, this is the first time I've seen this.  :(

> One case in particular is not optimized yet: a regulator left on either
> by hardware reset default or by the bootloader, but does not have the
> "regulator-boot-on" property set. As the enable timestamp only gets
> updated when enabled by a consumer or by the core, the first enablement
> always needs to wait.

Just take a timestamp during registration if the regulator is enabled,
we check if it's enabled anyway so we may as well take that as the last
time the enable happened.

--jN3Lu5VuliZs+Yka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp7GNoACgkQJNaLcl1U
h9BeJwf+NkLsGljQXwokTuIRv+ig4jdUnALSbb8+0ZIRrZ+96sNEkwqEODMFToii
m8eaYIc5o7+PoXbWo0li99AO3IoZAw8otyweKMS8qGabP4EmHx4RQlRtmT5EB8GN
KKPHgVNpuTTrP8/pNacCVJUZ2keDYA98Mqugtuxo14y9ZOp4HKevYQvXdimF1sXM
43lEEtZJ/tnW/FlDVUtljN42u51I1ly4Tc2SUvquTs1V5sOJGEFvAftOVMTQWZeb
dGPhAbqkevlNFnoQqIGB/9AeSYm8PpMRwVbveoDgBKXYMiHKpxokg2Vib+LH/6rn
wYimUcQhuqXcIN2eQrOr0HIWPeB9Qg==
=2Up9
-----END PGP SIGNATURE-----

--jN3Lu5VuliZs+Yka--
