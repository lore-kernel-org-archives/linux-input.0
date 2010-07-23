From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [resend] Input: i8042 - introduce noaux dmi quirk for
 MSI AE2220
Date: Fri, 23 Jul 2010 09:10:11 -0700
Message-ID: <20100723161011.GB21546@core.coreip.homeip.net>
References: <20100721181625.286f147c@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51950 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757748Ab0GWQKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 12:10:17 -0400
Received: by pvc7 with SMTP id 7so3564438pvc.19
        for <linux-input@vger.kernel.org>; Fri, 23 Jul 2010 09:10:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100721181625.286f147c@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org

Hi Anisse,

On Wed, Jul 21, 2010 at 06:16:25PM +0200, Anisse Astier wrote:
> 
> This computer does no have an external PS2 port, and booting without
> i8042.noaux induces a 10 second boot delay, until the AUX port detection
> timeouts.
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>

Sorry for loosing track of this, however, before we add a new type of
blacklist (which Linus did not like in the similar scenario with
MacBook) could you please send me your DSDT?

Thanks!

> ---
>  drivers/input/serio/i8042-x86ia64io.h |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 6168469..f5f81e2 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -479,6 +479,20 @@ static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id __initconst i8042_dmi_noaux_table[] = {
> +	{
> +		/*
> +		 * MSI AE2220
> +		 * Timeout (10 sec) at boot if not passed noaux
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MS-6657"),
> +		},
> +	},
> +	{ }
> +};
> +
>  #ifdef CONFIG_PNP
>  static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  	{
> @@ -871,6 +885,9 @@ static int __init i8042_platform_init(void)
>  
>  	if (dmi_check_system(i8042_dmi_dritek_table))
>  		i8042_dritek = true;
> +
> +	if (dmi_check_system(i8042_dmi_noaux_table))
> +		i8042_noaux = true;
>  #endif /* CONFIG_X86 */
>  
>  	return retval;
> -- 
> 1.7.0.6
> 

-- 
Dmitry
