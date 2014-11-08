From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] Input: elantech - Fix crc_enabled for Fujitsu H730
Date: Sat, 8 Nov 2014 00:22:47 -0800
Message-ID: <20141108082247.GB21475@dtor-ws>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
 <1409407846-15449-3-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37124 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbaKHIWw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 03:22:52 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl2so14007428igb.10
        for <linux-input@vger.kernel.org>; Sat, 08 Nov 2014 00:22:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1409407846-15449-3-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Sat, Aug 30, 2014 at 04:10:43PM +0200, Ulrik De Bie wrote:
> The Fujitsu H730 does not work with crc_enabled = 0, even though the
> crc_enabled bit in the firmware version indicated it would. When switching
> this value to crc_enabled to 1, the touchpad works. This patch uses
> DMI to detect H730.
> 
> Reported-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

Applied with some edits to minimize patch size, thank you.

> ---
>  drivers/input/mouse/elantech.c | 65 ++++++++++++++++++++++++++++++------------
>  drivers/input/mouse/elantech.h |  2 +-
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index f0a55b4d..67d56c0 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1235,6 +1235,52 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  	return 0;
>  }
>  
> +/*
> + * Some hw_version 3 models go into error state when we try to set
> + * bit 3 and/or bit 1 of r10.
> + */
> +static const struct dmi_system_id no_hw_res_dmi_table[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		/* Gigabyte U2442 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "U2442"),
> +		},
> +	},
> +#endif
> +	{ }
> +};
> +
> +/*
> + * Some hw_version 4 models do not work with crc_disabled
> + */
> +static const struct dmi_system_id elantech_dmi_crc_enabled[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		/* Fujitsu H730 does not work with crc_enabled == 0 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
> +		},
> +	},
> +#endif
> +	{ }
> +};
> +
> +/*
> + * Autodetect crc_enabled and verify override DMI table
> + */
> +static unsigned char elantech_detect_crc_enabled(struct elantech_data *etd)
> +{
> +
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	if (dmi_check_system(elantech_dmi_crc_enabled))
> +		return 1;
> +#endif /* CONFIG_X86 */
> +
> +	return ((etd->fw_version & 0x4000) == 0x4000);
> +}
>  struct elantech_attr_data {
>  	size_t		field_offset;
>  	unsigned char	reg;
> @@ -1444,23 +1490,6 @@ static int elantech_reconnect(struct psmouse *psmouse)
>  }
>  
>  /*
> - * Some hw_version 3 models go into error state when we try to set
> - * bit 3 and/or bit 1 of r10.
> - */
> -static const struct dmi_system_id no_hw_res_dmi_table[] = {
> -#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> -	{
> -		/* Gigabyte U2442 */
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "U2442"),
> -		},
> -	},
> -#endif
> -	{ }
> -};
> -
> -/*
>   * determine hardware version and set some properties according to it.
>   */
>  static int elantech_set_properties(struct elantech_data *etd)
> @@ -1518,7 +1547,7 @@ static int elantech_set_properties(struct elantech_data *etd)
>  	 * The signatures of v3 and v4 packets change depending on the
>  	 * value of this hardware flag.
>  	 */
> -	etd->crc_enabled = ((etd->fw_version & 0x4000) == 0x4000);
> +	etd->crc_enabled = elantech_detect_crc_enabled(etd);
>  
>  	/* Enable real hardware resolution on hw_version 3 ? */
>  	etd->set_hw_resolution = !dmi_check_system(no_hw_res_dmi_table);
> diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
> index 6f3afec..c25127a 100644
> --- a/drivers/input/mouse/elantech.h
> +++ b/drivers/input/mouse/elantech.h
> @@ -128,11 +128,11 @@ struct elantech_data {
>  	unsigned char reg_25;
>  	unsigned char reg_26;
>  	unsigned char debug;
> +	unsigned char crc_enabled;
>  	unsigned char capabilities[3];
>  	bool paritycheck;
>  	bool jumpy_cursor;
>  	bool reports_pressure;
> -	bool crc_enabled;
>  	bool set_hw_resolution;
>  	unsigned char hw_version;
>  	unsigned int fw_version;
> -- 
> 2.1.0
> 

-- 
Dmitry
