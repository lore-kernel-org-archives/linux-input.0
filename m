From: Kevin Fenzi <kevin@scrye.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Thu, 30 Nov 2017 12:53:31 -0800
Message-ID: <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uTQRbOBclq6WIUbomCeMlslNspi1f9Pdw"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 96-71-165-137-static.hfc.comcastbusiness.net ([96.71.165.137]:55478
        "EHLO mail.scrye.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdK3Uxw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Nov 2017 15:53:52 -0500
In-Reply-To: <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uTQRbOBclq6WIUbomCeMlslNspi1f9Pdw
Content-Type: multipart/mixed; boundary="GVI4dfRjIhmvoMSUpIUCFL15pWQh6sNdV";
 protected-headers="v1"
From: Kevin Fenzi <kevin@scrye.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>
Message-ID: <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
In-Reply-To: <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>

--GVI4dfRjIhmvoMSUpIUCFL15pWQh6sNdV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/2017 01:43 PM, Jason Gerecke wrote:
> Hi Kevin,
>=20
> The Bluetooth and tablet issues are likely to be unrelated. The
> Bluetooth button is completely independent from the rest of the
> tablet, with neither the tablet sensor nor the Wacom driver being
> aware of it.
>=20
>>From what I understand, in normal operation the Bluetooth button is
> disconnected most of the time. When you press it, it briefly wakes up,
> connects to the paired PC, appears as a keyboard, sends a key combo,
> and then disconnects until you press it again. If you run something
> like `sudo libinput-debug-events` and then press the button, you
> should be able to see the key combo being sent (as well as the
> connect/disconnect). I'm not sure what's up with the deadlock warning
> that appears in dmesg, however...

Ah, quite right. Sorry about that, this is my first device with a pen. I
expected it to just connect and stay there, but I suppose doing things
this way saves a ton of power since it's likely not writing most of the
time.

>=20
> As for the tablet, the "last error =3D -121" indicates that we got an
> EREMOTEIO error. I've not come across that particular error in this
> function before. I'll need some time to track down why we might be
> getting this from the lower layers.

ok, thanks! If you need any more info from me just ask. Happy to test
patches or gather more info.

kevin
--
>=20
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>=20
>=20
>=20
> On Mon, Nov 27, 2017 at 12:23 PM, Kevin Fenzi <kevin@scrye.com> wrote:
>> Greetings.
>>
>> I'm running into some problems with Lenovo active pen 2 and wacom tabl=
et
>> on a new yoga 920.
>>
>> Filed:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1514837
>>
>> but I thought I would ask here if anyone had any ideas...
>>
>> Basically when pairing the pen it shows for a second, then drops:
>>
>> [Sat Nov 18 12:22:42 2017] input: Lenovo Active Pen2 as
>> /devices/virtual/misc/uhid/0005:17EF:60A8.0006/input/input23
>> [Sat Nov 18 12:22:42 2017] hid-generic 0005:17EF:60A8.0006:
>> input,hidraw4: BLUETOOTH HID v0.02 Keyboard [Lenovo Active Pen2] on
>> 64:6E:69:D1:A0:48
>> [Sat Nov 18 12:22:47 2017] Bluetooth: hci0: last event is not cmd
>> complete (0x0f)
>> [Sat Nov 18 12:23:03 2017] Bluetooth: hci0: last event is not cmd
>> complete (0x0f)
>> [Sat Nov 18 12:23:19 2017] Bluetooth: hci0: last event is not cmd
>> complete (0x0f)
>>
>> The wacom tablet is never connecting:
>>
>> [Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Pen as
>> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:0=
0/0018:056A:5110.0003/input/input26
>> [Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Finger as
>> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:0=
0/0018:056A:5110.0003/input/input27
>> [Fri Nov 24 21:47:01 2017] wacom 0018:056A:5110.0003: hidraw3: I2C HID=

>> v1.00 Mouse [WCOM5110:00 056A:5110] on i2c-WCOM5110:00
>> [Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
>> report to device.
>> [Fri Nov 24 21:47:02 2017] wacom 0018:056A:5110.0003: wacom_set_report=
:
>> ran out of retries (last error =3D -121)
>> [Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
>> report to device.
>>
>> Happy to gather more info and/or try patches.
>>
>> Thanks.
>>
>> kevin
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--GVI4dfRjIhmvoMSUpIUCFL15pWQh6sNdV--

--uTQRbOBclq6WIUbomCeMlslNspi1f9Pdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESz7rprBJHpbnMnrQSzew2A/7u14FAlogb80ACgkQSzew2A/7
u16LmBAAkqkcjs7uF2LVfAPd/zhcYhydWHmIGUVtdzdljvO+8qBSB6gYupZlVHjj
QzqFBslOdDUu8fJpuX6mUeEFfLYwZDwYo8e/AmUkmxXynIXPt7/Ubb6YLsKCk6Tu
6IMhaS3qblb1pvUshkhfJQJB/zt6P1McOU0hitcRlVYIt0xHETBEzNcQ5ha4Cti2
QklONw8F96Uvcuh0Vb06zsLwLvs1ssb63TecBTfD/bgi+pPCYXhyuc2UwwAOm93Z
7HGExK/tEbSo+iRnVA24SiMg81ObOL+fe+lBNBCoIciPk5Ba6hUFFTxlXy2BoIHj
aOjwc2YCRikvHmA0z/9c0jXZUmHHdt7k0U0yLhE6Zr1Mfn+MJZdaa0N2lkKOlPP/
CQp5F2VyqawfsNqhMaVMxDYYC3ZNCGB1OoeSfmc5gxvjEZjekaTQ9h//RuteEN0I
eFVeK/h+Nm88fvxbo6FO6qtR1F7tqDRin9tWfHaxXimCafdbo5SFGe0JSNbJXhK3
3f06/3g0Z5p31v7/zWeNUYCNNdvmNg4zFfoBhMobKjl+B8hlBAfCufTPcF+RGHhX
WrIOeyWsRPgq7o7bU0yjhxtQYHFzB3E2AtJUA+O4vGB78ygJ3LtggnbHIPrpu27g
veKlU7WvGTqD3XyN8aO1gWHFTWdkL6/qvLu3CIGNLGx2TRCmkeI=
=fWt8
-----END PGP SIGNATURE-----

--uTQRbOBclq6WIUbomCeMlslNspi1f9Pdw--
