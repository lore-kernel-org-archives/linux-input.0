From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH FIX for 4.0 0/2] alps: Report alps v2 Dualpoint Stick events via the right event node
Date: Wed, 1 Apr 2015 18:11:03 +0200
Message-ID: <201504011811.03302@pali>
References: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1444980.Be6GJK8k5c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38336 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbDAQLG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Apr 2015 12:11:06 -0400
Received: by wibgn9 with SMTP id gn9so72837858wib.1
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2015 09:11:05 -0700 (PDT)
In-Reply-To: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--nextPart1444980.Be6GJK8k5c
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 01 April 2015 17:44:04 Hans de Goede wrote:
> Hi Dmitry & Pali,
>=20
> While working on some libinput code to deal with trackpoints
> of different model laptops having quite different speed /
> sensitivity ootb, I noticed that with the current 4.0-rc#
> kernels the trackpoint events on laptops with a PROTO_V2 alps
> touchpad are no longer being send by the "Dualpoint Stick"
> event node, instead a new "ALPS PS/2 Mouse" node gets created
> and sends the trackpoint events.
>=20
> The cause of this is that the stick on these devices sends
> bare ps/2 packets as data.
>=20
> Although this does not really break anything (atm, it does
> break my libinput work), it is still wrong, esp. also since
> the "Dualpoint Stick" node has the POINTING_STICK property
> set, where as the "ALPS PS/2 Mouse" node which is actually
> sending the stick events does not.
>=20
> If still possible I would like to see this fixes added to 4.0,
> if not we should queue them up for stable.
>=20
> Regards,
>=20
> Hans

Hi Hans, thanks for testing!

I would like to see this observation also in alps protocol=20
documentation, where is all information how are data from=20
touchpads and tracksticks reported.

Also for me it it makes sense to squash both patches into one.

And can you check if your change is needed only for=20
ALPS_PS2_INTERLEAVED devices? For me it looks like that only=20
those alps devices could mix both 3-bytes and 6-bytes packets...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1444980.Be6GJK8k5c
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUcGJcACgkQi/DJPQPkQ1JTOQCcCsaox1wC1wYxDapZ/aZ/7f4e
/EcAnjwq++ZSnDeRU6HwmIc71R9E+wNy
=O9ju
-----END PGP SIGNATURE-----

--nextPart1444980.Be6GJK8k5c--
