From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] appletouch driver and 4th generation macbooks
Date: Thu, 03 Apr 2008 12:08:29 +0200
Message-ID: <1207217310.3636.0.camel@johannes.berg>
References: <47DAB465.7090100@twam.info>
	 <1205588795.15910.34.camel@johannes.berg> <47F36B03.4060704@twam.info>
	 <1207135383.10910.39.camel@johannes.berg>
	 <20080402101704.ZZRA012@mailhub.coreip.homeip.net>
	 (sfid-20080402_152027_997573_96CBDDA3)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zCo/ku4AAMVLUj50T3sH"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:41013 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYDCKMT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 06:12:19 -0400
In-Reply-To: <20080402101704.ZZRA012@mailhub.coreip.homeip.net> (sfid-20080402_152027_997573_96CBDDA3)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tobias M?ller <Tobias_Mueller@twam.info>, linux-input@vger.kernel.org


--=-zCo/ku4AAMVLUj50T3sH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> I applied the patch to my tree. I will try to push the change to Linus
> before 2.6.25 since it is very low risk.=20

Good, thanks.

> Btw, is_geyser3() function
> is becoming unwieldy. We might consider changing it to something that
> scans array of integers instead of adding more conditions to that "if"
> statement next time we add more IDs to it.

Yeah, good point. I'll try to remember when the next person comes
around :)

johannes

--=-zCo/ku4AAMVLUj50T3sH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/SsnKVg1VMiehFYAQJYsQ//ZXvpRn3JNFjQ9F67CizaQY2AhxerRRQ8
WQ4JsW0K+QXXR2tZ7gAXqTCISAQWj3UPwpycp8EzQdFmzAlwAj8U8daXtr2qPDo0
9A9hnOiYIXZ5peLLCfYTyQGbZYprbXEMtFMWTXQ1UXVlOmzQ0/bn/C0BCbd/Gcx1
Z8DLuxXj+r986qYmzDEN1R7xKRm2R6QQCQW8/XzBxuWSp78HPmCHRnw7WIF2v6RO
l8Q7k8G/Lg6OQHiBiJ/d4EIWGS2N8XMbTbji88PLHOD9PaGLH5HEYPb405WTB/My
RCIcAhb9jB9Ttjz5RBUGd8hxLutaeBtA7QDI0LvgWvC8O/9hKQbvUuCF2t4a7nr7
SLjkt0RezpQX+EJvzAD+DVoe1ixKKSDsJCIxq5x3uSk1nEL48oYI1wppXDPlc/b0
5YjK80X0Ooj+qt7R8SqGcOG/QfdmVkluuG7AmL1th+MnaCkUXQhe1+iGfDwm11cI
y5QmP4OIzpoWYU71yRLJhoG9nH2F9QjDtOWQEz6AUsDXdmj5g76es96tofr/V/YI
5TDgvpSLHY/7+6YXaUcG9A+b/YEUhmYgbMEp17xUIn1kXpXQiL3kJArgDoizLEoi
S4wO7fbOHbQ5J68E9uC0qBZ9mkYvv+fWkrxkLs4/oXCDqfFjS6CCcXjSaiqSmny9
7ljmFX1Ow48=
=rU7W
-----END PGP SIGNATURE-----

--=-zCo/ku4AAMVLUj50T3sH--

