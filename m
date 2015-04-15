From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add support for Google Pixel
 2
Date: Wed, 15 Apr 2015 17:58:04 +0200
Message-ID: <552E8A8C.6000900@collabora.co.uk>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:36510 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbbDOP6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 11:58:12 -0400
In-Reply-To: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Olof Johansson <olof@lixom.net>

Hello Dmitry,

On 04/08/2015 02:26 AM, Dmitry Torokhov wrote:
> This change allows atmel_mxt_ts to bind to ACPI-enumerated devices in
> Google Pixel 2 (2015).
> 
> While newer version of ACPI standard allow use of device-tree-like
> properties in device descriptions, the version of ACPI implemented in
> Google BIOS does not support them, and we have to resort to DMI data to
> specify exact characteristics of the devices (touchpad vs. touchscreen,
> GPIO to button mapping, etc).
> 
> Pixel 1 continues to use i2c devices and platform data created by
> chromeos-laptop driver, since ACPI does not enumerate them.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 149 +++++++++++++++++++++++++++----
>  1 file changed, 134 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 2875ddf..dfc7309 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -14,6 +14,8 @@
>   *
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/completion.h>
> @@ -724,15 +726,15 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
>  {
>  	struct input_dev *input = data->input_dev;
>  	const struct mxt_platform_data *pdata = data->pdata;
> -	bool button;
>  	int i;
>  
> -	/* Active-low switch */
>  	for (i = 0; i < pdata->t19_num_keys; i++) {
>  		if (pdata->t19_keymap[i] == KEY_RESERVED)
>  			continue;
> -		button = !(message[1] & (1 << i));
> -		input_report_key(input, pdata->t19_keymap[i], button);
> +
> +		/* Active-low switch */
> +		input_report_key(input, pdata->t19_keymap[i],
> +				 !(message[1] & BIT(i)));

This is an unrelated cleanup so probably should had been a separate patch?

>  	}
>  }
>  
> @@ -2371,7 +2373,7 @@ static void mxt_input_close(struct input_dev *dev)
>  }
>  
>  #ifdef CONFIG_OF
> -static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> +static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  {
>  	struct mxt_platform_data *pdata;
>  	u32 *keymap;
> @@ -2379,7 +2381,7 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  	int proplen, i, ret;
>  
>  	if (!client->dev.of_node)
> -		return ERR_PTR(-ENODEV);
> +		return ERR_PTR(-ENOENT);
>  
>  	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -2410,25 +2412,132 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  	return pdata;
>  }
>  #else
> -static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
> +static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  {
> -	dev_dbg(&client->dev, "No platform data specified\n");
> -	return ERR_PTR(-EINVAL);
> +	return ERR_PTR(-ENOENT);
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +
> +struct mxt_acpi_platform_data {
> +	const char *hid;
> +	struct mxt_platform_data pdata;
> +};
> +
> +static unsigned int samus_touchpad_buttons[] = {
> +	KEY_RESERVED,
> +	KEY_RESERVED,
> +	KEY_RESERVED,
> +	BTN_LEFT
> +};
> +
> +static struct mxt_acpi_platform_data samus_platform_data[] = {
> +	{
> +		/* Touchpad */
> +		.hid	= "ATML0000",
> +		.pdata	= {
> +			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
> +			.t19_keymap	= samus_touchpad_buttons,
> +		},
> +	},
> +	{
> +		/* Touchscreen */
> +		.hid	= "ATML0001",
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id mxt_dmi_table[] = {
> +	{
> +		/* 2015 Google Pixel */
> +		.ident = "Chromebook Pixel 2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Samus"),
> +		},
> +		.driver_data = samus_platform_data,
> +	},
> +	{ }
> +};
> +
> +static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
> +{
> +	struct acpi_device *adev;
> +	const struct dmi_system_id *system_id;
> +	const struct mxt_acpi_platform_data *acpi_pdata;
> +
> +	/*
> +	 * Ignore ACPI devices representing bootloader mode.
> +	 *
> +	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
> +	 * devices for both application and bootloader modes, but we are
> +	 * interested in application mode only (if device is in bootloader
> +	 * mode we'll end up switching into application anyway). So far
> +	 * application mode addresses were all above 0x40, so we'll use it
> +	 * as a threshold.
> +	 */
> +	if (client->addr < 0x40)
> +		return ERR_PTR(-ENXIO);
> +
> +	adev = ACPI_COMPANION(&client->dev);
> +	if (!adev)
> +		return ERR_PTR(-ENOENT);
> +
> +	system_id = dmi_first_match(mxt_dmi_table);
> +	if (!system_id)
> +		return ERR_PTR(-ENOENT);
> +
> +	acpi_pdata = system_id->driver_data;
> +	if (!acpi_pdata)
> +		return ERR_PTR(-ENOENT);
> +
> +	while (acpi_pdata->hid) {
> +		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid))
> +			return &acpi_pdata->pdata;
> +
> +		acpi_pdata++;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +#else
> +static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
> +#endif
> +
> +static const struct mxt_platform_data *
> +mxt_get_platform_data(struct i2c_client *client)
> +{
> +	const struct mxt_platform_data *pdata;
> +
> +	pdata = dev_get_platdata(&client->dev);
> +	if (pdata)
> +		return pdata;
> +
> +	pdata = mxt_parse_dt(client);
> +	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
> +		return pdata;
> +
> +	pdata = mxt_parse_acpi(client);
> +	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
> +		return pdata;
> +
> +	dev_err(&client->dev, "No platform data specified\n");
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct mxt_data *data;
>  	const struct mxt_platform_data *pdata;
>  	int error;
>  
> -	pdata = dev_get_platdata(&client->dev);
> -	if (!pdata) {
> -		pdata = mxt_parse_dt(client);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -	}
> +	pdata = mxt_get_platform_data(client);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
>  
>  	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
>  	if (!data) {
> @@ -2536,6 +2645,15 @@ static const struct of_device_id mxt_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mxt_of_match);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id mxt_acpi_id[] = {
> +	{ "ATML0000", 0 },	/* Touchpad */
> +	{ "ATML0001", 0 },	/* Touchscreen */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, mxt_acpi_id);
> +#endif
> +
>  static const struct i2c_device_id mxt_id[] = {
>  	{ "qt602240_ts", 0 },
>  	{ "atmel_mxt_ts", 0 },
> @@ -2550,6 +2668,7 @@ static struct i2c_driver mxt_driver = {
>  		.name	= "atmel_mxt_ts",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = of_match_ptr(mxt_of_match),
> +		.acpi_match_table = ACPI_PTR(mxt_acpi_id),
>  		.pm	= &mxt_pm_ops,
>  	},
>  	.probe		= mxt_probe,
> 

Patch looks good to me and I've tested it in a Pixel2 Chromebook using
evtest:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
