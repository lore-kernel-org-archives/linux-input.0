From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Sat, 9 Sep 2017 10:36:06 +0200
Message-ID: <201709091036.06899@pali>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net> <201709080848.53286@pali> <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2805962.aIrZirKADc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:45706 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757421AbdIIIgK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 9 Sep 2017 04:36:10 -0400
Received: by mail-wm0-f44.google.com with SMTP id f199so14795274wme.0
        for <linux-input@vger.kernel.org>; Sat, 09 Sep 2017 01:36:10 -0700 (PDT)
In-Reply-To: <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juanito <juam+kernel@posteo.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, Paul Donohue <linux-kernel@paulsd.com>

--nextPart2805962.aIrZirKADc
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 09 September 2017 10:12:42 Juanito wrote:
> Hello,
>=20
> On 09/08/2017 08:48 AM, Pali Roh=C3=A1r wrote:
> > On Friday 08 September 2017 07:00:34 Juanito wrote:
> >>> ThinkPad with ALPS? Should not be it Synaptic? Maybe
> >>> miss-detection?
> >>=20
> >> Sorry, I forgot to mention this. The ThinkPad came with a clickpad
> >> I **really** disliked, so I bought this on the Internet.
> >=20
> > So, here is a problem. ThinkPads works with Synaptic touchpads, not
> > with ALPS.
>=20
> There definitely seems to be a problem here :)
>=20
> Do you mean that the alps code might not be detecting the trackpoint
> because probably the red thingie works with synaptics?
>=20
> So could this be the situation:
> ALPS driver: Hey touchpad! Do you have a trackstick?
> ALPS touchpad: No, I don't.
> AD: Ok! (and thinks 'I am going to have to ignore all trackstick
> packets that might arrive')
>=20
> So the driver understands that there can't possibly be any buttons
> because there is no trackstick?

IIRC ALPS touchpad hardware itself does not work with non-ALPS=20
trackpoint.

Masaki, any comments?

> >> If by trackstick you mean the red thingie, it is **not** working.
> >=20
> > Ok. And it is working with your patch?
>=20
> No, it isn't :(

I expected... You just created franken-hardware.

Looks like with your hack patch it is possible to make buttons working,=20
but I suspect that trackstick would.

Maybe Masaki can provide more information about this fact if we can do=20
anything.

Dmitry, what you as maintainer going to do with this problem?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2805962.aIrZirKADc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlmzp/YACgkQi/DJPQPkQ1LgUQCfdtxpIKguyy0VEbp/JnN1gl4s
7vQAn3E0L3V/r0miG3kA65z2/w6e8Cuz
=ef5f
-----END PGP SIGNATURE-----

--nextPart2805962.aIrZirKADc--
