From: Juanito <juam+kernel@posteo.net>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Mon, 5 Feb 2018 08:48:24 +0100
Message-ID: <131d0bb6-4861-95a0-3963-790c91cb3912@posteo.net>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709080848.53286@pali> <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
 <201709091036.06899@pali> <20170909181218.GA29107@dtor-ws>
 <b3b06164-183b-d3f8-8de2-804eb1d343dd@posteo.net>
 <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
 <20180204181605.eknruesqvvnncrqd@pali>
 <f291e382-b90e-baba-fb3c-bdebc991a21d@posteo.net>
 <20180204202118.fmyhcqmteyu6jnit@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l5szyalsmIPgvQksDj5KLiGjgH4ZVT7C6"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:36970 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeBEHsf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Feb 2018 02:48:35 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 78C7820FFB
        for <linux-input@vger.kernel.org>; Mon,  5 Feb 2018 08:48:33 +0100 (CET)
In-Reply-To: <20180204202118.fmyhcqmteyu6jnit@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Paul Donohue <linux-kernel@paulsd.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l5szyalsmIPgvQksDj5KLiGjgH4ZVT7C6
Content-Type: multipart/mixed; boundary="xxhrFaMoARhcRIMTL3eY2X2lX7gWSiByQ";
 protected-headers="v1"
From: Juanito <juam+kernel@posteo.net>
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 Paul Donohue <linux-kernel@paulsd.com>
Message-ID: <131d0bb6-4861-95a0-3963-790c91cb3912@posteo.net>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709080848.53286@pali> <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
 <201709091036.06899@pali> <20170909181218.GA29107@dtor-ws>
 <b3b06164-183b-d3f8-8de2-804eb1d343dd@posteo.net>
 <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
 <20180204181605.eknruesqvvnncrqd@pali>
 <f291e382-b90e-baba-fb3c-bdebc991a21d@posteo.net>
 <20180204202118.fmyhcqmteyu6jnit@pali>
In-Reply-To: <20180204202118.fmyhcqmteyu6jnit@pali>

--xxhrFaMoARhcRIMTL3eY2X2lX7gWSiByQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/04/2018 09:21 PM, Pali Roh=C3=A1r wrote:
> On Sunday 04 February 2018 20:39:06 Juanito wrote:
>> On 02/04/2018 07:16 PM, Pali Roh=C3=A1r wrote:
>>> On Monday 11 September 2017 13:26:30 Juanito wrote:
>>>> Hi Masaki Ota,
>>>>
>>>> Thanks!
>>>>
>>>> On 11.09.2017 04:38, Masaki Ota wrote:
>>>>> Hi, Juanito,
>>>>>
>>>>> In my information, ALPS Touchpad is used on Thinkpad E series and L=
 series.
>>>>> I don't know the device that is ALPS Touchpad + other vendor TrackS=
tick.
>>>>> But Lenovo might use ALPS Touchpad on such a combination.
>>>>>
>>>>
>>>> Well, that is probably my fault, as it is not the original touchpad =
that
>>>> was delievered with the laptop. I bought the touchpad (that included=

>>>> the three buttons) separately because I didn't like the clickpad tha=
t
>>>> came with my laptop.
>>>
>>> Hi Juanito,
>>>
>>
>> Hi Pali,
>>
>>> if you are still want to play with your touchpad hardware, I have a g=
ood
>>> news for your.
>>>
>>
>> Yeah! I'd love to get it to work! It's just I've been "working" on som=
e
>> other projects and my last kernel builds didn't work at all so I gave =
up
>> and never got back to it.
>>
>> Thank you very much for that!
>>
>>> It looks like that at least ALPS rushmore touchpads allow to receive =
RAW
>>> PS/2 packets from trackstick to host kernel, without modifying them b=
y
>>> touchpad. Plus I was able to tell ALPS touchpad to start "mixing" tho=
se
>>> RAW trackstick PS/2 packets with native touchpad packets.
>>>
>>> On my configuration trackstick in RAW PS/2 mode by default talks with=

