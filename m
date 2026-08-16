Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03E3DA7D3
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863617; cv=none; b=u06ol5vyGLa0igBUxZP2mDPsOI29Z/gwKJJtmLgH+38bREqmqGbCKXcUXDBNNdIgqbeKpPjIcn0owsLX6P2y/lHLQrGrOI05nKKjYtLg9RHihjTlYcd14Sy++2RSazOtRNKvHcEWHKxOygXaUJZ2adbCycx+150bZjJgJYviSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863617; c=relaxed/simple;
	bh=bOyHkt34gFN/ElEHyzil9TCQFMVu5iTzsUfWz66Nna8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRjF2gRmrrt2CBrcViO37AZBywkVfV9lkp71ZtyXTBYkkePQiEV1JVwP0rG+9oKBLIYmBujBoa9nUG6cA2H2hLGd4Gl7JKkIrbyOQNKdTdYbIuuourwvikpiMYbO9KXkXRTBNJvaJNtJ/bBNbKuskYCPf0DP7fcwAwNPRy9oVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AaTdysdd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AaTdysdd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so19246315e9.2
        for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786863612; x=1787468412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xqQmuQcKqKDC2uwjxn1DZobaA2hqwO+uRois1uUrjgM=;
        b=AaTdysdd1ZEIExPfoXp5YFzlzr8YClShzTzo8X8pwIEK48FlUOzPss8GN8lTSc1kDe
         xTjN+eIKvH74c/obWzfoOE6sOayc862UtixlwpsFqqGVPgZPifqtW3V76sTDbkLjd1Bc
         QghQfgPlaijFfosgOaHGrYr2iK39QR8L2miKqbPPvoVfsuq+1axdXOCnaOPG+QlXXdTD
         n6t+0KeVIIVSiIb/vCBvrraZiIPoRofB1tyBlYzNpyXSSKUoEtxtLShlMKBVTadPWGRH
         q8hml1iqfifjAhZqZDiPsFHIRmmk3RIEpiuk2NrEb6wC/wl6E2MUeZ6xEm7ZGwBZcaGO
         gufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863612; x=1787468412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqQmuQcKqKDC2uwjxn1DZobaA2hqwO+uRois1uUrjgM=;
        b=WObEOKVfed1kdjOsEfLI3EkYc36V6Gr+8XZwOeRtsf/2vMrRnywkActiliB2ZNDfWD
         gWubxGjmSyTk8A6UA5zebn0pHo9jmDWcbYTpp0bTrEPXcND4l+hi0IpOqG5RBi+3z7WV
         S8Ha0cTFeQQrWLmX8HsiQ9cNC6bV2uk+uQQY8/raBdLim0gVykny5Wk6X3tObGXfF6Ro
         32GdzBi+yJm1hPyg69nlOqfhkRWT4Rl+GOKun8sJfwR+5jBBUremvffbfBM5HmTmSoPP
         zmfqTRcZYB51w7Y89OWW9cH8W1GUPu+rXC8wkUI52wEntypb5wvsUURt/7zkrfgL2Rh4
         szzg==
X-Gm-Message-State: AOJu0Yz878afcwcLSpnAYZ5C+3spZXtesxBBqhaViv9u5Q2gjEMZiiuq
	XIEEulpQhLWeS+daaJ7OE/Y+u5qSwRSoXPnp7KiCzl2K5Oh/d8QQkpQURtGGNJexz8/PHzw+0zg
	5aSwT6f0=
X-Gm-Gg: AR+sD13gOwuyP+TavuKIWywTKNqp+5P1Ck5i6iHHqdI0FTraeV+ZuRe5v2ZiyuFsHJr
	QP9v+0JuRllRat8eI+0TEya12VH2fCIVJ3MySW1OUg6FA3P7d1JX4F6LSdwUxd4rJKIxcjK0p0w
	sRK+TdjSxbcSNJAPDSb0YQB51uURba+yR2YY8lVTIRW6I1AuidxMfxCfyouw6aFn0mEJFUu9riy
	nvtRH5tyGP5qrps8+nLXNg9Lo8mQoK+C65hbNi9gJxdTBU2c5donbp443bRBDOOmfhqB4/u/hVN
	0UiJOyCTiSkf7sGdVFgGkDkprj/W2ZwELy7v9zTnteyRoEH5ly/rBAIU2GMN5fzJ25jhudIhtPn
	bAOFmKTikBo49SxiDeazQ4jG+ahK29O1kj9j2I6fPDL3cCBt2hvSCgOOJ2IBlMdXm+A3Y6tYmsJ
	+wz3aSEIrtQy+Qo00dDu7xW9xo3TCiZ6LseiCJHXPQ7ovxWI3Jt2ri47Noj3ZVqD9d07aHrfn3O
	HVN
X-Received: by 2002:a05:600c:3651:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4998797d3f9mr199017535e9.12.1786863611388;
        Sun, 16 Aug 2026 00:00:11 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815f2b1f90sm21138669f8f.18.2026.08.16.00.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:00:10 -0700 (PDT)
Date: Sun, 16 Aug 2026 09:00:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eliav Farber <farbere@amazon.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
Message-ID: <aoFd149hoxHDcPU0@monoceros>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-2-farbere@amazon.com>
 <20260816061906.915E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a3k3tivbtons2iy2"
Content-Disposition: inline
In-Reply-To: <20260816061906.915E61F000E9@smtp.kernel.org>


--a3k3tivbtons2iy2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
MIME-Version: 1.0

Hello Eliav,

On Sun, Aug 16, 2026 at 06:19:06AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] The patch omits explicitly callable devm_*_unregister() functi=
ons, preventing safe early unregistration in drivers.
> - [Medium] devm_atomic_notifier_chain_register() is implicitly restricted=
 to process context but its documentation does not state this.
