From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Add touchscreen platform data for the Onda oBook 20 Plus
 tablet.
Date: Mon, 11 Dec 2017 11:24:27 +0100
Message-ID: <ed1b12aa-c8e8-de6d-fdd0-fbd2636a8d54@redhat.com>
References: <20171210220213.19290-1-nerijus@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42155 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKKY3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 05:24:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id b199so9624642wme.1
        for <linux-input@vger.kernel.org>; Mon, 11 Dec 2017 02:24:29 -0800 (PST)
In-Reply-To: <20171210220213.19290-1-nerijus@users.sourceforge.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nerijus Baliunas <nerijus@users.sourceforge.net>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi,

On 10-12-17 23:02, Nerijus Baliunas wrote:
> Signed-off-by: Nerijus Baliūnas <nerijus@users.sourceforge.net>

Looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/platform/x86/silead_dmi.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index 266535c2a72f..414293e8c448 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -171,6 +171,23 @@ static const struct silead_ts_dmi_data digma_citi_e200_data = {
>   	.properties	= digma_citi_e200_props,
>   };
>   
> +static const struct property_entry onda_obook_20_plus_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-onda-obook-20-plus.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct silead_ts_dmi_data onda_obook_20_plus_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= onda_obook_20_plus_props,
> +};
> +
>   static const struct dmi_system_id silead_ts_dmi_table[] = {
>   	{
>   		/* CUBE iwork8 Air */
> @@ -271,6 +288,14 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>   			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>   		},
>   	},
> +	{
> +		/* Onda oBook 20 Plus */
> +		.driver_data = (void *)&onda_obook_20_plus_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ONDA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
> +		},
> +	},
>   	{ },
>   };
>   
> 
