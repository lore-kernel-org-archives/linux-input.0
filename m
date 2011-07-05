From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 01/12] Input: synaptics - cleanup 0x0c query documentation
Date: Tue, 05 Jul 2011 10:33:36 -0700
Message-ID: <4E134AF0.1090209@canonical.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org> <1309324042-22943-2-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34705 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1GERdn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 13:33:43 -0400
In-Reply-To: <1309324042-22943-2-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
> 
> Convert some spaces to tabs.
> Reorder defines to match bit ordering.
> Add defines for all bits.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/input/mouse/synaptics.h |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index 7453938..34bedde 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -66,18 +66,24 @@
>   * 1	0x60	multifinger mode	identifies firmware finger counting
>   *					(not reporting!) algorithm.
>   *					Not particularly meaningful
> - * 1	0x80    covered pad		W clipped to 14, 15 == pad mostly covered
> - * 2	0x01    clickpad bit 1		2-button ClickPad
> - * 2	0x02    deluxe LED controls	touchpad support LED commands
> + * 1	0x80	covered pad		W clipped to 14, 15 == pad mostly covered
> + * 2	0x01	clickpad bit 1		2-button ClickPad
> + * 2	0x02	deluxe LED controls	touchpad support LED commands
>   *					ala multimedia control bar
>   * 2	0x04	reduced filtering	firmware does less filtering on
>   *					position data, driver should watch
>   *					for noise.
>   */
> -#define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
> -#define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
> +#define SYN_CAP_ADJ_THRESHOLD(ex0c)	((ex0c) & 0x010000)
>  #define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
> +#define SYN_CAP_CLEARPAD(ex0c)		((ex0c) & 0x040000)
>  #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
> +#define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
> +#define SYN_CAP_MULTIFINGER_MODE(ex0c)	((ex0c) & 0x600000)
> +#define SYN_CAP_COVERED_PAD(ex0c)	((ex0c) & 0x800000)
> +#define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
> +#define SYN_CAP_DELUXE_LED(ex0c)	((ex0c) & 0x000200)
> +#define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & 0x000400)
>  
>  /* synaptics modes query bits */
>  #define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))

I may not be the most knowledgeable developer on Synaptics, but I think
I'm somewhat knowledgeable and I can't figure out what each of the
bitmasks does now. Since we now have many of them defined, could you add
documentation about what each means? For example, I don't know if
SYN_CAP_CLICKPAD is set in conjunction with SYN_CAP_CLICKPAD2BTN, or if
they are mutually exclusive. I also don't know what SYN_CAP_CLICKPAD2BTN
means anyways :).

I'm curious, are you basing this work on documentation or
reverse-engineering? Maybe you can't say :). It would be awesome if
someone at Synaptics would just release the documentation for these
advanced features already...

Thanks!

-- Chase