> - [Low] Device-managed registration for SRCU notifiers is omitted without=
 justification.
> --
>=20
> --- Patch [1]: [PATCH v5 01/13] notifier: add device-managed registration=
 APIs ---
> commit 123931abf8d80f91fce35443259e0df9e2736a4e
> Author: Eliav Farber <farbere@amazon.com>
>=20
> notifier: add device-managed registration APIs
>=20
> This patch adds devm_atomic_notifier_chain_register() and
> devm_blocking_notifier_chain_register() that automatically unregister
> the notifier when the device is unbound. This reduces boilerplate in
> drivers by eliminating per-driver unregister callbacks.
>=20
> > diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> > index 01b6c9d9956f9..4eeae9741a6e8 100644
> > --- a/include/linux/notifier.h
> > +++ b/include/linux/notifier.h
>=20
> [ ... ]
>=20
> > @@ -145,8 +146,14 @@ extern void srcu_init_notifier_head(struct srcu_no=
tifier_head *nh);
> > =20
> >  extern int atomic_notifier_chain_register(struct atomic_notifier_head =
*nh,
> >  		struct notifier_block *nb);
> > +int devm_atomic_notifier_chain_register(struct device *dev,
> > +		struct atomic_notifier_head *nh,
> > +		struct notifier_block *nb);
>=20
> [Severity: Medium]
> Should there be corresponding devm_atomic_notifier_chain_unregister() and
> devm_blocking_notifier_chain_unregister() functions provided?

I think these can be added once they are needed.
=20
> If a driver needs to unregister early to quiesce hardware, manually calli=
ng
> the non-devm unregister function leaves a stale devres action. This perfo=
rms
> a useless double-unregister during devres_release_all(), which
> unconditionally hits the slow synchronize_rcu() and delays unbind.
>=20
> >  extern int blocking_notifier_chain_register(struct blocking_notifier_h=
ead *nh,
> >  		struct notifier_block *nb);
> > +int devm_blocking_notifier_chain_register(struct device *dev,
> > +		struct blocking_notifier_head *nh,
> > +		struct notifier_block *nb);
> >  extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
> >  		struct notifier_block *nb);
> >  extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
>=20
> [Severity: Low]
> Is there a reason the devm variant for SRCU notifiers was omitted?
>=20
> The commit message justifies omitting raw notifiers due to locking
> constraints, but SRCU notifiers manage their own internal mutex which sho=
uld
> be safe to lock in the devres teardown context.

=F0=9F=A4=B7, I don't care much.

>=20
> > diff --git a/kernel/notifier.c b/kernel/notifier.c
> > index 2f9fe7c30287f..0c39627ea69c5 100644
> > --- a/kernel/notifier.c
> > +++ b/kernel/notifier.c
>=20
> [ ... ]
>=20
> > @@ -197,6 +198,56 @@ int atomic_notifier_chain_unregister(struct atomic=
_notifier_head *nh,
> >  }
> >  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> > =20
> > +struct atomic_notifier_chain_devres {
> > +	struct atomic_notifier_head *nh;
> > +	struct notifier_block *nb;
> > +};
> > +
> > +static void devm_atomic_notifier_chain_unregister(struct device *dev, =
void *res)
> > +{
> > +	struct atomic_notifier_chain_devres *dr =3D res;
> > +
> > +	atomic_notifier_chain_unregister(dr->nh, dr->nb);
> > +}
> > +
> > +/**
> > + *	devm_atomic_notifier_chain_register - Device-managed atomic notifie=
r registration
> > + *	@dev: Device to tie the notifier lifetime to
> > + *	@nh: Pointer to head of the atomic notifier chain
> > + *	@nb: New entry in notifier chain
> > + *
> > + *	Adds a notifier to an atomic notifier chain and registers a cleanup
> > + *	action to automatically unregister it when @dev is unbound.
> > + *
> > + *	Return:
> > + *	0 on success, negative errno on error.
> > + */
>=20
> [Severity: Medium]
> Should this kerneldoc include a context warning like "Must be called in
> process context."?
>=20
> Unlike atomic_notifier_chain_register() which is safe in atomic context,
> this function uses devres_alloc() with GFP_KERNEL which can sleep, making=
 it
> unsafe to call from atomic context.

That sounds like a good suggestion.

You didn't specify a merge plan for this series. Given there is no
explicit maintainer for kernel/notifier.c, I can apply patch #1 (with
adding the comment suggested by Sashiko) and provide an immutable branch
for subsystem maintainers to pull into their tree as base to apply their
patches. I'd wait till say Wednesday with that to maybe let reviews
tickle in.

Sounds good?

Best regards
Uwe

--a3k3tivbtons2iy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqBX/QACgkQj4D7WH0S
/k7G+Af/RmLbsE6p9GHMYc1Mvff5zpxrfVJ65lB1aq/XlUzfHm5Es5hRTYDBuePW
3UA6+SXdJdQNxOHtW7j9sRmXOqAg4RMYjhvHS/eIxpGyivOrCoL2VFg/jGtdoNLH
xssQfZpV2l0HXzgzeEC7Wjns2wY/qxo5HOeiwh+/jie+m3gSGlPzxHS1LNlIENzE
CLkxpN27bJ4RErcv6J88utOIkcsjPzSKlsbT5jgOkDPN5UJZY0Kz59Tan21vUokS
AedCQsTv112lywTBPvmhDibMl3hpWjXOuJ1MJ4Z18T3sxEJX9TV98ZVZHYc2Qb5G
MaTV+/JvOFhe4zSWsYshsVYUWt/Cgg==
=71YC
-----END PGP SIGNATURE-----

--a3k3tivbtons2iy2--
