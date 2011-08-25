From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RFC/RFT][PATCH] Input: tsc2007 - convert to threaded IRQ
Date: Thu, 25 Aug 2011 08:21:59 +0200
Message-ID: <20110825062159.GB25708@avionic-0098.mockup.avionic-design.de>
References: <20110823061738.GA25272@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54800 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab1HYGWB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 02:22:01 -0400
Content-Disposition: inline
In-Reply-To: <20110823061738.GA25272@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitry Torokhov wrote:
> This is completely untested but I believe it should work better than orig=
inal
> workqueue solution, especially when we do not have get_pendown_state meth=
od
> available. I wonder if it will help Richard's issue with IRQ getting re-r=
aised
> after pen up event.
>=20
> Anyone who has hardware - please give it a spin.

I can see no noticeable changes with this patch.

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5V6gcACgkQZ+BJyKLjJp8wKQCgkZJ53LZPJBgZ5ZGsRjZVW/ll
HykAnRAIdFq5CCJLxSiG+LdbEzG0xfet
=caZK
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
