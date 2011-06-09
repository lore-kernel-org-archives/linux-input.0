From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCHv3 2/3] Re-add manager_get_default_adapter()
Date: Thu, 9 Jun 2011 17:00:11 +0200
Message-ID: <20110609170011.ad822f40.ospite@studenti.unina.it>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	<1307538557-9287-3-git-send-email-ospite@studenti.unina.it>
	<1307628154.2669.212.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Jun_2011_17_00_11_+0200_zw._b_1tdKTT8e3p"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:57291 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab1FIPAS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jun 2011 11:00:18 -0400
In-Reply-To: <1307628154.2669.212.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>

--Signature=_Thu__9_Jun_2011_17_00_11_+0200_zw._b_1tdKTT8e3p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Jun 2011 15:02:32 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Wed, 2011-06-08 at 15:09 +0200, Antonio Ospite wrote:
> > From: Bastien Nocera <hadess@hadess.net>
>=20
> Sent out a new patch for that which allows the same functionality, but
> returns an ID instead (you can then get the btd_adapter through existing
> manager functions).

OK, so basically I drop 2/3 and do:
adapter =3D manager_find_adapter_by_id(manager_get_default_adapter_id());
right?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__9_Jun_2011_17_00_11_+0200_zw._b_1tdKTT8e3p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3w3/sACgkQ5xr2akVTsAF3yACeN+KcennyoyzJb+iiG9Ix70Th
znIAnRMCvO5RYbhXB3ppWDCg02AO5aIe
=Nv2V
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Jun_2011_17_00_11_+0200_zw._b_1tdKTT8e3p--
