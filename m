Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FF13CA92;
	Mon, 10 Aug 2026 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336727; cv=none; b=Ut5H3O2XeCPNBuO0EOb7tprZKLB5ddNeesXZSoYR/u8QX1hwBwj+3b02l1FpaMUHt8oGGlHmX13cxtvYeufNSK/4Kw5GSUVfxpr1AgXOGdYkJnKjyJnQ7qaCiGHco6ic6I5GMABo0Wfr0M7l1h7XfPKnlMQp9CY/ai6YFR2SCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336727; c=relaxed/simple;
	bh=fNoB0Hg8c7JQX1t9VdFRqFJqKrRMH4YPN73EnmlpkqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnlvbSO610pxMSqnSVllo9zsj+Z8huUY3z9X/fm53+0zFDWfsTTHEwzvCe1SgaV5vOFb4aAlcT9XinodzU5F2hHvdqXutSvBv4xRd+9HJQYXKt6bF85/5V2Cas3fEHGtJk8Bs/8sQyo4Tkpqx4ihy1iUk7UxVofdg9uNu55kpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgiqt/3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgiqt/3G"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 542BE1F000E9;
	Mon, 10 Aug 2026 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786336726;
	bh=SXbB0p8bY1g4pIBgkLXxQqZbuZ63Hp34XN5ZoOdkkSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zgiqt/3GXVhdFVv8f3hUikEP/U9+ksffocqxXditNVY2lhuwfftzsC7yNiUDwoHsU
	 M3EtqhwTwbWAj3U/27PV9/czAPMQnC3jtlcN2lzHQebVBk4g3nPJ5VJdrbOBjrze4Q
	 WM0E5C4avNTTADAFpteBM26UtI61xbBuVfcZqz3VheZI+0tTYHe4fqd0EyFoJzc0px
	 BpbdKq8V2DeS6ZwnL5R1TVkn+FUAhz8xF+5yZhAAB5ceNcW5ngo7T3yBVfGzvz0LC6
	 43d3cD+0oJngQv+dv0Bcil30JgRim1mVvlJtWi0K4Fr+Y9UNdAJIFFXdR3Bl1Oy0/L
	 obd4Hg2aFapOw==
Date: Mon, 10 Aug 2026 06:38:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 02/13] pwm: iqs620a: use
 devm_blocking_notifier_chain_register()
Message-ID: <anlRaaztPEu5u6Zn@monoceros>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-3-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxpal74eyemjmxfe"
Content-Disposition: inline
In-Reply-To: <20260726101739.33170-3-farbere@amazon.com>


--lxpal74eyemjmxfe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 02/13] pwm: iqs620a: use
 devm_blocking_notifier_chain_register()
MIME-Version: 1.0

Hello,

On Sun, Jul 26, 2026 at 10:17:28AM +0000, Eliav Farber wrote:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> iqs620_pwm_notifier_unregister() callback.
>=20
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 13e5e138c8e9..12f7b1415ed4 100644
> --- a/drivers/pwm/pwm-iqs620a.c
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -173,17 +173,7 @@ static const struct pwm_ops iqs620_pwm_ops =3D {
>  	.get_state =3D iqs620_pwm_get_state,
>  };
> =20
> -static void iqs620_pwm_notifier_unregister(void *context)
> -{
> -	struct iqs620_pwm_private *iqs620_pwm =3D context;
> -	int ret;
> =20
> -	ret =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
> -						 &iqs620_pwm->notifier);
> -	if (ret)
> -		dev_err(iqs620_pwm->dev,
> -			"Failed to unregister notifier: %d\n", ret);
> -}
> =20

Too much remaining whitespace here. Other than that looks ok.

There is no specified merge plan yet, and this depends on patch #1, so
it cannot get applied yet. Given that IMHO patch #1 should change, I
expect there will be a v5 and we can consider application then.

Best regards
Uwe

--lxpal74eyemjmxfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5VdAACgkQj4D7WH0S
/k7W7Af+N+HNhcp8o5wU5XfbYK4z26aXXjonv42lAgO+vYSVuo09+FUg908qguLD
bQwaxNTEDLWp2KhOimYvtwOmLnBi5LpFdRkl+3O+1hNbkdEqPzEhHR2E5fYln/ni
L53rfttbwzJAvZsNiNf7YyuWCkDn/EYR/lBjhwxkGMWAJrtvogleUK4cqx54q6yb
FAr4pZRVLXYh00yzvHs6YYcVltcr90a+ElTaN842ccl/3fSbCyqWFbOzgv4BZhWL
N2AeOhzToeosPeKdM0jX/PPQEeLMEdBQKmKvYYWgaIcJM64IxhD2A733ZL64GZ0W
W3ONy68gDEEzxPPwExzGleo7svm85w==
=VCpG
-----END PGP SIGNATURE-----

--lxpal74eyemjmxfe--
