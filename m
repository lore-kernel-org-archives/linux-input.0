From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: alps: Add support for the touchpad of the Toshiba
 Tecra A11-11L
Date: Tue, 9 Mar 2010 11:26:34 -0800
Message-ID: <20100309192634.GC28000@core.coreip.homeip.net>
References: <1268160967-21403-1-git-send-email-thomas@archlinux.org>
 <20100309190135.GB28000@core.coreip.homeip.net>
 <4B969EAE.3030903@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:32823 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0CIT0p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 14:26:45 -0500
Received: by fxm5 with SMTP id 5so1718857fxm.29
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 11:26:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B969EAE.3030903@archlinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: linux-input@vger.kernel.org

On Tue, Mar 09, 2010 at 08:17:02PM +0100, Thomas B=E4chler wrote:
> Am 09.03.2010 20:01, schrieb Dmitry Torokhov:
> > Hi Thomas,
> >=20
> > On Tue, Mar 09, 2010 at 07:56:07PM +0100, Thomas B=E4chler wrote:
> >>
> >> Signed-off-by: Thomas B=E4chler <thomas@archlinux.org>
> >> ---
> >> This patch was made by trial-and-error, I copied the byte0 and
> >> mask0 value from another model, tried different flags settings
> >> and it seems to work. I have no idea if there might be side-
> >> effects due to incorrect settings. Please tell me if I can do
> >> anything to verify or correct these values.
> >>
> >>  drivers/input/mouse/alps.c |    2 ++
> >>  1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps=
=2Ec
> >> index f93c2c0..f6dad83 100644
> >> --- a/drivers/input/mouse/alps.c
> >> +++ b/drivers/input/mouse/alps.c
> >> @@ -63,6 +63,8 @@ static const struct alps_model_info alps_model_d=
ata[] =3D {
> >>  	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
> >>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
> >>  	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* De=
ll Vostro 1400 */
> >> +	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
> >> +		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshi=
ba Tecra A11-11L */
> >>  };
> >> =20
> >=20
> > Looking at the picture it appears to have a touchpad only, not a
> > touchpad/trackpoint combo. So I am wondering if ALPS_DUALPOINT and
> > ALPS_PS2_INTERLEAVED flags are needed here. What happens if you rem=
ove
> > them? Also, does it have external PS/2 post?
>=20
> The model I have here does have a trackpoint, thus I put ALPS_DUALPOI=
NT
> in. Also, I had problems without ALPS_PS2_INTERLEAVED ([...] lost syn=
c
> at byte 1). I did not try without ALPS_PASS though, only with.
>=20

No, ALPS_PASS is OK - you would notice right away if you didn't need it
- the device would not switch to absolute mode.

> The device does not seem to have an external PS/2 port, but there is =
a
> connector for a docking station (which I don't own).
>

Ah, I see.
=20
> I am more concerned about the two 0xff values here, because they are
> actually guesses.
>=20

If you do not see it loosing sync as you workign it then you selected
proper byte0 and mask.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
