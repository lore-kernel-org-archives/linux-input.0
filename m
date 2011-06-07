From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: HID joystick - Axis 11 non operational.
Date: Tue, 7 Jun 2011 12:39:31 +0200
Message-ID: <20110607123931.2267a703.ospite@studenti.unina.it>
References: <9c3f08ce41f278fc835bf09e489eef0f.squirrel@host171.canaca.com>
	<20110603161511.af4dd9e0.ospite@studenti.unina.it>
	<20110604224546.7ebb8939.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__7_Jun_2011_12_39_31_+0200_NJ3zDym4UtNRnn5l"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:59053 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab1FGKjr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jun 2011 06:39:47 -0400
In-Reply-To: <20110604224546.7ebb8939.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

--Signature=_Tue__7_Jun_2011_12_39_31_+0200_NJ3zDym4UtNRnn5l
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Jun 2011 22:45:46 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Fri, 3 Jun 2011 16:15:11 +0200
> Antonio Ospite <ospite@studenti.unina.it> wrote:
>=20
> > I confirm that the axis for Dpad-left (usage->code =3D=3D 0x2f IINM) of=
 the
> > Sixaxis looks like it is not working. I too can see the data on hidraw
> > device but not on the joystick or even the event device, so it may be
> > below the joystick layer.
> >
>=20
> OK found something: 0x2f is ABS_MT_SLOT,
> http://lxr.linux.no/linux+*/include/linux/input.h#L773
>=20
> And in input.c::input_handle_abs_event() this case is handled in a
> special way:
> http://lxr.linux.no/#linux+v2.6.39/drivers/input/input.c#L172
>=20
> This little change improves things a little bit, but the pressure event is
> now reported twice, once with the actual value and once with 0, you can t=
est
> with:
>=20
>  $ evtest /dev/input/eventX | \
>    egrep -v 'code (0|1|2|5|48|49|50|51|52|53|54|55|56|57|58|58|59)|Report=
 Sync'
>=20

The second ABS_MT_SLOT event is fired up here:
http://lxr.linux.no/#linux+v2.6.39/drivers/input/input.c#L210

when I get code =3D=3D 0x30 (ABS_MT_TOUCH_MAJOR, I am still not sure
where from), with the following hack I can make axis 11 work again but I
have no idea if I am broking MultiTouch devices, anyone?

Index: linux-2.6/drivers/input/input.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/input/input.c
+++ linux-2.6/drivers/input/input.c
@@ -169,7 +169,7 @@
        bool is_mt_event;
        int *pold;
=20
-       if (code =3D=3D ABS_MT_SLOT) {
+       if (code =3D=3D ABS_MT_SLOT && dev->mtsize > 0) {
                /*
                 * "Stage" the event; we'll flush it later, when we
                 * get actual touch data.
@@ -205,7 +205,8 @@
        }
=20
        /* Flush pending "slot" event */
-       if (is_mt_event && dev->slot !=3D input_abs_get_val(dev, ABS_MT_SLO=
T)) {
+       if (is_mt_event && dev->slot !=3D input_abs_get_val(dev, ABS_MT_SLO=
T) &&
+           dev->mtsize > 0 ) {
                input_abs_set_val(dev, ABS_MT_SLOT, dev->slot);
                input_pass_event(dev, EV_ABS, ABS_MT_SLOT, dev->slot);
        }


Simon, if that works for you too, I can send an RFC patch out, but how shou=
ld
we motivate it? The Sixaxis is sending out MT events even if it is not a MT
device...

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__7_Jun_2011_12_39_31_+0200_NJ3zDym4UtNRnn5l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3t/+MACgkQ5xr2akVTsAGWXACgnoxgpvSiuuIo25F4nHlHjcdq
gC0AoJwsWGhvMlYLgpqq3sl1GEHwCRhk
=ybJh
-----END PGP SIGNATURE-----

--Signature=_Tue__7_Jun_2011_12_39_31_+0200_NJ3zDym4UtNRnn5l--
