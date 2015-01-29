From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2 1/3] bfin_rotary: move rotary platform header
 definition to linux platform_data head path
Date: Thu, 29 Jan 2015 17:35:31 +0800
Message-ID: <CAJxxZ0MdC2SYSz6HB4L-3HzMatLvAa2=B-TzGHpbMuh0zgpsBA@mail.gmail.com>
References: <1421225654-27872-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:39277 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbbA2Jfc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 04:35:32 -0500
Received: by mail-oi0-f51.google.com with SMTP id x69so24888521oia.10
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 01:35:31 -0800 (PST)
In-Reply-To: <1421225654-27872-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

Ping again

On Wed, Jan 14, 2015 at 4:54 PM, Sonic Zhang <sonic.adi@gmail.com> wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> The platform data definition of the rotary driver should be generic for all architectures.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  arch/blackfin/mach-bf527/boards/ad7160eval.c       |    2 +-
>  arch/blackfin/mach-bf527/boards/ezkit.c            |    2 +-
>  arch/blackfin/mach-bf548/boards/ezkit.c            |    2 +-
>  arch/blackfin/mach-bf609/boards/ezkit.c            |    2 +-
>  drivers/input/misc/bfin_rotary.c                   |    2 +-
>  .../linux/platform_data}/bfin_rotary.h             |    0
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename {arch/blackfin/include/asm => include/linux/platform_data}/bfin_rotary.h (100%)
>
> diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
> index 9501bd8..beb011b 100644
> --- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
> +++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
> @@ -666,7 +666,7 @@ static struct platform_device bfin_sport1_uart_device = {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
> -#include <asm/bfin_rotary.h>
> +#include <linux/platform_data/bfin_rotary.h>
>
>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>         /*.rotary_up_key     = KEY_UP,*/
> diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
> index d64f565..728cda4 100644
> --- a/arch/blackfin/mach-bf527/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf527/boards/ezkit.c
> @@ -1092,7 +1092,7 @@ static struct platform_device bfin_device_gpiokeys = {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
> -#include <asm/bfin_rotary.h>
> +#include <linux/platform_data/bfin_rotary.h>
>
>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>         /*.rotary_up_key     = KEY_UP,*/
> diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
> index 1fe7ff2..8f70f83 100644
> --- a/arch/blackfin/mach-bf548/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf548/boards/ezkit.c
> @@ -159,7 +159,7 @@ static struct platform_device bf54x_kpad_device = {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
> -#include <asm/bfin_rotary.h>
> +#include <linux/platform_data/bfin_rotary.h>
>
>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>         /*.rotary_up_key     = KEY_UP,*/
> diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
> index e2c0b02..f9dc64d 100644
> --- a/arch/blackfin/mach-bf609/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf609/boards/ezkit.c
> @@ -75,7 +75,7 @@ static struct platform_device bfin_isp1760_device = {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
> -#include <asm/bfin_rotary.h>
> +#include <linux/platform_data/bfin_rotary.h>
>
>  static struct bfin_rotary_platform_data bfin_rotary_data = {
>         /*.rotary_up_key     = KEY_UP,*/
> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> index e69d9bc..8f6c7cd 100644
> --- a/drivers/input/misc/bfin_rotary.c
> +++ b/drivers/input/misc/bfin_rotary.c
> @@ -12,9 +12,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/input.h>
>  #include <linux/slab.h>
> +#include <linux/platform_data/bfin_rotary.h>
>
>  #include <asm/portmux.h>
> -#include <asm/bfin_rotary.h>
>
>  static const u16 per_cnt[] = {
>         P_CNT_CUD,
> diff --git a/arch/blackfin/include/asm/bfin_rotary.h b/include/linux/platform_data/bfin_rotary.h
> similarity index 100%
> rename from arch/blackfin/include/asm/bfin_rotary.h
> rename to include/linux/platform_data/bfin_rotary.h
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
