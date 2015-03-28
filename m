From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Sat, 28 Mar 2015 09:51:06 +0100
Message-ID: <201503280951.06399@pali>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com> <CAPXTYCUqibXqTBf8VKGKixKeM49LhucxFDhS+04fUsiSEKMKOg@mail.gmail.com> <20150328034335.GA9145@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5581531.JGSR7GSvxF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35025 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbC1IvK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 04:51:10 -0400
In-Reply-To: <20150328034335.GA9145@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Santiago Gala <sgala@apache.org>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--nextPart5581531.JGSR7GSvxF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 March 2015 04:43:35 Dmitry Torokhov wrote:
> On Sat, Mar 28, 2015 at 01:30:58AM +0000, Santiago Gala wrote:
> > The behaviour is the same with 3.19.1 as with 4.0.0-rc5 +
> > the patched psmouse you give me. The difference in lsinput
> > is just name and current position:
> >=20
> > $ diff -u alps06.txt alps11-new.txt
> > --- alps06.txt  2015-03-18 07:21:08.827315595 +0100
> > +++ alps11-new.txt      2015-03-27 21:24:44.285503438 +0100
> > @@ -1,5 +1,5 @@
> >=20
> >  # EVEMU 1.2
> >=20
> > -# Input device name: "AlpsPS/2 ALPS DualPoint TouchPad"
> > +# Input device name: "AlpsPS/2 ALPS GlidePoint"
> >=20
> >  # Input device ID: bus 0x11 vendor 0x02 product 0x08
> >  version 0x700 # Supported events:
> >  #   Event type 0 (EV_SYN)
> >=20
> > @@ -15,14 +15,14 @@
> >=20
> >  #     Event code 335 (BTN_TOOL_QUADTAP)
> >  #   Event type 3 (EV_ABS)
> >  #     Event code 0 (ABS_X)
> >=20
> > -#       Value   1076
> > +#       Value   1549
> >=20
> >  #       Min        0
> >  #       Max     4095
> >  #       Fuzz       0
> >  #       Flat       0
> >  #       Resolution 42
> >  #     Event code 1 (ABS_Y)
> >=20
> > -#       Value    869
> > +#       Value    877
> >=20
> >  #       Min        0
> >  #       Max     2047
> >  #       Fuzz       0
> >=20
> > @@ -59,7 +59,7 @@
> >=20
> >  # Properties:
> >  #   Property  type 0 (INPUT_PROP_POINTER)
> >  #   Property  type 2 (INPUT_PROP_BUTTONPAD)
> >=20
> > -N: AlpsPS/2 ALPS DualPoint TouchPad
> > +N: AlpsPS/2 ALPS GlidePoint
> >=20
> >  I: 0011 0002 0008 0700
> >  P: 05 00 00 00 00 00 00 00
> >  B: 00 0b 00 00 00 00 00 00 00
>=20
> Hmm, if resolution is the same I wonder if we are dropping
> some packets... Is there any messages from psmouse module in
> dmesg?
>=20
> Thanks.
>=20

=46or me output/diff looks ok. Name is based on DUALPOINT flag=20
which is cleared for non trackstick device version. And my patch=20
adding that trackstick detection for v7.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5581531.JGSR7GSvxF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUWa3oACgkQi/DJPQPkQ1JLxACguR/aWJTGWhUXa8enqj5Vo32Q
dsIAoJEQ4hJqe0v2aWrwj+rXaJVKMIud
=hcn6
-----END PGP SIGNATURE-----

--nextPart5581531.JGSR7GSvxF--
