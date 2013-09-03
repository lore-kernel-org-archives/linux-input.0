From: Tom Gundersen <teg@jklm.no>
Subject: Re: [PATCH 1/2] input: allow SERIO=m even without EXPERT=y
Date: Tue, 3 Sep 2013 15:41:15 +0200
Message-ID: <CAG-2HqVqDTEX=-AAb-3J8ZFv9imKcCBoxQaQt0o3vb7BTiz8tQ@mail.gmail.com>
References: <1378215656-11827-1-git-send-email-teg@jklm.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:39490 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928Ab3ICNlh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 09:41:37 -0400
Received: by mail-bk0-f54.google.com with SMTP id mz12so2182028bkb.27
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 06:41:36 -0700 (PDT)
In-Reply-To: <1378215656-11827-1-git-send-email-teg@jklm.no>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tom Gundersen <teg@jklm.no>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sorry, this resend was accidental, please ignore. I only intended to
send patch 2/2.

On Tue, Sep 3, 2013 at 3:40 PM, Tom Gundersen <teg@jklm.no> wrote:
> There is plenty of consumer hardware (e.g., mac books) that does not use
> AT keyboards or PS/2 mice. It therefore makes sense for distro kernels
> to build the related drivers as modules to avoid loading them on hardware
> that does not need them. As such, these options should no longer be protected
> by EXPERT.
>
> Moreover, building these drivers as modules gets rid of the following ugly
> error during boot:
>
> [    2.337745] i8042: PNP: No PS/2 controller found. Probing ports directly.
> [    3.439537] i8042: No controller found
>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig | 4 ++--
>  drivers/input/serio/Kconfig    | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 269d4c3..2d31cec 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -2,7 +2,7 @@
>  # Input core configuration
>  #
>  menuconfig INPUT_KEYBOARD
> -       bool "Keyboards" if EXPERT || !X86
> +       bool "Keyboards"
>         default y
>         help
>           Say Y here, and a list of supported keyboards will be displayed.
> @@ -67,7 +67,7 @@ config KEYBOARD_ATARI
>           module will be called atakbd.
>
>  config KEYBOARD_ATKBD
> -       tristate "AT keyboard" if EXPERT || !X86
> +       tristate "AT keyboard"
>         default y
>         select SERIO
>         select SERIO_LIBPS2
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 1e691a3..39c869d 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -2,7 +2,7 @@
>  # Input core configuration
>  #
>  config SERIO
> -       tristate "Serial I/O support" if EXPERT || !X86
> +       tristate "Serial I/O support"
>         default y
>         help
>           Say Yes here if you have any input device that uses serial I/O to
> @@ -19,7 +19,7 @@ config SERIO
>  if SERIO
>
>  config SERIO_I8042
> -       tristate "i8042 PC Keyboard controller" if EXPERT || !X86
> +       tristate "i8042 PC Keyboard controller"
>         default y
>         depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && \
>                    (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !S390 && \
> @@ -170,7 +170,7 @@ config SERIO_MACEPS2
>           module will be called maceps2.
>
>  config SERIO_LIBPS2
> -       tristate "PS/2 driver library" if EXPERT
> +       tristate "PS/2 driver library"
>         depends on SERIO_I8042 || SERIO_I8042=n
>         help
>           Say Y here if you are using a driver for device connected
> --
> 1.8.4
>
