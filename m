From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keyboard: imx: no need to control interrupt
 status in event check
Date: Wed, 3 Apr 2019 14:48:42 -0700
Message-ID: <20190403214842.GD53104@dtor-ws>
References: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Hi Anson,

On Fri, Mar 29, 2019 at 07:00:43AM +0000, Anson Huang wrote:
> There is no need to enable release interrupt and disable depress
> interrupt in event check, as a timer is setup for checking these
> events rather than interrupts.

But won't using release interrupt allow signalling key release earlier?

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/imx_keypad.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 539cb67..7e32c36 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -276,11 +276,6 @@ static void imx_keypad_check_for_events(struct timer_list *t)
>  		reg_val = readw(keypad->mmio_base + KPSR);
>  		reg_val |= KBD_STAT_KPKR | KBD_STAT_KRSS;
>  		writew(reg_val, keypad->mmio_base + KPSR);
> -
> -		reg_val = readw(keypad->mmio_base + KPSR);
> -		reg_val |= KBD_STAT_KRIE;
> -		reg_val &= ~KBD_STAT_KDIE;
> -		writew(reg_val, keypad->mmio_base + KPSR);
>  	}
>  }
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
