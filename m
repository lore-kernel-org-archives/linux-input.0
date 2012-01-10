From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH TRIVIAL 1/5] Input: keyboard: use macro module_platform_driver()
Date: Tue, 10 Jan 2012 21:47:40 +0100
Message-ID: <CAMuHMdWVedppkaO5sF4WH78e8rdVJKXJknFVEZQo+VD2Rxmk=A@mail.gmail.com>
References: <1321952446-7591-1-git-send-email-jj_ding@emc.com.tw>
	<1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64031 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab2AJUrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 15:47:41 -0500
In-Reply-To: <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

On Tue, Nov 22, 2011 at 10:00, JJ Ding <jj_ding@emc.com.tw> wrote:
> From: JJ Ding <dgdunix@gmail.com>
>
> Commit 940ab88962bc1aff3273a8356d64577a6e386736 introduced a new macr=
o to
> save some platform_driver boilerplate code. Use it.

> diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard=
/amikbd.c
> index 79172af..6df5f6a 100644
> --- a/drivers/input/keyboard/amikbd.c
> +++ b/drivers/input/keyboard/amikbd.c
> @@ -259,19 +259,6 @@ static struct platform_driver amikbd_driver =3D =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =C2=A0=3D=
 THIS_MODULE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
> -
> -static int __init amikbd_init(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return platform_driver_probe(&amikbd_driver, a=
mikbd_probe);
> -}
> -
> -module_init(amikbd_init);
> -
> -static void __exit amikbd_exit(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&amikbd_driver);
> -}
> -
> -module_exit(amikbd_exit);
> +module_platform_driver(amikbd_driver);
>
> =C2=A0MODULE_ALIAS("platform:amiga-keyboard");

Sorry for not noticing before, but this is not correct.
Drivers using platform_driver_probe() typically don't fill in the
platform_driver.probe
method, as it's passed explicitly to platform_driver_probe() instead.
Hence amikbd_probe() is now referenced nowhere, and thus never called
(doesn't the compiler warn about amikbd_probe() being defined but unuse=
d?).

> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input=
/keyboard/davinci_keyscan.c
> index 9d82b3a..4698252 100644
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ b/drivers/input/keyboard/davinci_keyscan.c
> @@ -328,18 +328,7 @@ static struct platform_driver davinci_ks_driver =
=3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D __devexit_p(davinci_ks_remove)=
,
> =C2=A0};
> -
> -static int __init davinci_ks_init(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return platform_driver_probe(&davinci_ks_drive=
r, davinci_ks_probe);
> -}
> -module_init(davinci_ks_init);
> -
> -static void __exit davinci_ks_exit(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&davinci_ks_driver)=
;
> -}
> -module_exit(davinci_ks_exit);
> +module_platform_driver(davinci_ks_driver);
>
> =C2=A0MODULE_AUTHOR("Miguel Aguilar");
> =C2=A0MODULE_DESCRIPTION("Texas Instruments DaVinci Key Scan Driver")=
;

Same here, I think.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
