From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 17:53:22 +0200
Message-ID: <8737p6jfrh.fsf@smart-cactus.org>
References: <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM> <87bn45gr0e.fsf@smart-cactus.org> <20160517082309.GZ29844@pali> <877fet10a9.fsf@smart-cactus.org> <20160517131629.GE29844@pali> <23E0F704395E694FA4710C833FA087E50D40B8C592@TPEX7ADC101.APAC.DELL.COM> <20160517152239.GF29844@pali> <23E0F704395E694FA4710C833FA087E50D40D0723A@TPEX7ADC101.APAC.DELL.COM> <20160525073949.GY29844@pali> <877feijp2b.fsf@smart-cactus.org> <20160525154310.GZ29844@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56177 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbcEYPxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 11:53:34 -0400
In-Reply-To: <20160525154310.GZ29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Allen_Hung@Dell.com, Mario_Limonciello@Dell.com, linux-input@vger.kernel.org, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> On Wednesday 25 May 2016 14:32:28 Ben Gamari wrote:
>>=20
>> The first attached patch gets me partly there; I see multitouch events,
>> the pressure appears to reflect reality, and things generally work as
>> expected. That is, until I try to touch the touchstick, which causes the
>> pointer to jump around wildly.
>
> So with first patch touchpad starts working fine and just trackstick
> cause problems?
>
> Reason for non working trackstick is simple. Driver alps.c does not
> support trackstick in V8 protocol. So you even does not see second
> (trackstick) input device, right?
>
Correct.

>> The second attached patch makes things behave slightly better,
>
> Looking at the alps.c code it should act exactly same. V8 does not
> support trackpoint, so ALPS_DUALPOINT has no effect. There should not be
> any difference between your first and second patch. Can you play more
> and confirm it?
>
Ahh, so you are right. I apparently misread the code.

>> but the touchstick still does not work as expected. Settting
>> ALPS_PS2_INTERLEAVED as well doesn't appear to change anything.
>
> ALPS_PS2_INTERLEAVED is just for V2 protocol. It does not have any
> effect for other protocols.
>
Good to know. It would be nice if there were a comment indicating this
in alps.c.

>> Ideas?
>
> I think now we just need description of trackstick format for V8
> protocol. And then implement it in alps V8 parser.
>
Lovely. I'd be happy to carry out the implementation if protocol
documentation is available.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRcpyAAoJEHPt6ejPuu8B+UMIAJ9O4qHPClfBLv+zPg6mBlEz
SadJK6xBttwu8NIFqvBprcJGKdI5pwKSfjo3hSavL5JuCAS+Lp3EOWZOHwIH/oXz
/BmhZkKtwLStAXPKRpjGd/a/HpH+t1KPZiLmd5HyoMsJqxC32/ffsn6Uiu2+KvVL
QUQirvqCbJjEkyKePpfuEfVhUtiRzrciXb+0YQ7aCXzsFAvp5c5Z8Vk2QSpWdvmO
4ZRUuhkNduf0+b5zaOKDhoAOJVDrAO31kOWtNz3qonEocnY4XjoIXjKYafRkHcUz
FuR0MUoSaPp2LWef/QkuvseN/599ms4VfJnsaYQQHYTKbPHCjtC4qsWdJqWF+WU=
=Q6iN
-----END PGP SIGNATURE-----
--=-=-=--
