From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 18:48:12 +0100
Message-ID: <201611121848.13617@pali>
References: <20161111235759.11988-1-chris@diamand.org> <201611121604.43032@pali> <CAHc7Qt2xPTsWbjZdy1FBWCT5Lz43=9Tzj5FVpsn87=6VfFmPGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4207773.ug2hyLgHpE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38025 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbcKLRsQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 12:48:16 -0500
Received: by mail-wm0-f48.google.com with SMTP id f82so31118122wmf.1
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 09:48:15 -0800 (PST)
In-Reply-To: <CAHc7Qt2xPTsWbjZdy1FBWCT5Lz43=9Tzj5FVpsn87=6VfFmPGg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Pospesel <pospeselr@gmail.com>
Cc: Chris Diamand <chris@diamand.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--nextPart4207773.ug2hyLgHpE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 12 November 2016 18:33:57 Richard Pospesel wrote:
> > How is windows detecting presence of BYD touchpads? Should we use
> > something similar? Or are not there some (public) documentation
> > about it?
>=20
> Windows doesn't detect it correctly without BYD's kernel driver
> installed.

Yes, that is expected. What is needed to to find out how that BYD's=20
kernel driver detect if device is normal PS/2 mouse connected to=20
ordinary PS/2 port, or if it is PS/2 BYD touched.

Microsoft has only preinstalled genetic PS/2 driver, so touchpad is=20
probably working as ordinary mouse (if that BYD's kernel driver is not=20
installed).

> The only publicly available info on these can be found here:
>=20
> http://bydit.com/doce/products/microelectronics/2474.html

Webserver is really slow... HTML page is still loading...

> Iv'e already tried getting mroe info from BYD, all they could find
> was a PDF which enumerated the gesture types and the packet id used
> for each (byte 4). No info there regarding protocol, etc.

I understand... it is hard to get some information...

One option is to trying to ask BYD again, another is to try reverse=20
engineer or sniff data exchange from windows driver.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4207773.ug2hyLgHpE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgnVd0ACgkQi/DJPQPkQ1LUaACeOsOoeoaxMMybC8EP3aISAK0K
SPQAn1xjufqmO8RS0+taidK8yNqXzvu3
=Y+60
-----END PGP SIGNATURE-----

--nextPart4207773.ug2hyLgHpE--
