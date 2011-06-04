From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: HID joystick - Axis 11 non operational.
Date: Sat, 4 Jun 2011 22:45:46 +0200
Message-ID: <20110604224546.7ebb8939.ospite@studenti.unina.it>
References: <9c3f08ce41f278fc835bf09e489eef0f.squirrel@host171.canaca.com>
	<20110603161511.af4dd9e0.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__4_Jun_2011_22_45_46_+0200_GvWz+X8=sTgqQDNs"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:41263 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab1FDUpy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Jun 2011 16:45:54 -0400
In-Reply-To: <20110603161511.af4dd9e0.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

--Signature=_Sat__4_Jun_2011_22_45_46_+0200_GvWz+X8=sTgqQDNs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jun 2011 16:15:11 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> I confirm that the axis for Dpad-left (usage->code =3D=3D 0x2f IINM) of t=
he
> Sixaxis looks like it is not working. I too can see the data on hidraw
> device but not on the joystick or even the event device, so it may be
> below the joystick layer.
>

OK found something: 0x2f is ABS_MT_SLOT,
http://lxr.linux.no/linux+*/include/linux/input.h#L773

And in input.c::input_handle_abs_event() this case is handled in a
special way:
http://lxr.linux.no/#linux+v2.6.39/drivers/input/input.c#L172

This little change improves thins a little bit, but the pressure event is
now reported twice, once with the actual value and once with 0, you can test
with:

 $ evtest /dev/input/eventX | \
   egrep -v 'code (0|1|2|5|48|49|50|51|52|53|54|55|56|57|58|58|59)|Report S=
ync'

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
@@ -210,6 +210,9 @@
                input_pass_event(dev, EV_ABS, ABS_MT_SLOT, dev->slot);
        }
=20
+       if (code =3D=3D 0x2f)
+               printk(KERN_DEBUG "%s: code: %08x handled value: %d\n", __f=
unc__, code, *pval);
+
        return INPUT_PASS_TO_HANDLERS;
 }


Otherwise we would need to remap the axis code to something more
meaningful by patching the HID descriptor, can this be done?

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__4_Jun_2011_22_45_46_+0200_GvWz+X8=sTgqQDNs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3qmXoACgkQ5xr2akVTsAHrZQCeJ9cd+0TcwlikslZFH3dyXuOi
RKAAnimVk7Ab9Ape36uqQRp1O1XIXw/E
=Rsdi
-----END PGP SIGNATURE-----

--Signature=_Sat__4_Jun_2011_22_45_46_+0200_GvWz+X8=sTgqQDNs--
