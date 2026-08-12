Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302823EA84;
	Wed, 12 Aug 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557752; cv=none; b=JmpTVs5qISRTQHlO/hyORqrLEGPwBsJBctISeySJhcPZO8OecDKaFzJxCdkh6mZak54I3IcXHEzgCWXaIIiVzDfoIt7r9Vmvhd0c5WJh/DECitUrVaJKgENiWI9hSjKUK2KOvefYdwa14E2dTkiFiwTKMPV80olh6Zn3chil9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557752; c=relaxed/simple;
	bh=d87kSTcvUtybzCELCCZqNObMIMF4KdvGEzAMKataUlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUMbBUBbA1sc5vmeISIwAB1EEWhm/gqYnYSdKyo8/xw4FdYp85riZoK5trXe53GQxC8HbiIwlHiLjh9iEB+OfpH4WHLd4wXsDtc3paZJ8GRgWntOcvPtYP+qWvbdiWmJ5WuGbG4wNUeK4/zSfe/a/xTS4ccuqZ7lhu5O43rkgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocomHOSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocomHOSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666F81F000E9;
	Wed, 12 Aug 2026 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557751;
	bh=uz27fRQbmLZ3xcxLxL3E+lR1tIUbt6V3Gu1RoS5Srs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ocomHOSxOmZSJCeI5nxJuoqhAhytsq3r9cJjlIsVsHbDvLUe+DB7jbdTJa7d88sjd
	 m4pvknxfMPyLosyg+6KdokWt/qmg+e4yVNmU9JE+S5ZpfW1YlU7CxmQaUE8zYU1bRW
	 WWRqVUHK3yBJndI+PzfNMb4p8mvK5RCzmBxLV1t4Fdnf+pYellKIpxLnh1ZqbAzbIJ
	 5Guz1PvzSLP1H1+0amt58f6bMdcctlNxbgECiShUKMNo4TURA717QpgGtiZxojSBuc
	 0P9IqUCKO9oqritMgalAXEJDzVFRdSQu9p2ec08lrcfBMhi0TJJT07ILInpp1ssJW5
	 N7H160o46ZxxQ==
Date: Wed, 12 Aug 2026 19:02:25 +0100
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
Message-ID: <93fe2e3e-7a2a-4aa3-ad27-9e99c602c495@sirena.org.uk>
References: <20260811122011.3539250-1-wenst@chromium.org>
 <20260811122011.3539250-2-wenst@chromium.org>
 <99ad23ba-f8f2-404b-960e-1c22a20c9ac4@sirena.org.uk>
 <CAGXv+5EeEQM6O8Vb8e8fGjRzMe1icmz=cPm3GoKLxvEO=weVcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3qPAsn7wmCMfZq5C"
Content-Disposition: inline
In-Reply-To: <CAGXv+5EeEQM6O8Vb8e8fGjRzMe1icmz=cPm3GoKLxvEO=weVcA@mail.gmail.com>
X-Cookie: !07/11 PDP a ni deppart m'I  !pleH


--3qPAsn7wmCMfZq5C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 12:39:42PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 11, 2026 at 8:43=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > Just take a timestamp during registration if the regulator is enabled,
> > we check if it's enabled anyway so we may as well take that as the last
> > time the enable happened.

> Yeah, I just haven't figured out where exactly in regulator_register() to
> put it. I think it should be after the supplies are resolved, so maybe
> I could do this in the "final setup" part in regulator_resolve_supply()?

Makes sense I think.  The other place would be while doing the
constraints but they're optional so might not happen.  Perhaps make the
one at the end of registration skip if there's a timestamp already?

--3qPAsn7wmCMfZq5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp8tTEACgkQJNaLcl1U
h9B2FAf8D1M22Grx18J9/WwNFIOC9lobobrOEs3T/vwO7/gO1L2DkkIIJ+O6giFE
pVSJK0jvB/6bFVrLlTTFUvMLxE+WxD/G/kpriivyU1quihyIkp1hVbsCmVQlKcTx
4gWcO383CQneVfUhZTcFpXFBT8l6pzLP4nT/6El14xC0nf6L2nX1me4vgBSlNhsX
1vVrWMkUDh7nORWr3MBRcbVICD/95yzWD6uUq64zT2yX8QBFACOGWzt4w5dooGFO
grAcJyH7t0K0WlFBSogUFX05QKN0eLiAuMEfCuVkpXf5phImv/MiaPaIlEZUxMC+
lPVvKyLFNzRuafb6rYrFUuevW9Ibaw==
=gO+2
-----END PGP SIGNATURE-----

--3qPAsn7wmCMfZq5C--
