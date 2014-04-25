From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] synaptics: Add min/max quirk for ThinkPad Edge E431
Date: Thu, 24 Apr 2014 23:37:29 -0700
Message-ID: <20140425063729.GC10433@core.coreip.homeip.net>
References: <1398270248-24403-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44002 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaDYGhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 02:37:32 -0400
Content-Disposition: inline
In-Reply-To: <1398270248-24403-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 23, 2014 at 06:24:08PM +0200, Hans de Goede wrote:
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 7c9f509..93cc8fd 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1566,6 +1566,14 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
>  		.driver_data = (int []){1232, 5710, 1156, 4696},
>  	},
>  	{
> +		/* Lenovo ThinkPad Edge E431 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Edge E431"),
> +		},
> +		.driver_data = (int []){1024, 5022, 2508, 4832},
> +	},
> +	{
>  		/* Lenovo ThinkPad T431s */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -- 
> 1.9.0
> 

-- 
Dmitry
