Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607218;
	b=dkxIBZbhAHsq96DCjNz1cWJ/pQaRrBxfj6ZH71TRLYeJ6Tk6Nfb+bRYUsJ9KqntlDokd
	 biFPbmislE/HQAg/9pQClCTJydMzwiz+ow/h3j6XEJ8tcxjIqRatzcf6/oi9XW7RsK++o
	 znnZlppBDbHHK568wO9MEpep23x6sNsf5ZOkfAPIHueJdItDBhrGZ9NuJmePlpkCQtp0P
	 GiDOQCeLsEvdh9GR+cnyCJrSbJYiBBZOuRZQAR5kdOI3YSS/eIamcHbRhtFtTuUsqWfvo
	 +Mlm8CTHMgV0Pdvh52GcAS43OC3qk1g8yz36PLGQUfYX1ketaw5bCy73/fbfy1FC3VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8d9il6UmYnHuFTObnPSAKSL1Qx/DkpeI4Exm7zghUTA=;
	b=S5nWJ2wv3h/yvcGfuJxksgPeiUMcL/+re/qYsXmdRozEtoBMmEebep4qEEXsNG7ukFWf
	 UXgt1pHWn4/WOSsW1jUlxOh2ea5LV73NgQh/SVnCnzwipA/tfG4XCN16QfSHqLnoDDUGm
	 nWzkeWhgtFv5Ks+imZJ/0Wa1suGC2d6vi2Cnw5vWJZHvvzEzSo12bTIsF3WZ0MNSbk2S2
	 UiosadKrZH3aO9mWyrvow2hvTDDzxZLhoDy2zbB9KNNPiFV8/Y4gbr0e3BEF4ZAgtSNY8
	 JG1u+Vh66Y/aSWdTLpL5mdH+oXIbOxRuPZUfY66cfdF96zfBqCnxUYL0Q39XdSV/6Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hNedqWgh;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E58606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 11:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hNedqWgh
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-497614c95f0so3213519f8f.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795607215; x=1796212015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8d9il6UmYnHuFTObnPSAKSL1Qx/DkpeI4Exm7zghUTA=;
        b=hNedqWghPyjHZriQsp3dcOrunHTPFPfoMhV22ERWbxbhUjkFmEkjB528WLQKHCygVG
         Z8rQS3kjrb1FJYX/9dieIlb8+gXkln47TgZB274JuobrW+1qGufsQwAyPSahVq9wUp15
         d+IxM4v2XR5vXuHUJG8iNWZAu+OM787tL5vJxNwYIDaEn//S3lJ8IqjkuueqTFjn3eSB
         OwNiCSC7UC5TUVv/h4OEP9tKcH8a6c5+kudlNY7UVOv4eTrTw6YQ1ASZYqdJ9Cfe+l80
         DYvcReFm/xwiKkjJ8bdkG534Wi8B8sq1ct1lDdK0e4ns7I0ZJjyCUlS9f9MDlS7TPk8g
         +QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607215; x=1796212015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8d9il6UmYnHuFTObnPSAKSL1Qx/DkpeI4Exm7zghUTA=;
        b=ns+JB61Gn2HYH/AVNZ4BedPnVNW4P5h3mMqIk8MrCyTE5vl+eNZWS5dnX/UJFEDRgs
         JrVEhVD63uXE610q8yGhSGgaZ8BMcw7AcYRD2Dj9OT9xIskAvIDluXOO8qpkNT2dCKcQ
         h5lHjcjMVFxZ/qbKDi/PBcUH66pcWbUgy2Ifw+DShQNRhfd8R279oWBUHB/WB9HseZJv
         YXpyQhsXBxb8m4n9boMgMarKMaT1KmmosSccrlsoT3KbMY6NnrfYn05yoJ+y7nmIE1Kc
         M/WPP4yP/l/K52XPrAU9wL9UNA9fvEZppfVR4CDLintHdyyqaoOWn8tjGFPaa9Th7yCk
         8jSg==
X-Gm-Message-State: APuU4Z9o+7RQ7QOqmy+qwOcD2U8n56IJUxwL3ptYZbh1uXQxDGbp4qYh
	qm17zksZWZmuZrx6IfQuT7sLH6Yg73LrgSCGP2DsEjvKfqXJVy3PKI4zPf6NagVX/Ik=
