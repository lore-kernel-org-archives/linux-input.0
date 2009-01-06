From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: Support special keys on laptop by default?
Date: Tue, 06 Jan 2009 14:34:54 +0100
Message-ID: <49635DFE.9090409@wincor-nixdorf.com>
References: <4963594B.9040705@wincor-nixdorf.com> <b92a6cf90901060527x1bd1d84g873d77b5f31f57d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0DF01E99F18E0C1EC70DB81E"
Return-path: <linux-laptop-owner@vger.kernel.org>
In-Reply-To: <b92a6cf90901060527x1bd1d84g873d77b5f31f57d9@mail.gmail.com>
Sender: linux-laptop-owner@vger.kernel.org
To: Sushant Gulati <sushant.g1@gmail.com>
Cc: linux-input@vger.kernel.org, linux-laptop@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0DF01E99F18E0C1EC70DB81E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Sushant,

Sushant Gulati wrote:
> Can you help me  by telling where do you see the output that you have
> reproduced when you press the keys.? Actually I have a problem with the=
 keys
> on my laptop too and I would too like to start from the first errors or=

> warnings.

With the command 'dmesg' :)

Cheers,
Niels


> Regards,
> Sushant
>=20
>=20
> On Tue, Jan 6, 2009 at 6:44 PM, Niels de Vos <niels.devos@wincor-nixdor=
f.com
>> wrote:
>=20
>> Hello,
>>
>> on my HP/Compaq nc6400 there are three keys (info, presentation and
>> battery) not directly recognized. If I press any of the keys, I get:
>>
>> atkbd.c: Unknown key released (translated set 2, code 0xd9 on
>> isa0060/serio0).
>> atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.
>>
>> I would like to have these keys mapped by default to the
>> corresponding defines in <linux/input.h>. Of course using the
>> command as suggested would function, but that does not help other
>> owners of this laptop. Moreover, other keys seem to be supported
>> without requiring extra manual configuration.
>>
>> Where should I start looking for creating a patch for solving
>> problems of this kind? There seem to be quirks in atkbd.c, but
>> I think they are used for some other workarounds.
>>
>> Thanks for any pointers,
>> Niels
>>
>>
>>
>=20



--------------enig0DF01E99F18E0C1EC70DB81E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJY13+5KAkGQPO/QoRAqv3AJ9s4ho2cGk+obi/2z4QITF1m/nAnwCeNYfY
Yksw7TGNOj8fAKTh/mPGaPc=
=hz00
-----END PGP SIGNATURE-----

--------------enig0DF01E99F18E0C1EC70DB81E--
