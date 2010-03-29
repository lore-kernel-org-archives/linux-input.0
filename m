From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Sony Vaio VPCZ1 series to the nopnp table
Date: Mon, 29 Mar 2010 16:39:01 -0700
Message-ID: <20100329233901.GF5864@core.coreip.homeip.net>
References: <20100329233257.GA85504@jhz.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57237 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab0C2Xj3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Mar 2010 19:39:29 -0400
Received: by gyg13 with SMTP id 13so1792853gyg.19
        for <linux-input@vger.kernel.org>; Mon, 29 Mar 2010 16:39:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100329233257.GA85504@jhz.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Hendrik Zab <jan@jhz.name>
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

Hi Jan-Hendrik,

On Tue, Mar 30, 2010 at 01:32:57AM +0200, Jan-Hendrik Zab wrote:
> The entire Sony Vaio VPCZ1 series seems to need the nopnp option set to
> get the touchpad working. This patch adds the laptops to the nopnp table
> to automatically set it.
> 
> Signed-off-by: Jan-Hendrik Zab <jan@jhz.name>
> 

In what way the PNP data is messed up? Can we get a dmesg of the boot
without the patch?

Thanks.

> ---
>  drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index ead0494..7c0cb87 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -495,6 +495,14 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
>  		},
>  	},
> +	{
> +		/* Sony Vaio VPCZ1 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VPCZ1"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 1.7.0.3
> 

-- 
Dmitry
