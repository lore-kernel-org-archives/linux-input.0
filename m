Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91353F8257
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328447; cv=none; b=IqnLNBaOB5oG+a5+DTVYOHfzRcdZqV0IkkzOC/UzPVy9YmmLDfRWJuLkwKvRNI5U/6FNEyLMGLUoJl4MPYTyRG+4VEeAaMKYLogdn6owqajclQ6FZpG0V9ixziZppsgCffXbII/SOtXjWWE96y7BARlDi+rrC2BgJEWnvg0rtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328447; c=relaxed/simple;
	bh=HeAEDpOyWDfK0HywfMKKJR7m/lfHHAOTVtMyX32Yin4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANNlNI67qtAv72AD+CUnctVGS86QIBwLvu9rbSeEQdbdnV5bkN/GWTPwuPU2yBIPLO/lQJqzO67Q6o2exfsnqRczvbtrFs7yfZyJbhCqaTuXOAvHiB7Eq8S4pGgyCHW+iSkFJTCyXwokwmOGLGkz2JsPrIHlYZ196PRCpW5h6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JyLSAyA7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JyLSAyA7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49553515a8bso11534115e9.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785328442; x=1785933242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hj7jv6pRB6x5AF5ocoOAZbiwUraKrz6rxk84/RgEz0M=;
        b=JyLSAyA7JLsBjzsv5sIAMPO8UgSES5gspaHVhSgXArmDW4bnZ3K4YkR+4qtU1fywnQ
         Irjg6ff/Nvjc9ubPdR9GnYaiSVWJ6Da7YS4a2hnizuFlf9PDpqpYTwK03dtfX8cAxayz
         3UIZ5GdqQYnTu1hiva6mTgO8/7DP+6yIaC7oIU6+J9wmD2Rn8dcoVWOezjHdTsbyn5Mk
         wpC1l0wxXWdOpnXu+GBVY3mIhqePwqtPbHJTgwmpDO+x1laQYOe+JfuOWdoTQefrmkOK
         MowjE8U9DfsaCnyRNE5JCeZysqJapQ45v5K48JDGha168J44FXT5NQUi73Yy62IRY1vI
         IhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328442; x=1785933242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hj7jv6pRB6x5AF5ocoOAZbiwUraKrz6rxk84/RgEz0M=;
        b=DNNrUICqsJ2kVY+K8uo+xstDiVNlFyXccNfRBkEdttEEElKiC06wbgFJpdr0xTAxd1
         xXVwIkZLtqljQL5hEBMb1RJCfp/M4Zy6CW8PAnG9dMxtMNmkx7gZ+qrnQQ5iHejklLM4
         DF8HGlmG/veociO8Mep9jtKFv1Dd/25Lw93ClbyxntoExN/GaB2YwpHu5454rQB7ztMC
         JfRWgwt504X30l3iCcpDWWXmRAWsi+/Ipmc2dfPGgGWSPnMjJyl2F5N+dcARGxINTgru
         pXmOkisIkkk6UE1199p0dgPqRG/PXO8mAbohaP5D3G+HJjGsC4Gj1QPXMfaz3xJstwww
         5lbg==
X-Forwarded-Encrypted: i=1; AHgh+RoXY+LTbI0h+pSlwJX7bRTn4RpuwlEfsjsLOLRUxhmPPWrf/ZJTCGQt/DsLrIDeWRbN7oJSQ+JueJjNVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtBS9BaNrup71KyKuONRi6stKfnUenz5+gb02stqdJZyWVsdu
	heBb0BDyDkf3LwoeFw3lcuZUPst8dYgUCM4G+eFHEOQ/LCiT2AAuzjcg2mJK9kR/wUs=
X-Gm-Gg: AR+sD13Q7jk4JbT5jZcRLoraaZiLIqeKjjtgb7CqI/DMn9OXP7hBkkqLsZWYVwK2p/H
	6WfLKRKM1TFexAohDVnKWdyvlI01BuMr2fntaOiaajAyrHxoeqRFrpE6P7Cru1v7gjhKO+0Mz2f
	7ACJPf3B3TqsN5LQ6JtSMheZFpPUHwfez2clY4FBJIYQ5HRN7+/nR0LtXU1z8J+f2ybctOoPqsO
	2UtnZi3rSynetLr+VbHn4b/89Ff5x5WmPk7+PVWt2GNSe0NVP6ggd9J4KpzEL9u5/LemkrTCCO0
	1sleo4gLKPWjxL9Jjmxdu3YSvgtHupkfAMTNgdACcli8zSngN/wyXiLZ0pkl/3HBaXLXYaPqeSz
	ifkK4EwEzrxcjkn3WN+nyVL3929qABSj98N+ZzRY4q+d5Aos313iOvPvKEp6xa+avyXvBsKFbuS
	N5yAtUDDXXi3wj3XL+jfFNZGUaD5Aq50hmo690AuT5jmdlZfoGbOMmYmzjzIUoGmqOWVf9xXDRM
	3MgXp3tl8avXpiB0cIqHWezcGfzDqb0am3zIhsqWQe47egixLHhfdzz+rKULg==
