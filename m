Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600D30EF64
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142547; cv=none; b=fnlliyF+cczcEsv+74NiZLu/T3hH1MfYhPjgkEH/KDDYGVtbci9jy2T2LCBNsV9xVVqDPnqkFJ1efMBxUb3xaFjAdYspRoxL7w/YdDRce4TsLdAv+ZCBbxd7OKulzT3vk/zKUfKYbIXY6YgFAyNmZIfVDHNMYP9yB+88ibHN/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142547; c=relaxed/simple;
	bh=g6tqcbL7AO7mmYTpPgLqdEp3sbUIa6noaf2JnjQy1rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGjWIfWiKTikop99L8w3zMTDj3pfvWA79BIu9YUFyrHasHrfh0Db32+eki9xc7/rc3ETc1Pi4LivW5B4e91li6uB5MaC1Z1H6ek4I9ShCOLyLR65EZecjYxRzu5Fi46OgRwni/pWOjCAq3Gb8OK3jisOCjkmuC5npx8CA9NTwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dBfXCJh6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dBfXCJh6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4906238c62eso65285585e9.3
        for <linux-input@vger.kernel.org>; Sat, 30 May 2026 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780142544; x=1780747344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgNiBxvAE0zM3QGPzW0VTokh/HeWsq2F7ow5cn6lSMc=;
        b=dBfXCJh62S2QJYjBWEvhcphjWoV2j647UB7czp5Y64Cb4tGbc57dOwT67vKoYWedpE
         5gCi7PIA7eLEAZbHFVPOrqjOouynNFP+RThs1QMccGBpPXxAXwwG80geCn/Ipsdh5EdN
         4W3CeYLqR7p8URPxr4u+QIjKROlV6WRrSQac2l2yl1rWYjbGUfkTpZ68etfcF9BYbpgg
         3kO/tc5LBo/sQUeMKjOJSMXSA0haZOFxduuHZQzbhWbpM5iFoyyj97XRBDqAGxF7KdBd
         BfZ8Ic0kLRhnym/5GPKbpLaKzoKMD/hVApHAtFV6ywOHNgrKy0/eC1kX8dAUOJHPMzLQ
         pTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780142544; x=1780747344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgNiBxvAE0zM3QGPzW0VTokh/HeWsq2F7ow5cn6lSMc=;
        b=i9JQe/oQ8zoJxscYn6Twn9zgokHNQ7yyfT9TVRGcUo4LYnu1VWJcjez9wSyUGRqONy
         Pl4vArpnpQ/9U8JIa8OosoJi5xD1zGbOGNmA77y30hc3qoF3L2qjARdQQOpsdj2KUYvJ
         bgGjELmXQ5dAczGw9BM8zapdSmLtlImIVkFas8FCQ2jpqT57s/HkPzYqP7TDV5KK82Lm
         t2trbE+CQ5gj9RH4J6AvVrHHS2ITUPBCLZIanU6C4YeuUiqIa8ZkILZ4+sHw2Hbh7GEJ
         j33MHSbWa6AvE5SjtUQHShxGBXjxLB8ap5ykX/sCqqU2kPjWHgcZmMeRoSowzIQztLNi
         cXDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KDCj+i83zsQcW94StOx0D2ibCddCkwNwdupv1vE0Iro8BpXKFVw6IoLXXmzJmvV8wYKyAvVcVWh6CnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeW+Z2DDkgbZjll8pMJpyap0Tcm92jqKR61Y4o4mPm9xqsUNpA
	YvLhBuQKtJw0wH9V5Nx2ESaroFQWh8olNdouXGv+uCBRlKOMbbRwynuXxOjRQMzxo64=
X-Gm-Gg: Acq92OG3lnF/L2sgG2vfGPes5VnkW3EDo7OU02FzzUHEHad2gw3iZ4mOxU2/cbWXCoj
	XgR0EE5Z4GRLOjNFNpWWLzUSs+yOQER+cK1rWDxoFz81htzLFS8is3MF/cYHrC/0T04SaGJeAuH
	pSNjy1HsLD9OTOSJTKZlC28P0ZqPxe3ejBmnAxXPEuk1R1QBeRhdeHUuHsmL3HF724g90RYUZFV
	nAIP6OYSSdN31D8VtRHjMXWurpBYEENNyyhbFDAT7TEP5VmCU1uLkQzFWlf/Y8l8zu8S+57CZWg
	Dbo6zmYmjnmvZczbfyboYP+vX8NoUbSFxZcr1Q0SkCHw0E/xEnywfo/ypoHu8X9tnXxT332goyS
	bIqLezUE+PhKrlUXl7qAneoQORQo/85K64T+u5m3GMRSHqbEFZWSb5J70DURQL26w79hR0YmUit
	pFWXxp6EXXPOQ2+3nZJTvTkgV+s4F6S1KNLEObzSOUssGcHX13aA==
