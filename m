From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 17:32:23 +0200
Message-ID: <201605251732.23626@pali>
References: <87eg9j6zf7.fsf@smart-cactus.org> <201605251645.47346@pali> <a8fe033e-02dd-bf26-ec49-6f271657efda@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9102119.oYyqjNnTGL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37213 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcEYPc1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 11:32:27 -0400
Received: by mail-wm0-f54.google.com with SMTP id z87so67440536wmh.0
        for <linux-input@vger.kernel.org>; Wed, 25 May 2016 08:32:26 -0700 (PDT)
In-Reply-To: <a8fe033e-02dd-bf26-ec49-6f271657efda@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Gamari <ben@smart-cactus.org>, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen_Hung@dell.com, Mario_Limonciello@dell.com, linux-input@vger.kernel.org

--nextPart9102119.oYyqjNnTGL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 May 2016 17:19:11 Hans de Goede wrote:
> Hi,
>=20
> On 25-05-16 16:45, Pali Roh=C3=A1r wrote:
> > On Wednesday 25 May 2016 14:09:57 Ben Gamari wrote:
> >>     [  714.781858] psmouse: psmouse serio1: alps: E6 report: 00 00
> >>     64 [  714.804749] psmouse: psmouse serio1: alps: E7 report:
> >>     73 03 28 [  714.830829] psmouse: psmouse serio1: alps: EC
> >>     report: 73 01 13 [  714.833568] psmouse: psmouse serio1:
> >>     alps: Likely not an ALPS touchpad: E7=3D73 03 28, EC=3D73 01 13
> >=20
> > Great! This allow us to identify touchpad more precious.
> >=20
> > Adding people who signed/acked alps commit which added V8 protocol
> > support. Above touchpad should has V8 protocol too. And it is with
> > trackstick.
> >=20
> > Any idea why is not recognized?
>=20
> This is likely one of the new hid based touchpad / trackstick
> combo-s.

Allen Hung already wrote:

"We have just confirmed the touchpad on Latitude E7470 is a PS/2 device,=20
not an I2C-HID input device."

and

"I got responds from Alps and they confirmed that the Alps devices in=20
Dell systems are speaking in protocol V8."

So I would say, it is really PS/2 device and we are missing support for=20
it in alps V8 protocol ...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9102119.oYyqjNnTGL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldFxYcACgkQi/DJPQPkQ1JlSQCeIZTnrQ+tiYdcOwZ8XelIb7Vf
7vwAn0grVFupB92ebKZh2AdRxwiIQAa6
=cqmc
-----END PGP SIGNATURE-----

--nextPart9102119.oYyqjNnTGL--
