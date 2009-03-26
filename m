From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Rawmode keyboard for your....
Date: Thu, 26 Mar 2009 18:59:25 +0100
Message-ID: <20090326185925.79ca6833.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__26_Mar_2009_18_59_25_+0100_ZGvKiHs2RgoDnQJh"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:49464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760096AbZCZR61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2009 13:58:27 -0400
Received: by fg-out-1718.google.com with SMTP id 16so970643fgg.17
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2009 10:58:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--Signature=_Thu__26_Mar_2009_18_59_25_+0100_ZGvKiHs2RgoDnQJh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

What exactly does this build warning imply?
We have a fully working keyboard driver for the Jornada 700-series
and would really like to get rid of this.


  CC      drivers/char/keyboard.o
drivers/char/keyboard.c:1126:2: warning: #warning "Cannot generate rawmode =
keyboard for your architecture yet."
drivers/char/keyboard.c:1126:2: warning: #warning "Cannot generate rawmode =
keyboard for your architecture yet."

Best wishes
Kristoffer


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__26_Mar_2009_18_59_25_+0100_ZGvKiHs2RgoDnQJh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknLwn0ACgkQPQls10ERAGfd6wCaAkAZNa6SNkAfT4mwJyA4nBv9
AygAoIL+WGOERVecGemFEbqspsMKHz+A
=ngus
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Mar_2009_18_59_25_+0100_ZGvKiHs2RgoDnQJh--
