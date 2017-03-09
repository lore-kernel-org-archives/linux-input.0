From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] Input: elantech - add Fujitsu Lifebook E547 to force
 crc_enabled
Date: Thu, 9 Mar 2017 18:50:59 +0100
Message-ID: <20170309175058.gtodm4q525sqyfro@lantern>
References: <c194d33b-9918-7514-d662-00d0688a7dfd@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:36665 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbdCISa0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 13:30:26 -0500
Content-Disposition: inline
In-Reply-To: <c194d33b-9918-7514-d662-00d0688a7dfd@leemhuis.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


Thanks !

Reviewed-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

Can you also provide the line equivalent for 
 * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
?


Kind regards,
Ulrik
On Thu, Mar 09, 2017 at 09:19:41AM +0100, Thorsten Leemhuis wrote:
> 
> Temporary got a Fujitsu Lifebook E547 into my hands and noticed 
> the touchpad only works after running
> 
> echo "1" > /sys/devices/platform/i8042/serio2/crc_enabled
> 
> Add it to the list of Fujitsu machines that need this workaround.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  drivers/input/mouse/elantech.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index efc8ec3..c5e513b 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1524,6 +1524,13 @@ static int elantech_reconnect(struct psmouse *psmouse)
>  		},
>  	},
>  	{
> +		/* Fujitsu LIFEBOOK E547  does not work with crc_enabled == 0 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E547"),
> +		},
> +	},
> +	{
>  		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled == 0 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -- 
> 1.8.3.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
