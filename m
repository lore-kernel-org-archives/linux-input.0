From: Kevin Fenzi <kevin@scrye.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Mon, 11 Dec 2017 13:03:26 -0800
Message-ID: <20350601-a07b-aab8-f16e-6d25344efb22@scrye.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
 <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
 <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
 <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com>
 <CANRwn3SWMhrodDbgDn3WzzwEZcgvdo_vWndesD=O87JiEBWAyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AaAf8AjBlBgarKLJXkileuGO1W4U7xtuq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 96-71-165-137-static.hfc.comcastbusiness.net ([96.71.165.137]:51162
        "EHLO mail.scrye.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdLKVDr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 16:03:47 -0500
In-Reply-To: <CANRwn3SWMhrodDbgDn3WzzwEZcgvdo_vWndesD=O87JiEBWAyg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AaAf8AjBlBgarKLJXkileuGO1W4U7xtuq
Content-Type: multipart/mixed; boundary="p9tu9u8xL43Rkx6f5hTmsK7B3k5TBikH7";
 protected-headers="v1"
From: Kevin Fenzi <kevin@scrye.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>
Message-ID: <20350601-a07b-aab8-f16e-6d25344efb22@scrye.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
 <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
 <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
 <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com>
 <CANRwn3SWMhrodDbgDn3WzzwEZcgvdo_vWndesD=O87JiEBWAyg@mail.gmail.com>
In-Reply-To: <CANRwn3SWMhrodDbgDn3WzzwEZcgvdo_vWndesD=O87JiEBWAyg@mail.gmail.com>

--p9tu9u8xL43Rkx6f5hTmsK7B3k5TBikH7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/2017 10:19 AM, Jason Gerecke wrote:
>=20
> Thanks for the sysinfo output :) It looks like your system has the
> sensor connected through a designware I2C controller. The only place I
> see EREMOTEIO used within the designware driver is to signal that it
> got a NAK at some point during the transfer. It is supposed to print
> out additional details using dev_dbg, but that won't be useful until
> the "Operation not permitted" error is overcome.
>=20
> Some NAK conditions are transient, so its possible that our driver
> just needs to retry the command. Please read the page at [1] for
> instructions to compile out out-of-tree version of the wacom driver.
> In place of the "Download" instructions on that page, use the
> "Development" instructions. Once you're set, apply the attached patch
> by running `git am /path/to/file.patch` from within the input-wacom
> directory. Compile the driver and then load it in place of the system
> driver by running `sudo modprobe -r wacom && sudo insmod
> 4.5/wacom.ko`. Check to see if there's any interesting dmesg output
> and if the pen works.
>=20
> [1]: http://linuxwacom.sourceforge.net/wiki/index.php/Input-wacom

So, not much change in dmesg:

[Mon Dec 11 12:38:16 2017] wacom: loading out-of-tree module taints kerne=
l.
[Mon Dec 11 12:38:16 2017] wacom: module verification failed: signature a=
nd/or required key missing - tainting kernel
[Mon Dec 11 12:38:18 2017] input: Wacom HID 5110 Pen as /devices/pci0000:=
00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0018:056A:5110.000=
3/input/input24
[Mon Dec 11 12:38:18 2017] input: Wacom HID 5110 Finger as /devices/pci00=
00:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0018:056A:5110.=
0003/input/input25
[Mon Dec 11 12:38:18 2017] wacom 0018:056A:5110.0003: hidraw3: I2C HID v1=
=2E00 Mouse [WCOM5110:00 056A:5110] on i2c-WCOM5110:00
[Mon Dec 11 12:38:20 2017] i2c_hid i2c-WCOM5110:00: failed to set a repor=
t to device.
[Mon Dec 11 12:38:20 2017] wacom 0018:056A:5110.0003: wacom_set_report: r=
an out of retries (last error =3D -121)
[Mon Dec 11 12:38:20 2017] i2c_hid i2c-WCOM5110:00: failed to set a repor=
t to device.

However, the pen now works. ;)=20

The tablet/stylus doesn't show up in gnome prefs oddly, but that could be=

a problem in the stack somewhere. ;(=20

kevin



--p9tu9u8xL43Rkx6f5hTmsK7B3k5TBikH7--

--AaAf8AjBlBgarKLJXkileuGO1W4U7xtuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESz7rprBJHpbnMnrQSzew2A/7u14FAlou8qEACgkQSzew2A/7
u140ug//ZyjnoXkLP2H855QSBCB34XEpcVkc2aqKgjebCKUWOWU5AZXbM5NLRb+g
zcBBDYUgD430eET7LPH0+ANN/xUQVn+HN2bzsBgSZN7ARQMSF07hFkabqfKpMdLW
5sQk3/JPcGENZkcDaoV3J3zw/KaoCevMlWD/UGyqFIWC9i4t+3C7nQEcTFWcxQvl
8ZeezXtFGToB3sJHlKcRf1cFSD1pns1qZZqYG+Ki09dfYXryWF0MK5MBspWzIxbi
hPhqIE2PIHyFwljityei0Fy1ROthwQ+8+B4RoZApY8QOB0Qwq+L/r6/XuJnnbVba
0Y+sedP5AXyAhPZt+WJovyQLnsM6GUmftsHcurn6loze2MtCdrMKwdcN6uYQnltE
SYimS9UW/ZUyFqYRvfV9oq1x8EEFp4xhkKyy4fSQho+8w7KqYIZvAWHC13ovlyOX
rb/IU9wmLjrOBWcKxJucGN/FzQ8n6omPd18JBHD8twV1M8ph0QUxRs/k2pdpHa1P
V/Vu294DwXIkJAfQJWwhglptv+fKVoS90kkCjFIt+IRd+bCPecfLs8MKv2EQJ4va
YVdIJIlAxM3mIJxaoFeRES3sM9yiXwr4Cn3FRDQKe66VHQiatomXbRJnEEpKIJoD
m4a8giFJ+jKn1V7RqHcAjAnubfGuX79MwzVHNN+mOvecbmgH11I=
=m8uY
-----END PGP SIGNATURE-----

--AaAf8AjBlBgarKLJXkileuGO1W4U7xtuq--
