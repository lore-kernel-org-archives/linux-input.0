From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH] HID: Add driver for acer keybard with broken rdesc
Date: Fri, 27 Feb 2015 15:28:31 +0100
Message-ID: <54F07F0F.9040408@butterbrot.org>
References: <54C85FB5.9050404@simon-woerner.de>	<1422492195-11492-1-git-send-email-linux@simon-woerner.de>	<alpine.LNX.2.00.1502171329340.2279@pobox.suse.cz>	<54E3F287.3040900@synaptics.com> <CAN+gG=F=aGvK85zpAHKSeaHrNtytsuiDBUDPWx1MkrBq3DyU6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bUkG6jLPvKHDopONBQXlRp5w6JBc22PSU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:45565 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbB0O2d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 09:28:33 -0500
In-Reply-To: <CAN+gG=F=aGvK85zpAHKSeaHrNtytsuiDBUDPWx1MkrBq3DyU6w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Jiri Kosina <jkosina@suse.cz>, =?UTF-8?B?U2ltb24gV8O2cm5lcg==?= <linux@simon-woerner.de>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>, =?UTF-8?B?U2ltb24gV8O2cm5lcg==?= <mail@simon-woerner.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bUkG6jLPvKHDopONBQXlRp5w6JBc22PSU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just as a quick side note, Simon's "hack" compiled as a standalone
module fixes the issue for me on stock kernel 3.16.0 - keyboard works
perfectly now. So device 06CB:2991 has exactly the same broken
descriptor and should probably included in any future solution.

Many thanks to everyone involved!

Best, Florian

On 27.02.2015 15:16, Benjamin Tissoires wrote:
> [adding Florian to the thread, he is also affected by this]
>=20
> On Tue, Feb 17, 2015 at 9:01 PM, Andrew Duggan <aduggan@synaptics.com> =
wrote:
>> On 02/17/2015 04:30 AM, Jiri Kosina wrote:
>>>
>>> On Thu, 29 Jan 2015, linux@simon-woerner.de wrote:
>>>
>>>> From: Simon W=C3=B6rner <mail@simon-woerner.de>
>>>>
>>>> HID: Add driver for acer keybard with broken rdesc
>>>
>>> Hi Simon,
>>>
>>> to make sure proper device <-> driver binding is performed, you also =
have
>>> to add device ID to the hid_have_special_driver[] array.
>>>
>=20
> To the cost of an error in the kernel log, the proper binding will be
> done even if if there is no entry in hid_have_special_driver :)
>=20
> See Florian's log:
> [    3.153892] hid-generic 0003:06CB:2991.0003: usage index exceeded
> [    3.153896] hid-generic 0003:06CB:2991.0003: item 0 2 2 2 parsing fa=
iled
> [    3.153921] hid-generic: probe of 0003:06CB:2991.0003 failed with er=
ror -22
>=20
> So hid-generic will fail to bind the device, so normally hid-acer
> should bind it, fix the report descriptor and the keyboard should be
> working.
>=20
> Not very clean, but it should work :)
>=20
>> I have been meaning to respond to this patch. Unfortunately, simply ad=
ding
>> this driver to the hid_have_special_driver[] list will prevent
>> hid-multitouch from binding to the touchpad which shares the same vid =
and
>> pid. My suggestion would be to create a new scan_flag for GD_KEYBOARD =
and to
>> add to the code in hid_scan_collection() which scans the GENDESK usage=
s.
>> Similar to the code which is searching for HID_GD_POINTER. Then in
>> hid_scan_report() we could assign a group for this driver based on the=
 pid
>> and the GD_KEYBOARD scan flag in the vendor handling code.
>=20
> This could work, but that means that the list of special quirks after
> the parsing is going to explode :(
>=20
> Plus we have to be sure that the scan_report doesn't fail or we will
> not be able to tag the device correctly.
>=20
>>
>> I can help out with implementing this part of the patch if there aren'=
t any
>> other suggestions. Adding a new group and more code to the hid_scan_re=
port()
>> vendor handling code is definately not ideal. But, I am not sure of a =
better
>> way of binding different sub drivers to devices with the same vid and =
pid.
>>
>> An alternative would be to have hid-rmi handle all Synaptics touchpads=
, even
>> the ones which currently use hid-multitouch. Then the keyboard report
>> descriptor fixup could just be handled in hid-rmi. Accessing the finge=
r data
>> via rmi mode would also have the benefit of being able to report event=
s
>> which are currently not supported by the PTP collection (ie ABS_MT_PRE=
SSURE,
>> ABS_MT_TOUCH_MAJOR/MINOR). The touchpads which currently use hid-multi=
touch
>> report finger data a little differently then the ones currently using
>> hid-rmi so there is some work which would need to be done to add suppo=
rt for
>> them in hid-rmi.
>>
>=20
> I am not sure we want to do that. Because we don't want hid-rmi to fix
> all crappy keyboards around when the OEM reuses the synaptics PID.
>=20
> Maybe a better way of handling such situation is to provide a generic
> mechanism to overwrite/patch the report descriptor so that we could
> get rid of the drivers which just fix the report descriptor.
> I have on a branch a version where I look into /lib/firmware/hid if
> there is a matching device and a matching report descriptor. Then, I
> read this firmware dynamically and patch the report descriptor.
> This however requires that the hid modules are not included directly
> in the kernel, or the /lib/firmware dir is not available and the
> device doesn't bind.
>=20
> Cheers,
> Benjamin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
SENT FROM MY DEC VT50 TERMINAL


--bUkG6jLPvKHDopONBQXlRp5w6JBc22PSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTwfw8ACgkQ7CzyshGvatjiLACfUxh+13cgO78Qypp655CMLk8U
OHkAnjSUrHIuP7lXuLTT+B2uDzFD3iaT
=FKC+
-----END PGP SIGNATURE-----

--bUkG6jLPvKHDopONBQXlRp5w6JBc22PSU--
