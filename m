Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC237DADD
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092705; cv=none; b=LvJqNqci9yH4RVY+gL/8PEPpV8Hew+vU9hU9hG5+rg8ue/l67SA00sZt8sIbG2gGry9XfP4OYZzkFivmPtoRW6xUpDap1296ewLrDvDHta35bflu1I1xgNuR9grQq2R173cBu6P7fBdmkx/kd0AtaFI9yuaQVV9ptsuyjEI6be4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092705; c=relaxed/simple;
	bh=RWK5XNzHCxbN0CIyBzmzynD3G+sG13mD/TIh+ITpqIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKZivGQg3wqZgJEShF0luO5X/GXkymzUDsN6vujw8MXEYcbom3vx667Gq+t+Yrx/y1g7q+Ecubp0vy5FBF0JUfsWjNvsFK/xWwYYthGpOQBzYW/8baHqlL3d18j7uBSfojBMFuLfkayybQf2EGqaAnRVi2ehJqQNzYTAN4y21B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Q/wzw8wm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Q/wzw8wm"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so4525642f8f.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781092701; x=1781697501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHPNJDli0SL72ZV7h41ZBnThr8ba+bZcbFOMnm72cuk=;
        b=Q/wzw8wmF23lyQPnMPzo/UIa7FzrPgM1/pCGDbodUMlNc0q4zfckel+5/xtk58rSQw
         oyTeNDEDUw8diIyDIKU9dBlWBfGJJ2gkHo2R6LaY28uiim29TqyJNsoXDlFxsHVft4+B
         vOlCvU621eLV2XDmGcHQS3qtHFumzCtGVJ/FQNxoku+CIfdctOqRm0ObstA0MmHC3B4k
         uu+ao+jyfaIRRg36VuQqEc1E5ZmOJwZKli2ychgu857Ds/mF6sKzkm6/QzdsQRT8EPeX
         Ac2RySG+NNIhdgYNbO4AGGEKgC0i+DWNms5Xt2rCESZ3dS2XsrG9vnBj/g0gyFMc3Xx6
         dE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092701; x=1781697501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHPNJDli0SL72ZV7h41ZBnThr8ba+bZcbFOMnm72cuk=;
        b=G/O/i+z8a/ZVLh4YD0NgNosZzGtYZyAK0vaw+va3BNQV8Gafim85LdEYD9jVcPYOzc
         NJdxRBoguPFhf7B0I5VMdqWzeEUGj5L+jTM9itAmb55JFiQwMFl9wUqkDYTRMYU1Oc21
         riEYErIlUWK2nB1X5gpuzEvlkfg72DubDwzR47XaYGOpjc2zVLsH1iTfXIeJCCZssvV1
         ECjThjthv93PcnTLMbQwKSjLbhNEiY0BApySgN3vs/nN4nk59GBWc8zCOt3syEot/Yo5
         f6A/hrL1tP9Wkv6tGgpW1Fu8gcu+5NjvdhglzL4DZ0WJR/Nn44T/iNKa1XgcTUleVfY4
         nB2A==
X-Forwarded-Encrypted: i=1; AFNElJ+/hElLCR0BQSD1b3nMclVH39w2DP1IP2x42Q5/zYPEencRAQ+cRPDzz2k/OOJOu9k53ipLVeBQyN9ONQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1NxIAsg0rMcMaUIRP5gbgNs0O1Bl6udgMglhQhF4hhGu3Qcv
	k8+69CegGa/c2IAuT6rMWvOuNXYk7zw9Rta6e3XeMnP6lGPoKvm+tGFXrFmyRmuBzWA=
X-Gm-Gg: Acq92OHGP9YuFiD0wezGyUjpK/TTgxMRWkbx+fyN80wYtazf2yqEWk8y3tPCj+3wAbr
	xaZzON13xVyq/8rdrdPojFqcSTN3uY7LbJ/SJaXq4Lml5VBY/jAkI/h+lm4MvUsxGANwYGqXFGe
	WRjxbsII6X1HEIlJQYxraXbHXZyNfvXrqhOdc4Mmr19PNOqMUyx5LMZnn1RO1vwMwQVVzFVpo/Y
	ccBBvY7KPp4lBq2LnEdJ/kEEazWCEhx+HKBfVnw/MTW0yNd7XkMQVBPXp7qgNWzgyqPn0a2RZKV
	64XscnAtg720l+r/SgP9y/Izv6cWjGB7cGKVLmhH7wuDAHa6MUxUWlPBCkN0n21Pqw2VC3AQL6U
	Bp46dfGp9RJIaTUjWTXomDTXeT71I1NEwUfKSCATMv4WC0RAbR64BABGHzHk6i0Dd9fptL9unPU
	0B8i7NPHZ+BuTeDvbj8MRBOK2fmIu/eiTrVYeeppM=
