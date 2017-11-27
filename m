From: Kevin Fenzi <kevin@scrye.com>
Subject: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Mon, 27 Nov 2017 12:23:28 -0800
Message-ID: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kLaOm4CIKTCSCVwlsvg7mvCcdH74rCtFh"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 96-71-165-137-static.hfc.comcastbusiness.net ([96.71.165.137]:51246
        "EHLO mail.scrye.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdK0U3o (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Nov 2017 15:29:44 -0500
Received: from taim.scrye.com (unknown [192.168.21.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.scrye.com (Postfix) with ESMTPSA id 25DCF658832
        for <linux-input@vger.kernel.org>; Mon, 27 Nov 2017 13:23:34 -0700 (MST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kLaOm4CIKTCSCVwlsvg7mvCcdH74rCtFh
Content-Type: multipart/mixed; boundary="UTM784QsmuIt7KCXLOtEa6fF4w6Obm0M2";
 protected-headers="v1"
From: Kevin Fenzi <kevin@scrye.com>
To: linux-input@vger.kernel.org
Message-ID: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
Subject: Lenovo Active Pen 2 and wacom tablet on yoga 920

--UTM784QsmuIt7KCXLOtEa6fF4w6Obm0M2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Greetings.

I'm running into some problems with Lenovo active pen 2 and wacom tablet
on a new yoga 920.

Filed:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1514837

but I thought I would ask here if anyone had any ideas...

Basically when pairing the pen it shows for a second, then drops:

[Sat Nov 18 12:22:42 2017] input: Lenovo Active Pen2 as
/devices/virtual/misc/uhid/0005:17EF:60A8.0006/input/input23
[Sat Nov 18 12:22:42 2017] hid-generic 0005:17EF:60A8.0006:
input,hidraw4: BLUETOOTH HID v0.02 Keyboard [Lenovo Active Pen2] on
64:6E:69:D1:A0:48
[Sat Nov 18 12:22:47 2017] Bluetooth: hci0: last event is not cmd
complete (0x0f)
[Sat Nov 18 12:23:03 2017] Bluetooth: hci0: last event is not cmd
complete (0x0f)
[Sat Nov 18 12:23:19 2017] Bluetooth: hci0: last event is not cmd
complete (0x0f)

The wacom tablet is never connecting:

[Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Pen as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0=
018:056A:5110.0003/input/input26
[Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Finger as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0=
018:056A:5110.0003/input/input27
[Fri Nov 24 21:47:01 2017] wacom 0018:056A:5110.0003: hidraw3: I2C HID
v1.00 Mouse [WCOM5110:00 056A:5110] on i2c-WCOM5110:00
[Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
report to device.
[Fri Nov 24 21:47:02 2017] wacom 0018:056A:5110.0003: wacom_set_report:
ran out of retries (last error =3D -121)
[Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
report to device.

Happy to gather more info and/or try patches.

Thanks.

kevin


--UTM784QsmuIt7KCXLOtEa6fF4w6Obm0M2--

--kLaOm4CIKTCSCVwlsvg7mvCcdH74rCtFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESz7rprBJHpbnMnrQSzew2A/7u14FAlocdEAACgkQSzew2A/7
u16z/A/+OV09lDkCpvhOaOcvmf3ppSEn8zymlGuFRkeaUXEc36ihwpOyrvLA/bXZ
W8mY4KRUez5IUN3BfypOCgSDXxnHfJU8TBVh+mJlySWti8Km0X8k4a7uXlZwL6w7
KH9p7iTyXi5Zdl/RlRmB+MdJ8pmLYqVXPUtYftTZ/w64Ran6LZaWoD+JUD6tRftl
pEwKGTtqeWvNRy9CjPYLttVOKs1iD9Tpu8DqoAJxdp1/jRYtS1eJ8svxFqMidrIi
muWNgddUzCc7O/H2DOXhtBIldEtyNFgQ/+JBIDkxBEukRHnF8PM0zNleK10ZIbhM
7KPO08kNNp3tko3rFFeHe92q+HnK3e/tGLYvH2eXfTdf1KeNo/2r6CjfEygCYpbG
LBvweOu7RjBaRbvmsFEekqAvMUit2ibtxEiQ331dB2TjmHNx2AlsQNASKZ5kHUhv
tlaYDliBoQCaY0uIF7vGBw0uBdGoYv/2OtYFi0hAMImNXmxlj+ncejyafAEv5YYl
9+7829JDwX5eVm+dC0bcc2DrmANKLGbCOc9ixMAkwwY83BYZ5jvAF4Sds9FPD933
e58Hw9O498uGMgn3uuNGvqRzcEIyTeWtAGLPLsX/aRiFlMGg2Ll0WcNVWqYMRGtL
jU78/IHITQVNQoK4hYoAzk4W89sXHLmUPQ8ml1PnUiTMIPTFo1s=
=iHBa
-----END PGP SIGNATURE-----

--kLaOm4CIKTCSCVwlsvg7mvCcdH74rCtFh--
