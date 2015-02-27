From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Inactive keyboard on Acer Aspire Switch 11
Date: Fri, 27 Feb 2015 12:25:00 +0100
Message-ID: <54F0540C.9000509@butterbrot.org>
References: <54EFA9CF.6000100@butterbrot.org> <CAN+gG=Fsu5rPFGMtKyOtQsCazL4MZgYX6bx1WsybH5Zj-Hg=ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nwQEt34dQNKfpFCxkaXDtKUVFPSLrNiTC"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:37169 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbB0LZD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 06:25:03 -0500
In-Reply-To: <CAN+gG=Fsu5rPFGMtKyOtQsCazL4MZgYX6bx1WsybH5Zj-Hg=ZQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nwQEt34dQNKfpFCxkaXDtKUVFPSLrNiTC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

On 27.02.2015 01:46, Benjamin Tissoires wrote:
> On Thu, Feb 26, 2015 at 6:18 PM, Florian Echtler <floe@butterbrot.org> =
wrote:
>> The device in question has two endpoints:
>>
>> T:  Bus=3D02 Lev=3D02 Prnt=3D04 Port=3D02 Cnt=3D01 Dev#=3D  7 Spd=3D12=
  MxCh=3D 0
>> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D =
 1
>> P:  Vendor=3D06cb ProdID=3D2991 Rev=3D00.06
>> S:  Manufacturer=3DITE Tech. Inc.
>> S:  Product=3DITE Device(8595)
>> C:  #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Dri=
ver=3Dusbhid
>> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Dri=
ver=3Dusbhid
>>
>> According to lsusb, the second one is a mouse (=3D touchpad), while th=
e
>> first one is a keyboard (see attached lsusb.txt). Judging from the
>> dmesg, this is also the one which fails to initialize. Can anyone
>> suggest any quirks/fixes to try here?
>=20
> Hi Florian,
>=20
> This was a known bug which has been fixed in a more recent kernel than
> 3.16. I think a 3.17 might work, but I think a 3.18 would be a better
> choice.
> cf: e19ff99f256aeeff6c07b373e01883b72e049552 in Linus' tree

thanks for the quick reply. I've tried both 3.18.7 and 3.19.0 kernels,
but still get (slightly different) error messages:

[    2.550306] hidraw: raw HID events driver (C) Jiri Kosina
[    2.877672] hid (null): usage index exceeded
[    2.927474] usbcore: registered new interface driver usbhid
[    2.927476] usbhid: USB HID core driver
[    3.135496] i2c_hid i2c-ITE8380:00: error in i2c_hid_init_report
size:19 / ret_size:18
[    3.150002] hid-multitouch 0018:06CB:77B2.0002: input,hidraw0:
<UNKNOWN> HID v1.00 Mouse [SYNA7508:00 06CB:77B2] on
[    3.150784] hid-multitouch 0003:06CB:2991.0004:
input,hiddev0,hidraw1: USB HID v1.10 Mouse [ITE Tech. Inc. ITE
Device(8595)] on usb-0000:00:14.0-4.3/input1
[    3.153892] hid-generic 0003:06CB:2991.0003: usage index exceeded
[    3.153896] hid-generic 0003:06CB:2991.0003: item 0 2 2 2 parsing fail=
ed
[    3.153921] hid-generic: probe of 0003:06CB:2991.0003 failed with
error -22

After a bit of digging through the kernel code, could it be that the
06CB:2991 device needs to be added to the hid_have_special_driver list
(which AFAICT will only appear in 4.0)?

Best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--nwQEt34dQNKfpFCxkaXDtKUVFPSLrNiTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTwVAwACgkQ7CzyshGvatiTqgCgpgLbZRlxbFiDKL0R7TsGSqAa
RNUAoLBpzaMdzSYBqewjvratCHUy9Cg5
=dYIB
-----END PGP SIGNATURE-----

--nwQEt34dQNKfpFCxkaXDtKUVFPSLrNiTC--
