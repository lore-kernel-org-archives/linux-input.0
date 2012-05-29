From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 05/15] keyboard: imx_keypad: Use
 clk_prepare_enable/clk_disable_unprepare
Date: Tue, 29 May 2012 11:18:25 +0200
Message-ID: <20120529091825.GH30400@pengutronix.de>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
 <1337987696-31728-5-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42338 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2E2JSa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 May 2012 05:18:30 -0400
Content-Disposition: inline
In-Reply-To: <1337987696-31728-5-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, May 25, 2012 at 08:14:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Prepare the clock before enabling it.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: <linux-input@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/input/keyboard/imx_keypad.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 6ee7421..9d57945 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -378,7 +378,7 @@ static void imx_keypad_close(struct input_dev *dev)
>  	imx_keypad_inhibit(keypad);
>  
>  	/* Disable clock unit */
> -	clk_disable(keypad->clk);
> +	clk_disable_unprepare(keypad->clk);
>  }
>  
>  static int imx_keypad_open(struct input_dev *dev)
> @@ -391,7 +391,7 @@ static int imx_keypad_open(struct input_dev *dev)
>  	keypad->enabled = true;
>  
>  	/* Enable the kpp clock */
> -	clk_enable(keypad->clk);
> +	clk_prepare_enable(keypad->clk);
>  	imx_keypad_config(keypad);
>  
>  	/* Sanity control, not all the rows must be actived now. */
> @@ -581,7 +581,7 @@ static int imx_kbd_suspend(struct device *dev)
>  	mutex_lock(&input_dev->mutex);
>  
>  	if (input_dev->users)
> -		clk_disable(kbd->clk);
> +		clk_disable_unprepare(kbd->clk);
>  
>  	mutex_unlock(&input_dev->mutex);
>  
> @@ -603,7 +603,7 @@ static int imx_kbd_resume(struct device *dev)
>  	mutex_lock(&input_dev->mutex);
>  
>  	if (input_dev->users)
> -		clk_enable(kbd->clk);
> +		clk_prepare_enable(kbd->clk);
>  
>  	mutex_unlock(&input_dev->mutex);
>  
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
