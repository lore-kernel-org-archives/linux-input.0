From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Thu, 10 Mar 2016 17:11:40 +0100
Message-ID: <56E19CBC.60107@collabora.co.uk>
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
 <565456F3.8080408@collabora.co.uk>
 <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
 <569514D6.2060204@collabora.co.uk> <56E15E9E.4090107@collabora.co.uk>
 <CAH9NwWcK=J5h++NMSPY6v7RWcVa3=FuPmAEY+_S7vHFMxSXZMA@mail.gmail.com>
 <alpine.LNX.2.00.1603101710430.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="evGhOHsa0tHndadhCd2dVgGRkU6E6bfP3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33583 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbcCJQLq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 11:11:46 -0500
In-Reply-To: <alpine.LNX.2.00.1603101710430.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--evGhOHsa0tHndadhCd2dVgGRkU6E6bfP3
Content-Type: multipart/mixed; boundary="77isCWbhpqL4x9CPJqivDNGbcMaRdJtCO"
From: Andrew Shadura <andrew.shadura@collabora.co.uk>
To: Jiri Kosina <jikos@kernel.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>
Message-ID: <56E19CBC.60107@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
 <565456F3.8080408@collabora.co.uk>
 <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
 <569514D6.2060204@collabora.co.uk> <56E15E9E.4090107@collabora.co.uk>
 <CAH9NwWcK=J5h++NMSPY6v7RWcVa3=FuPmAEY+_S7vHFMxSXZMA@mail.gmail.com>
 <alpine.LNX.2.00.1603101710430.3656@cbobk.fhfr.pm>
In-Reply-To: <alpine.LNX.2.00.1603101710430.3656@cbobk.fhfr.pm>

--77isCWbhpqL4x9CPJqivDNGbcMaRdJtCO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/03/16 17:11, Jiri Kosina wrote:
> On Thu, 10 Mar 2016, Christian Gmeiner wrote:
>=20
>> > 2016-03-10 12:46 GMT+01:00 Andrew Shadura <andrew.shadura@collabora.=
co.uk>:
>>> > > On 12/01/16 15:59, Andrew Shadura wrote:
>>>> > >> On 27/11/15 16:18, Christian Gmeiner wrote:
>>>>>> > >>> > 2015-11-24 13:24 GMT+01:00 Andrew Shadura <andrew.shadura@=
collabora.co.uk>:
>>>>>>>> > >>>> >> On 29/10/15 16:00, Andrew Shadura wrote:
>>>>>>>>>> > >>>>> >>> PenMount 6000 USB resistive touchscreen controller=
 reports it has three
>>>>>>>>>> > >>>>> >>> buttons, while in reality it doesn't have any and =
doesn't support active
>>>>>>>>>> > >>>>> >>> styli, and only generates touch events.
>>>>>>>>>> > >>>>> >>>
>>>>>>>>>> > >>>>> >>> In penmount_input_mapping(), map only the first bu=
tton (with code 0),
>>>>>>>>>> > >>>>> >>> ignore the rest.
>>>>>>>>>> > >>>>> >>>
>>>>>>>>>> > >>>>> >>> Signed-off-by: Andrew Shadura <andrew.shadura@coll=
abora.co.uk>
>>>>>>>> > >>>> >>
>>>>>>>> > >>>> >> Any news on this patch? It'd be cool if it could be me=
rged.
>>>>>> > >>> >
>>>>>> > >>> > I try to get access to the hardware and will test it.
>>>> > >> Christian, have you had a chance to test the patch?
>>> > >
>>> > > Ping, once again. Any progress on this?
>> >=20
>> > Sorry for the long delay. I have applied your patch and the touch
>> > works as expected.
>> >=20
>> > No device specified, trying to scan all of /dev/input/event*
>> > Available devices:
>> > /dev/input/event0:      Power Button
>> > /dev/input/event1:      Lid Switch
>> > /dev/input/event2:      Sleep Button
>> > /dev/input/event3:      Video Bus
>> > /dev/input/event4:      DIALOGUE INC PenMount USB
>> > Select the device event number [0-4]: 4
>> > Input driver version is 1.0.1
>> > Input device ID: bus 0x3 vendor 0x14e1 product 0x6000 version 0x101
>> > Input device name: "DIALOGUE INC PenMount USB"
>> > Supported events:
>> >   Event type 0 (EV_SYN)
>> >   Event type 1 (EV_KEY)
>> >     Event code 330 (BTN_TOUCH)
>> >   Event type 3 (EV_ABS)
>> >     Event code 0 (ABS_X)
>> >       Value      0
>> >       Min        0
>> >       Max     1023
>> >     Event code 1 (ABS_Y)
>> >       Value      0
>> >       Min        0
>> >       Max     1023
>> >   Event type 4 (EV_MSC)
>> >     Event code 4 (MSC_SCAN)
>> > Properties:
>> > Testing ... (interrupt to exit)
>> >=20
>> > Tested-by: Christian Gmeiner <c.gmeiner@bachmann.info
> Could you guys please bounce / resend the patch to me? I don't seem to =

> see it in my inbox.

It's in the patchwork here:

https://patchwork.kernel.org/patch/7519541/

--=20
Cheers,
  Andrew


--77isCWbhpqL4x9CPJqivDNGbcMaRdJtCO--

--evGhOHsa0tHndadhCd2dVgGRkU6E6bfP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4Zy8AAoJEEFnG7NKhJOBg4AP/2FGX1t2B4Z5+COw843f4m2C
ZrcFkG73z94Js6S2v9ImuzdlXMXOWVaTU5UjAgQIyQPdoaJ1nRaPj8fww8FMrgb7
Y+qXyemygC52lHSP3dwO0ZQqAtYHQbikMMHQOIpUPKmcTKJ4N0hX7CDcc/98CRdB
Vz2GGJi9qjh8278/65NYC96rNGYZ2E0/Jrk1QC0VQukuTtaH3etUsq571xfBtLgD
/Yd4AGEFrp6kSImviBRf4JA05J8iRQLHeO37LgbuZzXLTUeCT5f25XCsJrmBzUHT
Wk5bux/4KD0ITB//NEIoEsSJVRhGHwmOKarrq2lW6w6ZR0OXygo1qYVFuIdLEZm0
Fttr6771IhNfw6ye2nxiJTHgFYiqsT6149nvDLNBUPPinn8fT8YcwDTMR4jpVpz+
DpkvWmtbN4Vuumn0f2jU+5rZKXvCrEZmVc2plGd5/riD3EVYr8ZZGBRCECvtXnP7
MTOf587AEiRVwRLAz55K8RFm+FbcLdsSu+BVXmWB7h6OpApavSR+yF7Hwrn5yF62
jCvQcbKDkKpbB01ISO33sQNwRmFgIlbAPV0FhWJxOgPqD3kjWghtdHD9hHgIO5Ew
NvxYaNyxZD/mJ1GTCyJC7tlbdWlpPpQaJEW3UbybYMwz/4TgZ9EXDFGrx97194ma
Qm360AosRw42eZQX7LVk
=3Zjc
-----END PGP SIGNATURE-----

--evGhOHsa0tHndadhCd2dVgGRkU6E6bfP3--
