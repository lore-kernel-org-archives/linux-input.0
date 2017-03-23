From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - do not mix logical and bitwise
 operations
Date: Thu, 23 Mar 2017 19:30:26 +0100
Message-ID: <20170323183026.GA4009@mail.corp.redhat.com>
References: <20170323173545.GA29239@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbdCWSap (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Mar 2017 14:30:45 -0400
Content-Disposition: inline
In-Reply-To: <20170323173545.GA29239@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org

On Mar 23 2017 or thereabouts, Dmitry Torokhov wrote:
> Let's stop using !!x to reduce value of trackstick button expression to 0/1
> and use shift instead. This removes the following sparse warning:
> 
>   CHECK   drivers/input/mouse/synaptics.c
> drivers/input/mouse/synaptics.c:943:79: warning: dubious: !x | y
> 
> Also, the bits we are testing are not capabilities, so lets drop "_CAP"
> suffix from macro names.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/mouse/synaptics.c | 6 +++---
>  drivers/input/mouse/synaptics.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 86ed45bda7bb..dd6caa0e7e09 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -940,9 +940,9 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
>  		u8 pt_buttons;
>  
>  		/* The trackstick expects at most 3 buttons */
> -		pt_buttons = SYN_CAP_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
> -			     SYN_CAP_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
> -			     SYN_CAP_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
> +		pt_buttons = SYN_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
> +			     SYN_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
> +			     SYN_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
>  
>  		serio_interrupt(priv->pt_port,
>  				PSMOUSE_OOB_EXTRA_BTNS, SERIO_OOB_DATA);
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index fc93481cf183..31652d98b8f7 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -112,9 +112,9 @@
>  #define SYN_CAP_EXT_BUTTONS_STICK(ex10)	((ex10) & 0x010000)
>  #define SYN_CAP_SECUREPAD(ex10)		((ex10) & 0x020000)
>  
> -#define SYN_CAP_EXT_BUTTON_STICK_L(eb)	(!!((eb) & 0x01))
> -#define SYN_CAP_EXT_BUTTON_STICK_M(eb)	(!!((eb) & 0x02))
> -#define SYN_CAP_EXT_BUTTON_STICK_R(eb)	(!!((eb) & 0x04))
> +#define SYN_EXT_BUTTON_STICK_L(eb)	(((eb) & BIT(0)) >> 0)
> +#define SYN_EXT_BUTTON_STICK_M(eb)	(((eb) & BIT(1)) >> 1)
> +#define SYN_EXT_BUTTON_STICK_R(eb)	(((eb) & BIT(2)) >> 2)
>  
>  /* synaptics modes query bits */
>  #define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
> -- 
> 2.12.1.500.gab5fba24ee-goog
> 
> 
> -- 
> Dmitry
