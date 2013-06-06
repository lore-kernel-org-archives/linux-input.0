From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/53] Input: atmel_mxt_ts - Add memory access interface
 via sysfs
Date: Thu, 6 Jun 2013 11:46:51 +0100
Message-ID: <20130606104651.GS31367@sirena.org.uk>
References: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk>
 <7380889.l4hHqCT0mm@dtor-d630.eng.vmware.com>
 <51AF8730.4010507@itdev.co.uk>
 <1717403.GgHsbyUkDZ@dtor-d630.eng.vmware.com>
 <51AFA02B.3000604@itdev.co.uk>
 <20130605210715.GA16013@core.coreip.homeip.net>
 <20130606094822.GB1883@sirena.org.uk>
 <51B06732.2050701@itdev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jobRqqe4Hp8P9iE7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:50814 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141Ab3FFKrO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jun 2013 06:47:14 -0400
Content-Disposition: inline
In-Reply-To: <51B06732.2050701@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org


--jobRqqe4Hp8P9iE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 11:40:50AM +0100, Nick Dyer wrote:

> I am more worried about the address pointer handling and the I2C retries.

The retries can just be done further up the stack?  All regmap is doing
with I/O errors is punting them straight back up to the caller so the
caller can retry just as well using regmap as it can using the raw I/O
protocol.

Without seeing the address thing it's hard to comment.

--jobRqqe4Hp8P9iE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsGiYAAoJELSic+t+oim9xsoP/jcQvo/QMsM9846ltzkPoNLz
xcRCeEF+gYgR9ubx1mLeLTyyPnZttUbWJ/WMnVihaghjQ6kezanUXNWj2WhXXaLI
GnOBLSqOR20IoaK9yEq5pAH9YdCpR7PyanOur+L82U6flrIFB8AJycxq8nHWXgAZ
0AIlOo4ua7OCXFC2H4TIgpGdY0akQwyw3NYIbjU2d9vGAS+oMa9LJrEcltbdhWbw
uYCtQuL+rTEAXQS6nQeHqJT+Ou6Es2S0z3DkIihou8YmsCP+9kHG7sEFwEKC6mai
5ICZMlWrimjnsPej1/ASrUTRdzzUeAVzOIQ47MiF2TsJpYJrXj+rqYLYepduA+Qf
whzTTGgzgYFBp3VOoQ5XZJZL6mHNNot06gr9I9Po5jB35KrGuza2zHdfAFSW+elX
OA4WrrA/HJ9CXqNNiTT27ZEF6g1wJkqrXzBjZAXpgK1DpaTiQTszqYMWV7ihUsho
OEbL47damSWp3eOW/kC9JmCsbmqy4gyLnMQ38ls3jq8THYLqGXZX1EtEBMROFS9/
WSG/roJAW+4btBsNqMs6/fnMIOq1qxl3d29LgrKaY/Dy0ojR3WfUwZlsZbEGNjjz
C6imF73xC2i/O4qL4LZDtyY3No5Zo0uLLfAPfAZaveFC57kNIGwWguMBqXgbZ+Zd
FzudAS7vo/wMFjfYCOdt
=w3YI
-----END PGP SIGNATURE-----

--jobRqqe4Hp8P9iE7--