X-Gm-Gg: AZFdTZcapDLnYkIIasdPKP5aBb6zxTIrhO7nIqpMA9alvF1+fZeeSV7ZA7g8sgGnk34
	ZA2CqTEoeChpAUgBK8neS80jMuzfU2paYXdNtoGEWWtUnFdI5+GjK+4DFZFIgfgTT3RxyLNG7wm
	mLqrVhoWPvwFxfJB4eeVToScaJTX4rfo/xRT0JB1ECdTVXSF4QcnE7l2NI+O6FKyCtUgRfScyBs
	lGjvtBqYcbL6+ZrXH1XrVSIrfDdhj6ReobrPtQv/JCbfGrSWVanudPo7FFUpKew9hk3ASiu8IQ3
	qPvx9GT6TWxaCWrnSnroNQ/lA/0Q6jMyEDDesB9ArUlAbh6uruZsqpafQg1MYfNwd59C2ycP5+0
	CtLflinHBfLn0sl03VfPkNydku6TIqD+c0b7yVSO97qJ3QLrQ24TODGodqp/MQ7Ufaz86F41y70
	lUXEOlcELd+ourHPsPMOHzqM6j1PtUQW4W+FZPhdZmftdywKz7qAfnbBzWU/nc4gJMq7O13LpMZ
	+ml4h+SM8UAMwQ2J4VfOVxhu2vWrXgP0uEFr9Q1yrUPH7lg0OpjfblrqLR+RPiuOaGlUL2NPjGj
	GzsM+nIck+wdydj3euIyczXVa4gP9OLuP7WgTMBCJ5DWdTkW8tQwZTQoonnxP9LSq6cTpxDCiv3
	b+351YGGzJ8ooPVoY
X-Received: by 2002:a05:6000:4382:b0:4ac:a772:6485 with SMTP id ffacd0b85a97d-4aca77265d4mr33622420f8f.31.1795607215378;
        Wed, 25 Nov 2026 03:46:55 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6ae2dd55sm32783826f8f.30.2026.11.25.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:46:54 -0800 (PST)
Date: Wed, 25 Nov 2026 12:46:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v1 8/9] HID: wacom: Benefit from pointer typed
 driver_data in hid_device_id
Message-ID: <awbKcWrqDeLYFIrw@monoceros>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
 <23d19d751aea2d855bf1360fd4e84cc30d0fc8ca.1795589119.git.u.kleine-koenig@baylibre.com>
 <sashiko-outbox-232815@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksyro2nhrrdsx2fd"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-232815@kernel.org>


--ksyro2nhrrdsx2fd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 8/9] HID: wacom: Benefit from pointer typed
 driver_data in hid_device_id
MIME-Version: 1.0

Hello,

On Wed, Nov 25, 2026 at 07:34:34AM +0000, sashiko-bot@kernel.org wrote:
> > @@ -2670,7 +2670,7 @@ static void wacom_wireless_work(struct work_struc=
t *work)
> >  		    (wacom_wac1->features.type >=3D INTUOSHT &&
> >  		    wacom_wac1->features.type <=3D BAMBOO_PT)) {
> >  			wacom_wac2->features =3D
> > -				*((struct wacom_features *)id->driver_data);
> > +				*(const struct wacom_features *)id->driver_data;
>=20
> [Severity: Low]
> Should this touch interface assignment also use id->driver_data_ptr inste=
ad
> of id->driver_data, matching the stylus interface assignment above?

Yes it should. Will fix in v2, but I'll wait a bit for further feedback
first.

Best regards
Uwe

--ksyro2nhrrdsx2fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsGyqsACgkQj4D7WH0S
/k55Vwf/RZOAJuFnrv4bBC3fA7lNgaPPekk+ddBeqjs3p/0hHMG7pfqk6org8XG5
O/kXx3VdMYpSu64A7oENJ6E24VRYDolB1XfDfJaawGGvruR9nP7GTXMz9h8907J/
8WnDVYNzn9IcjAjy5nn9BY7OMzWkpgzVL7A6EIxRRhUIFkTCAYONzCHYkN6JKnaO
zU769vpcwkw5AK9P/pvSl42WBM9d5nI04ZuGnwScAiBvgXsFl64H3lD+RfQuGyxW
HCuvaLAu14F8ovmzhex+rr93339MoQyLHogK2faINu7P5x7W798SW1ux4rmIxxuq
30DEE0k8narZX6aQOMI/Psmf3D60HQ==
=7dAp
-----END PGP SIGNATURE-----

--ksyro2nhrrdsx2fd--
