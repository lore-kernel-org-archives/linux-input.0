From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 11:13:13 -0800
Message-ID: <20161112191313.GB5809@dtor-ws>
References: <20161111235759.11988-1-chris@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36764 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966695AbcKLTNR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 14:13:17 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so1365154pfb.3
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 11:13:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161111235759.11988-1-chris@diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Richard Pospesel <pospeselr@gmail.com>, linux-input@vger.kernel.org, phonesyfreakies@gmail.com, Michael Shell <list1@michaelshell.org>, Ondrej Zary <linux@rainbow-software.org>

On Fri, Nov 11, 2016 at 11:57:59PM +0000, Chris Diamand wrote:
> Because the BYD touchpad uses standard PS/2 commands for its
> detection sequence, some other models are incorrectly detected as BYD
> touchpads. This causes chaos when byd_init() later fails.
> 
> To fix this, init() and detect() should be merged. However, this
> would slow down detection for other mouse models. Instead, add a DMI
> check before attempting touchpad detection.
> 
> Signed-off-by: Chris Diamand <chris@diamand.org>
> ---
> Hi all,
> 
> This patch should fix the mis-detection of some mouse models as BYD touchpads,
> as mentioned in a few bug reports and other threads.
> 
> However, I no longer have a machine with a BYD touchpad (although I did record
> its DMI data), so this is mostly untested - could anyone *with* a BYD touchpad
> please try this patch to check their touchpad still works, and could anyone
> with a misdetected non-BYD touchpad please check that this fixes the
> misdetection?
> 
> Also, the DMI fields really are pretty much all like that ("To Be Filled By
> O.E.M.", etc). I've tried to choose the most specific ones, but it's still
> fairly arbitrary...

No, unfortunately this will trigger on many more whitebox devices.

> 
> Cheers!
> Chris
> 
>  drivers/input/mouse/byd.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index b27aa63..b4c5fd0 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/input.h>
>  #include <linux/libps2.h>
>  #include <linux/serio.h>
> @@ -235,6 +236,17 @@ struct byd_data {
>  	bool touch;
>  };
>  
> +static const struct dmi_system_id byd_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SharkBay Platform"),
> +			DMI_MATCH(DMI_PRODUCT_SERIAL, "System Serial Number"),
> +			DMI_MATCH(DMI_BOARD_NAME, "WhiteTip Mountain1 Fab2"),
> +			DMI_MATCH(DMI_CHASSIS_VENDOR, "To Be Filled By O.E.M."),
> +		},
> +	},
> +};
> +
>  static void byd_report_input(struct psmouse *psmouse)
>  {
>  	struct byd_data *priv = psmouse->private;
> @@ -439,6 +451,9 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
>  	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
>  
> +	if (!dmi_check_system(byd_dmi_table))
> +		return -1;
> +
>  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>  		return -1;
>  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -- 
> 2.10.1
> 

-- 
Dmitry
