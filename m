From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Fujitsu Lifebook AH544 to notimeout
 list
Date: Mon, 19 Jun 2017 19:49:10 -0700
Message-ID: <20170620024910.GC21379@dtor-ws>
References: <20170619174157.3385-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35302 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdFTCtO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 22:49:14 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so19064253pgc.2
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 19:49:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170619174157.3385-1-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: linux-input@vger.kernel.org, linux@endlessm.com

On Mon, Jun 19, 2017 at 11:41:57AM -0600, Daniel Drake wrote:
> Without this quirk, the touchpad is not responsive on this product, with
> the following message repeated in the logs:
> 
>  psmouse serio1: bad data from KBC - timeout
> 
> Add it to the notimeout list alongside other similar Fujitsu laptops.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 09720d950686..f932a83b4990 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -723,6 +723,13 @@ static const struct dmi_system_id __initconst i8042_dmi_notimeout_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
>  		},
>  	},
> +	{
> +		/* Fujitsu UH554 laptop */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 2.11.0
> 

-- 
Dmitry
