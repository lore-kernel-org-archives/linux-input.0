From: Antonio Ospite <ospite@studenti.unina.it>
Subject: How to send/receive a feature report with hidraw.
Date: Tue, 27 Apr 2010 22:59:10 +0200
Message-ID: <20100427225910.82d980d4.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__27_Apr_2010_22_59_10_+0200_cX2NX0wHngcWEQ4Q"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out110.alice.it ([85.37.17.110]:3109 "EHLO
	smtp-out110.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0D0VJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 17:09:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: hadess@hadess.net, Marcin Tolysz <tolysz@gmail.com>

--Signature=_Tue__27_Apr_2010_22_59_10_+0200_cX2NX0wHngcWEQ4Q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

there must be something that either I am missing or that is missing in
hidraw, I'd bet on the latter _this_time_ :)

I was trying to add "proper" association support for the Sony Sixaxis
Controller, "proper" means without libusb detaching and reattaching the
hid driver which is not particularly nice to evdev or to the user.

In order to do that, the following steps are needed:
 1. I need to _read_ the feature report 0xf2 out of the device in order
    to know its bdaddr so I can tell it to the bluetooth subsystem
 2. I need to  _write_ the feature report 0xf5 to the device in order to
    set the master bdaddr into the controller

I cannot do that with hiddev because the reports above are not listed in
the device HID descriptor and hence they get filtered out.

So the choices are hidraw or a custom sysfs kernel interface.
I decided to give a try to hidraw first, but:
 1. I was not able to find a way to read a specific report
 2. I can only write output reports, see in hidraw.c::hidraw_write()
    ret =3D dev->hid_output_raw_report(dev, buf, count,
          HID_OUTPUT_REPORT);
              ^^^^^^

If it is confirmed that hidraw can't do what I need, yet, then I'll
propose the aforementioned custom sysfs interface under hid-sony which
works quite well.

Thanks,
   Antonio

P.S. I am not subscribed to linux-usb, please CC me if you get the mail
from there.

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Tue__27_Apr_2010_22_59_10_+0200_cX2NX0wHngcWEQ4Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvXUB4ACgkQ5xr2akVTsAHj3QCfcsD84qqUysTX7JbTRfP5cxwx
V0EAnA0Jaj1Pyui+bUylbEH1xbRHG6LV
=dFXg
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Apr_2010_22_59_10_+0200_cX2NX0wHngcWEQ4Q--
