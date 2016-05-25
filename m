From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 17:43:10 +0200
Message-ID: <20160525154310.GZ29844@pali>
References: <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM>
 <87bn45gr0e.fsf@smart-cactus.org>
 <20160517082309.GZ29844@pali>
 <877fet10a9.fsf@smart-cactus.org>
 <20160517131629.GE29844@pali>
 <23E0F704395E694FA4710C833FA087E50D40B8C592@TPEX7ADC101.APAC.DELL.COM>
 <20160517152239.GF29844@pali>
 <23E0F704395E694FA4710C833FA087E50D40D0723A@TPEX7ADC101.APAC.DELL.COM>
 <20160525073949.GY29844@pali>
 <877feijp2b.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36861 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbcEYPnN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 11:43:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so16771105wmg.3
        for <linux-input@vger.kernel.org>; Wed, 25 May 2016 08:43:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877feijp2b.fsf@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Allen_Hung@Dell.com, Mario_Limonciello@Dell.com, linux-input@vger.kernel.org, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wednesday 25 May 2016 14:32:28 Ben Gamari wrote:
> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
>=20
> > Hi Allen, thank you for confirmation.
> >
> > Ben, V8 protocol is supported by linux kernel since version 4.1. Do=
 you
> > have needed version? If yes and your touchpad does not work, please
> > compile psmouse.ko in debug mode and send us dmesg output. Maybe th=
ere
> > can be something interesting...
> >
> The first attached patch gets me partly there; I see multitouch event=
s,
> the pressure appears to reflect reality, and things generally work as
> expected. That is, until I try to touch the touchstick, which causes =
the
> pointer to jump around wildly.

So with first patch touchpad starts working fine and just trackstick
cause problems?

Reason for non working trackstick is simple. Driver alps.c does not
support trackstick in V8 protocol. So you even does not see second
(trackstick) input device, right?

> The second attached patch makes things behave slightly better,

Looking at the alps.c code it should act exactly same. V8 does not
support trackpoint, so ALPS_DUALPOINT has no effect. There should not b=
e
any difference between your first and second patch. Can you play more
and confirm it?

> but the touchstick still does not work as expected. Settting
> ALPS_PS2_INTERLEAVED as well doesn't appear to change anything.

ALPS_PS2_INTERLEAVED is just for V2 protocol. It does not have any
effect for other protocols.

> Ideas?

I think now we just need description of trackstick format for V8
protocol. And then implement it in alps V8 parser.

Anyway, now I'm looking at Documentation/input/alps.txt file and there
is no info about V8 protocol :-(

Hans, do you have "compact" description of V8 protocol? So it can be
added into that alps.txt file. Also do you have description of that
missing trackstick V8 format?

> Cheers,
>=20
> - Ben
>=20
>=20
>=20
> From 73f99f86c77d39ff512f2064ca9f2002c6404dd9 Mon Sep 17 00:00:00 200=
1
> From: Ben Gamari <ben@smart-cactus.org>
> Date: Wed, 25 May 2016 14:19:53 +0200
> Subject: [PATCH 1/2] alps: Add touchpad for Dell Latitude E7470
>=20
> However, this still isn't quite right as the touchstick appears to
> corrupt the event stream.
> ---
>  drivers/input/mouse/alps.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 936f07a..a0c5dfe 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2767,6 +2767,9 @@ static int alps_identify(struct psmouse *psmous=
e, struct alps_data *priv)
>  		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
>  			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
>  			protocol =3D &alps_v8_protocol_data;
> +		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
> +               e7[2] =3D=3D 0x28 && ec[1] =3D=3D 0x01) {
> +      protocol =3D &alps_v8_protocol_data;
>  		} else {
>  			psmouse_dbg(psmouse,
>  				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, e=
c);

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