>>> standard bare 3 byte PS/2 protocol and touchpad in 6 byte ALPS protoc=
ol.
>>> alps.c/psmouse.ko is already able to process and parse such mixed
>>> packets. And trackstick can be switched to some extended 4 byte
>>> protocol...
>>>
>>> All this happen when passthrough mode is enabled.
>>>
>>> From my understanding it seems that in normal mode, touchpad and
>>> trackstick communicate with that 4 byte protocol and touchpad convert=
s
>>> it into 6 byte ALPS protocol and then send to kernel.
>>>
>>> On thinkpads trackstick communicate with TPPS/2 protcol and above 4
>>> byte. So in my opinion ALPS touchpad by default cannot understand it.=

>>> But you should be able to enter passthrough mode and then you would
>>> receive that TPPS/2 in alps kernel code.
>>>
>>
>> I don't really understand what you mean. Do I "just" have to set it to=

>> passthrough mode? How exactly can I do that?
>=20
> Look at function alps_passthrough_mode_v3(). And try to call it after
> touchpad is initialized.
>

Cool, I'll give this a try!

> You can also look which alps_command_mode_write_reg() functions are
> called for your touchpad and maybe try to figure out what those the
> registers can enabled/disable.
>=20
> On http://www.cirque.com/gen4-dev-resources you can find document named=

> GP-AN- 130823 INTERFACING TO GEN4 OVER I2C (PDF) which contains
> some description of those registers (in section 7).
>=20
> Register C2C8, bit 0 has description "PS2AuxControl.CommandPassThruEnab=
led"
>=20
> If trackstick is not detected, it seems you can "force" enable it by
> setting bit 7 "PS2AuxControl.AuxDevicePresent" in same register.
>=20
>> Again, thank you very much!
>=20
> Have you tried to read from that register which Masaki Ota talked in
> previous emails?
>=20

I tried but I just didn't manage to get it to work, at all and gave up
(I really am a newbie in this whole kernel world). Maybe a fresh start
helps here.

Cheers,
Juanito


--xxhrFaMoARhcRIMTL3eY2X2lX7gWSiByQ--

--l5szyalsmIPgvQksDj5KLiGjgH4ZVT7C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQQcjO70/bl99Yhbk4tnJgO9QcV4FAlp4DEgACgkQ4tnJgO9Q
cV4T6A//QfT+JDbd48s7mnqgXuLn8Q/3mJylhr7iY2X9BnS31Q5wwmdFoRQYT9yJ
0cDsSIm8xUUfJ0PeyteGs+pDDzMj8NV0AczHthcYLRUSCqrv3pOlsJnM2HVexDWK
YfRbpYautFRKRnk3ahz3VvZond+fHJLndNCSwBpUHgtD07WacuHvl11KoSXRaTsm
S25BOwYwqm1Yz3UNqgmmY000mG/+IuYzUvmLuBf0d+4i74//5bUPvIieC1mSEAjt
yLqkRgSojY9jfjwWoY86pTnZjoo/gl3P64VPT1tnW6w5wnj7GB2khQ+jReQjkOO9
kYg6cWWAitGQmYQzkcFuy738CgX2ezthXFEN617CCFhx7wDgCoK8WpVKkx5H3f7k
zNXehwp6FHhWS715rVFfje2FXECPjlmxS7xEYakvg9TqNxGqkIvBuJSZm/6/uQuN
6FwJfZWZ3vAmlcVDyohh8i1HI3O+lT4jlCFb2qdzbtTVAtIv65tk+NTZ8cQnzTTL
Su/UvfLNPppcF5vYEVyMa7OuH29FlGh3tMdn4cggVnTkBD+yT1En2+96y8eAINlZ
2N9iivdtyDLOHcmDT565IPIkTpdNyefdDaANEN+0/uSYc4QlBUrkXlBkiy8/NaW7
AXWZ2KF5SeNQVmGTE7ZAK5cD9Pz3/ijOWlCymg1jZAEzbNvhBOw=
=bcpo
-----END PGP SIGNATURE-----

--l5szyalsmIPgvQksDj5KLiGjgH4ZVT7C6--