X-Received: by 2002:a05:6000:4b07:b0:460:21e7:330e with SMTP id ffacd0b85a97d-46032b8164fmr31650683f8f.10.1781092701398;
        Wed, 10 Jun 2026 04:58:21 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2ed944sm73905661f8f.13.2026.06.10.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:58:19 -0700 (PDT)
Date: Wed, 10 Jun 2026 13:58:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>, 
	Christoffer Sandberg <cs@tuxedo.de>, feng <alec.jiang@gmail.com>, gongqi <550230171hxy@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Input: Drop unused assignments from pnp_device_id
 arrays
Message-ID: <ailQutR_TfyCQ-SP@monoceros>
References: <f987c14dea1d3236d3889e5cf96c01eef6a2445d.1781016727.git.u.kleine-koenig@baylibre.com>
 <aij_gj5W1dylcbrX@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="impemnflpxbxj5mb"
Content-Disposition: inline
In-Reply-To: <aij_gj5W1dylcbrX@google.com>


--impemnflpxbxj5mb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] Input: Drop unused assignments from pnp_device_id
 arrays
MIME-Version: 1.0

Hello Dmitry,

On Tue, Jun 09, 2026 at 11:12:49PM -0700, Dmitry Torokhov wrote:
> On Tue, Jun 09, 2026 at 04:53:25PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > Explicitly assigning .driver_data in drivers that don't use this member
> > is silly and a bit irritating. Drop these. Also simplify the list
> > terminator entry to be just empty to match what most other device_id
> > tables do.
> >=20
> > There is no changed semantic, not even a change in the compiled result.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >  drivers/input/gameport/ns558.c        | 46 +++++++++++-----------
> >  drivers/input/serio/i8042-acpipnpio.h | 56 +++++++++++++--------------
> >  2 files changed, 51 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns=
558.c
> > index fdece6ec1df3..f70a96c4f1fd 100644
> > --- a/drivers/input/gameport/ns558.c
> > +++ b/drivers/input/gameport/ns558.c
> > @@ -148,29 +148,29 @@ static int ns558_isa_probe(int io)
> >  #ifdef CONFIG_PNP
> > =20
> >  static const struct pnp_device_id pnp_devids[] =3D {
> > -   [...]
> > -	{ .id =3D "", },
> > +   [...]
> > +	{ }
>=20
> This goes BOOOM! You have to keep empty .id string as terminator.

How so? Given that my patch doesn't modify the resulting ns558.o I doubt
that. If .id was a char *, I'd agree, but it's a char[], so there should
be no difference (and the compiler agrees).

Best regards
Uwe

--impemnflpxbxj5mb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopUVYACgkQj4D7WH0S
/k7g2Af/Yc1rUQEuTflkJFLILBh2UuhAWIVZreH7tyA24XPf0Xfu0XJ/F0qc3fr3
CeRwHk3LXILcCIeL1kVKRnsVjNdU4JwNrNJbWyQ4DU1VOmU4YESWg7+mxhotKO/y
IYTsw3/csZ1ireDEKZ1CcPMHPauzTWNbjp8TJ6vYb53UHNeLXssJLV89rjtXGyhL
mUCFl7X5Q5crYp8A+ocJLpYvg2EUVEdGB4GkfthgOcsKaFSZ2PWusiAv1RLwUEGS
SOUt/EOIakNZC94XKdegRH7hVFFi0mhrMGplZnyTUp3urDPsl7jkvyUBX6VLlUzE
fE92yV5oDnCQTZ1Hf2hG3dI4jjg6yQ==
=GHA/
-----END PGP SIGNATURE-----

--impemnflpxbxj5mb--
