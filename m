From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] synaptics: Add min/max quirk for the ThinkPad W540
Date: Wed, 14 May 2014 11:11:34 -0700
Message-ID: <20140514181134.GE30089@core.coreip.homeip.net>
References: <1400064364-14626-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38021 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaENSLi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 14:11:38 -0400
Content-Disposition: inline
In-Reply-To: <1400064364-14626-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, May 14, 2014 at 12:46:04PM +0200, Hans de Goede wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1096436
> 
> Cc: stable@vger.kernel.org
> Tested-and-reported-by: ajayr@bigfoot.com
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

*growl*

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index d68d33f..d4c05b1 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1614,6 +1614,14 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
>  		.driver_data = (int []){1024, 5112, 2024, 4832},
>  	},
>  	{
> +		/* Lenovo ThinkPad W540 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W540"),
> +		},
> +		.driver_data = (int []){1024, 5112, 2024, 4832},
> +	},
> +	{
>  		/* Lenovo Yoga S1 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -- 
> 1.9.0
> 

-- 
Dmitry
