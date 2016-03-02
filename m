From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Remove ARCH_SHMOBILE
Date: Wed, 2 Mar 2016 10:30:35 +0100
Message-ID: <CAMuHMdU8W1GrBO=UJPk2P+Yt4swrTzxpBR7TNYBGk=N7wqvBcQ@mail.gmail.com>
References: <1456883754-24305-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34363 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbcCBJag (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 04:30:36 -0500
In-Reply-To: <1456883754-24305-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Simon,

On Wed, Mar 2, 2016 at 2:55 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> [PATCH] Remove ARCH_SHMOBILE

Please use a more appropriate one-line summary.

> Since the removal of legacy (non-multiplatform) support this driver has not
> been used by any Renesas ARM based SoCs.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>  Based on v4.5-rc1
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index ddd8148d51d7..984532c6e689 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -560,7 +560,7 @@ config KEYBOARD_SUNKBD
>
>  config KEYBOARD_SH_KEYSC
>         tristate "SuperH KEYSC keypad support"
> -       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> +       depends on SUPERH || COMPILE_TEST

I think dropping the SUPERH dependency is the right approach here, as all
SuperH platforms using the driver select ARCH_SHMOBILE.

"sh_keysc" is used on SH_MIGOR, SH_ECOVEC, SH_KFR2R09, SH_7722_SOLUTION_ENGINE,
and SH_7724_SOLUTION_ENGINE, which depend on either CPU_SUBTYPE_SH7722 or
CPU_SUBTYPE_SH7724, and both select ARCH_SHMOBILE.

>         help
>           Say Y here if you want to use a keypad attached to the KEYSC block
>           on SuperH processors such as sh7722 and sh7343.

FWIW, this has never been enabled on sh7343. But CPU_SUBTYPE_SH7343 also
selects ARCH_SHMOBILE, so we're safe.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
