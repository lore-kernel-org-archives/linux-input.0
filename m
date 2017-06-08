From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: psmouse - reset device during probe
Date: Thu, 8 Jun 2017 22:27:50 +0200
Message-ID: <201706082227.50843@pali>
References: <20170605202752.8061-1-drake@endlessm.com> <5939a665.4faa1c0a.ac8e9.69e4@mx.google.com> <CAD8Lp44uQJTro4xqmmSBfhmryZje_d90LNKExNQABak+Kp+FzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5996580.Jo2oROOpzT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36131 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFHU1y (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 16:27:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id e23so4781502wre.3
        for <linux-input@vger.kernel.org>; Thu, 08 Jun 2017 13:27:53 -0700 (PDT)
In-Reply-To: <CAD8Lp44uQJTro4xqmmSBfhmryZje_d90LNKExNQABak+Kp+FzA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--nextPart5996580.Jo2oROOpzT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 08 June 2017 22:18:36 Daniel Drake wrote:
> On Thu, Jun 8, 2017 at 1:32 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > This patch will slow down enumeration and initalization of *all*
> > PS/2 mouses.
>=20
> I know it's not ideal. but do you think anyone will be able to notice
> the difference in initialization time?

In past I was working on fixing detection of ALPS trackstick and Dmitry=20
refused to add another unconditional reset during probe. That problem=20
was fixed by calling reset routine only for ALPS devices and after=20
detection that it is ALPS...

So I think Dmitry would complain about this unconditional reset for all=20
PS/2 devices again.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5996580.Jo2oROOpzT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk5s0YACgkQi/DJPQPkQ1KFtwCgxSnC8wofSbouNr4lpMPQasvC
du8AoIXJ4u5OlnmbhnbILxm44nF2DmE0
=4JDn
-----END PGP SIGNATURE-----

--nextPart5996580.Jo2oROOpzT--
