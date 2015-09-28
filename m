From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device model
Date: Mon, 28 Sep 2015 18:40:51 +0200
Message-ID: <201509281840.51662@pali>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com> <20150813162602.GA15693@dtor-ws> <20150814065541.GA25515@sudip-pc>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1602862.DBRQmptcUJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37418 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933867AbbI1Qkz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 12:40:55 -0400
In-Reply-To: <20150814065541.GA25515@sudip-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org

--nextPart1602862.DBRQmptcUJ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 14 August 2015 08:55:42 Sudip Mukherjee wrote:
> > > Pali Roh=C3=A1r has the hardware and he is ready to test it.
> >=20
> > Pali, could you give the v2 version of the patch a spin
> > (https://patchwork.kernel.org/patch/6940321/)?
>=20
> Adding Pali to the cc list.
>=20
> Hi Pali,
> Are you still away from your desktop with the joystick? or can it be
> tested?
>=20
> regards
> sudip

Hi all!

I'm back with testing on desktop.

Now I applied above patch on top of 4.2 kernel and patched db9.ko module=20
works fine with my joystick. xserver-xorg-input-joystick still recognize=20
it and works fine as pointer device.

If you are curious I have connected this model to parallel port:
https://www.c64-wiki.com/index.php/Quickshot#Quickshot_II_1983

It is identified as "Multisystem joystick", loaded with modprobe config:
options db9 dev=3D0,1

So now you can add my:

Tested-By: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1602862.DBRQmptcUJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlYJbZMACgkQi/DJPQPkQ1J+RgCeP+nF6zQ+x7EkvOsGLxuE7Mts
w/wAni2zl7Cmsdd9VyvBC/iMw8bwt7mj
=pDcZ
-----END PGP SIGNATURE-----

--nextPart1602862.DBRQmptcUJ--