X-Received: by 2002:a05:600c:1f95:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-496c64261d4mr74271315e9.3.1785328441446;
        Wed, 29 Jul 2026 05:34:01 -0700 (PDT)
Received: from localhost (p200300f65f47db0401da7fd03a16a046.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1da:7fd0:3a16:a046])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49764d6d0f8sm50701985e9.2.2026.07.29.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:34:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:33:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <amnxliqWscD4Mjdz@monoceros>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-3-clamor95@gmail.com>
 <amGx2fJCUB4_XW1M@monoceros>
 <CAPVz0n2yWtTOgruRc+MAYTZ9=rd6qf6sEnX9v8THvJkN_opvbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dqlofrf2szwmrad"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2yWtTOgruRc+MAYTZ9=rd6qf6sEnX9v8THvJkN_opvbA@mail.gmail.com>


--6dqlofrf2szwmrad
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
MIME-Version: 1.0

On Sat, Jul 25, 2026 at 04:23:13PM +0300, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 23 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 09:25 Uw=
e Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hello,
> >
> > On Tue, Jul 21, 2026 at 12:52:28PM +0300, Svyatoslav Ryhel wrote:
> > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > >
> > > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 do=
ck
> > > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > > detection and common operations for EC's functions.
> > >
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Documentation/process/submitting-patches.rst has:
> >
> >         [...] the ordering of Signed-off-by: tags should reflect the
> >         chronological history of the patch insofar as possible [...]
> >
> > So your S-o-b should be last when you submit a patch.
> >
> > > +#include <linux/i2c.h>
> > > [...]
> > > +#include <linux/mod_devicetable.h>
> >
> > <linux/mod_devicetable.h> will go away soon. Please rely on
> > <linux/i2c.h> to provide a definition of struct of_device_id and drop
> > the #include of mod_devicetable.h.
> >
> > > +static const struct of_device_id asus_ec_match[] =3D {
> > > +     {
> > > +             .compatible =3D "asus,sl101-ec-dock",
> > > +             .data =3D &asus_ec_sl101_dock_data
> > > +     }, {
> > > +             .compatible =3D "asus,tf101-ec-dock",
> > > +             .data =3D &asus_ec_tf101_dock_data
> > > +     }, {
> > > +             .compatible =3D "asus,tf201-ec-pad",
> > > +             .data =3D &asus_ec_tf201_pad_data
> > > +     }, {
> > > +             .compatible =3D "asus,tf600t-ec-pad",
> > > +             .data =3D &asus_ec_tf600t_pad_data
> > > +     },
> > > +     { /* sentinel */ }
> > > +};
> >
> > Trailing comma after the assignments to .data please.
> >
>=20
> Sure, but out of curiosity, why in this case you ask for trailing
> comma and if entries are in one line, you don't.

Because this is the most used style. The rationale for the trailing
comma is that if you want to add a new assignment to a multiline
initializer you have to touch the line without comma:

 	}, {
 		.compatible =3D "asus,tf600t-ec-pad",
-		.data =3D &asus_ec_tf600t_pad_data
+		.data =3D &asus_ec_tf600t_pad_data,
+		.something_else =3D &foobar,
 	},

so if the comma is already there, the patch reduces to:

 	}, {
 		.compatible =3D "asus,tf600t-ec-pad",
 		.data =3D &asus_ec_tf600t_pad_data,
+		.something_else =3D &foobar,
 	},

=2E For adding a new assignment to:

 	{ .compatible =3D "..." }

you have to touch the line anyhow, so there is no advantage to already
have the comma. And then it seems parsimony prevails.

Best regards
Uwe

--6dqlofrf2szwmrad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp8zUACgkQj4D7WH0S
/k6ZNAf8DhR7uBfXuQZzNcJ2dR9KB5Mucc4l5ZRolBWJcq6FHN8KK2BbDb+bkrcE
pUhYeNPt0LnZBA6JHWhJAM1zlHnLaQ2PlBWxeR4EIwAhM8nyXcfHgmgMJxBHSeEQ
qHWXZKtQd90uCGYg4BnQO8LmgAQR610/ujayOjnD0EgB2Wy19ZkENuG5Nu+Irzef
8DWW0WMWbrTCP49l4fgVWsLE8/yOaBE1jBeyaZ17yXLwz5vbs6OfeCkqaK11AOnH
KXbRlcea/K7YZX7wPKZLhHMSvmzSk+NEQgQpg7+qgg7NYMLDgJFCfvFTWhNj5lqb
GcHcRJv6c3GBFhS3t9oSrHiBeXrX0A==
=JxD4
-----END PGP SIGNATURE-----

--6dqlofrf2szwmrad--