X-Received: by 2002:a05:600c:6558:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-490a294b864mr44962555e9.28.1780142543403;
        Sat, 30 May 2026 05:02:23 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909caa7faasm103845575e9.11.2026.05.30.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 05:02:22 -0700 (PDT)
Date: Sat, 30 May 2026 14:02:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Yassine Oudjana <y.oudjana@protonmail.com>, 
	Linus Walleij <linusw@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Support Opensource <support.opensource@diasemi.com>, Nick Dyer <nick@shmanahar.org>, Hans de Goede <hansg@kernel.org>, 
	Job Noorman <job@noorman.info>, Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Kees Cook <kees@kernel.org>, bui duc phuc <phucduc.bui@gmail.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Yauhen Kharuzhy <jekhor@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Minseong Kim <ii4gsp@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Oleh Kuzhylnyi <kuzhylol@gmail.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Josua Mayer <josua@solid-run.com>, 
	Michael Tretter <m.tretter@pengutronix.de>, Jeff LaBundy <jeff@labundy.com>, 
	Javier Carrasco <javier.carrasco@wolfvision.net>, David Heidelberg <david@ixit.cz>, 
	Petr Hodina <petr.hodina@protonmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Xichao Zhao <zhao.xichao@vivo.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1] Input: Use named initializers for arrays of
 i2c_device_data
Message-ID: <ahrP4STTFdUsBp0O@monoceros>
References: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
 <ahp7WuHiPYa7Q_pX@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hgmmhirtt5ohzik"
Content-Disposition: inline
In-Reply-To: <ahp7WuHiPYa7Q_pX@google.com>


--5hgmmhirtt5ohzik
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] Input: Use named initializers for arrays of
 i2c_device_data
MIME-Version: 1.0

Hello Dmitry,

On Fri, May 29, 2026 at 10:56:48PM -0700, Dmitry Torokhov wrote:
> I like the ability to properly set up pointers for driver data, however
> I do not think we should use named initializers for name field. As long
> as we are not planning on moving its position I like the brevity of just
> saying
>=20
> 	{ "ili210x", .driver_data_ptr =3D &ili210x_chip },
>=20
> Can we keep the old style for the name field?

I have no strong opinion here, my patch introduces the named initializer
for both members for consistency. Note that my patches for all the other
subsystems (and also other *_device_id) do the same and you're the first
maintainer with that expressed preference.

I even sent a few patches that adapt initializers without .driver_data
(e.g.
https://lore.kernel.org/all/177932943265.3832404.360063047381979287.git-pat=
chwork-notify@kernel.org/)
that got positive feedback so far.

So if you're ok with having input differ in style from (up to now) all
other subsystems, I can rework the patch.

Best regards
Uwe

--5hgmmhirtt5ohzik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoa0coACgkQj4D7WH0S
/k5r2ggAr649aJrsJJlkFeVB/fh8+B5LDe4ym+MWA77b0yhq2eW8wormOagLI3cS
ZsKy4bfc4GPxEs6Hq4U1Xtb5rZQ4FZl0S07+51ZaYlq5RbMC/B/SVTiuASJVBVPZ
B4s5kh1AWRq20efV0vpGmMVkGWdWbbWfSDJ88TI8OoCIHy0LYFyBfz9XdnD2pdag
csvvcPKwLzXbvnQDsAb1CyMxa0P5xeJSgzH5Zq3dkY7GCsHzqv+4dmXzIRjgXwmE
F0tGpraE9YOlHYxoqXNfPa2xIKxihaRChziJOKNt3hN9BQ75tAHWpwEFGWDYHn8c
xpL0QD4yV6RvVsMilRsLYNC4h2ZaoA==
=umK9
-----END PGP SIGNATURE-----

--5hgmmhirtt5ohzik--
