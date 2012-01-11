From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH TRIVIAL 1/5] Input: keyboard: use macro module_platform_driver()
Date: Wed, 11 Jan 2012 10:07:38 +0800
Message-ID: <87lipf9el1.fsf@emc.com.tw>
References: <1321952446-7591-1-git-send-email-jj_ding@emc.com.tw> <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw> <CAMuHMdWVedppkaO5sF4WH78e8rdVJKXJknFVEZQo+VD2Rxmk=A@mail.gmail.com> <CAMuHMdU1fv-Qx1dRstFjBkqcKswWCu34Hkeusk1vW3ReXB7CDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:61607 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab2AKCIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 21:08:20 -0500
In-Reply-To: <CAMuHMdU1fv-Qx1dRstFjBkqcKswWCu34Hkeusk1vW3ReXB7CDA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

Hi Geert,

On Tue, 10 Jan 2012 21:57:08 +0100, Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Jan 10, 2012 at 21:47, Geert Uytterhoeven <geert@linux-m68k.o=
rg> wrote:
>=20
> And looking for platform_driver_probe() in recent changesets, I found
> a few more:
>=20
> drivers/input/touchscreen/atmel-wm97xx.c atmel_wm97xx_probe
> drivers/input/touchscreen/mc13783_ts.c mc13783_ts_probe
> drivers/input/serio/at32psif.c psif_probe
> drivers/input/mouse/amimouse.c amimouse_probe
>=20
> Interestingly, in drivers/input/misc/twl4030-pwrbutton.c you did make
> platform_driver.probe point to twl4030_pwrbutton_probe().
> But that one is also broken, as twl4030_pwrbutton_probe() is marked _=
_init,
> which is no longer correct.
>=20
> Still, setting up platform_driver.probe and removing __init from all =
probe
> functions is not the right thing to do, as this make (non-__init) ker=
nel code
> size bigger, while none of these devices are hotpluggable and thus ca=
nnot
> appear after bootup. That's why we have platform_driver_probe() in th=
e
> first place. So I think all of this should be reverted for non-hotplu=
ggable
> drivers.

Thank you for explaining this.
I am sorry for the trouble.

jj

> Gr{oetje,eeting}s,
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>=20
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
