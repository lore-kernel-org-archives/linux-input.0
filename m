From: Antonio Ospite <ospite@studenti.unina.it>
Subject: libudev, a question about the enumerate API.
Date: Wed, 23 Feb 2011 23:50:53 +0100
Message-ID: <20110223235053.ae9d6b0a.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Feb_2011_23_50_53_+0100_cS.AgMc97kef5fqc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:59724 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab1BWWvO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Feb 2011 17:51:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-hotplug@vger.kernel.org
Cc: linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>

--Signature=_Wed__23_Feb_2011_23_50_53_+0100_cS.AgMc97kef5fqc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in my attempts to handle leds setting and usb pairing for the Sixaxis
controller I had to fight with libudev a little bit, eventually I
succeeded in what I wanted to achieve but I still have some questions
about the libudev API, so here I am.

This is basically the layout for the device:

4-1:1.0/
|-- 0003:054C:0268.000C  (hid device)
|   |-- hidraw
|   |   `-- hidraw1
|   `-- uevent  (which tells me HID_PHYS)
|
`-- input
    `-- input17
        |-- js0
        `-- phys

I needed to get the hidraw device node, and the js device number, the
two sibling devices (from hid and input subsystem) can be matched using
the 'phys' property.

This is what I do now:
 0. Monitor with a filter matching the "hidraw" subsystem.
 1. When a matching device is connected we get the "hidraw" device.
 2. Go up to its "hid" parent device and check it is actually a
    Sixaxis (using HID_NAME), if not GOTO 1.
 3. Store the hidraw device node for later use
 4. Store the HID_PHYS value in order to look for the matching joystick.
 5. Enumerate the joystick devices with the sysname filter "js*"
 6. For each joystick:
    a. Go up to its input parent device
    b. Check that the phys attribute matches HID_PHYS,
       if so, store the joystick device number.
 7. Set leds
 8. If the Sixaxis is connected via USB do the cable pairing.

My doubt is about 5. and 6a.: I have go deep in the hierarchy down to
the js0 leaf device and then I have to go up one level to get the
input device, naively I would have done the contrary:
 5'. Enumerate the input devices such that phys =3D=3D HID_PHYS
 6'. Enumerate the devices _below_ the input device from 5'. looking
     for the jsX device.

But this is not possible because the enumerate API is designed to start
always from the root of /sys.

Finally the question: why the enumerate API in libudev does not allow
enumerating only from a _subtree_? Has that been designed this way to
keep the API simple, or because it is not considered useful?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__23_Feb_2011_23_50_53_+0100_cS.AgMc97kef5fqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk1lj00ACgkQ5xr2akVTsAGVmQCgsBB8ltmkupFqdagenaH75t82
o8AAn1W51WNBNzmVWVkkvswAoDZG+Bmb
=8qkI
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Feb_2011_23_50_53_+0100_cS.AgMc97kef5fqc--
