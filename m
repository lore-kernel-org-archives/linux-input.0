From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Fri, 13 Oct 2017 18:02:21 +0200
Message-ID: <20171013180221.76b67869cf4eed7eeec3f56f@ao2.it>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ao2.it ([92.243.12.208]:58018 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbdJMQ2k (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 12:28:40 -0400
In-Reply-To: <20171012150443.27542-1-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Thu, 12 Oct 2017 17:04:42 +0200
Marcin Niestroj <m.niestroj@grinn-global.com> wrote:

> Support was added based on Goodix GitHub repo [1]. There are two major
> differences between gt1151 and currently supported devices (gt9x):
>  * CONFIG_DATA register has 0x8050 address instead of 0x8047,
>  * config data checksum has 16-bit width instead of 8-bit.
> 
> Also update goodix_i2c_test() function, so it reads ID register (which
> has the same address for all devices) instead of CONFIG_DATA (because
> its address is known only after reading ID of the device).
> 
> [1] https://github.com/goodix/gt1x_driver_generic
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Patch was developed and tested on top of 4.14-rc4 using custom board.
>

Just a suggestion, you could use a function pointer for the
device-specific checksum routines and have the check on the device id
only once in goodix_ts_probe(), see below.

>  .../bindings/input/touchscreen/goodix.txt          |  3 +-
>  drivers/input/touchscreen/goodix.c                 | 88 +++++++++++++++++-----
>  2 files changed, 70 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index c98757a69110..0c369d8ebcab 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -2,7 +2,8 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
>  
>  Required properties:
>  
> - - compatible		: Should be "goodix,gt911"
> + - compatible		: Should be "goodix,gt1151"
> +				 or "goodix,gt911"
>  				 or "goodix,gt9110"
>  				 or "goodix,gt912"
>  				 or "goodix,gt927"
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 32d2762448aa..9d50d9688975 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -41,6 +41,7 @@ struct goodix_ts_data {
>  	bool inverted_y;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	u16 reg_config_data;

Add a function pointer here.

>  	int cfg_len;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
> @@ -69,7 +70,8 @@ struct goodix_ts_data {
>  #define GOODIX_CMD_SCREEN_OFF		0x05
>  
>  #define GOODIX_READ_COOR_ADDR		0x814E
> -#define GOODIX_REG_CONFIG_DATA		0x8047
> +#define GOODIX_GT1X_REG_CONFIG_DATA	0x8050
> +#define GOODIX_GT9X_REG_CONFIG_DATA	0x8047
>  #define GOODIX_REG_ID			0x8140
>  
>  #define RESOLUTION_LOC		1
> @@ -193,6 +195,16 @@ static int goodix_get_cfg_len(u16 id)
>  	}
>  }
>  
> +static int goodix_get_reg_config_data(u16 id)
> +{
> +	switch (id) {
> +	case 1151:
> +		return GOODIX_GT1X_REG_CONFIG_DATA;
> +	default:
> +		return GOODIX_GT9X_REG_CONFIG_DATA;
> +	}
> +}
> +

This goodix_get_reg_config_data() is called only once, it could
go away if you assign ts->reg_config_data directly in the probe
function.

>  static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
>  {
>  	int touch_num;
> @@ -311,25 +323,12 @@ static int goodix_request_irq(struct goodix_ts_data *ts)
>  					 ts->irq_flags, ts->client->name, ts);
>  }
>  
> -/**
> - * goodix_check_cfg - Checks if config fw is valid
> - *
> - * @ts: goodix_ts_data pointer
> - * @cfg: firmware config data
> - */
> -static int goodix_check_cfg(struct goodix_ts_data *ts,
> -			    const struct firmware *cfg)
> +static int goodix_check_cfg_8(struct goodix_ts_data *ts,
> +			const struct firmware *cfg)
>  {
> -	int i, raw_cfg_len;
> +	int i, raw_cfg_len = cfg->size - 2;
>  	u8 check_sum = 0;
>  
> -	if (cfg->size > GOODIX_CONFIG_MAX_LENGTH) {
> -		dev_err(&ts->client->dev,
> -			"The length of the config fw is not correct");
> -		return -EINVAL;
> -	}
> -
> -	raw_cfg_len = cfg->size - 2;
>  	for (i = 0; i < raw_cfg_len; i++)
>  		check_sum += cfg->data[i];
>  	check_sum = (~check_sum) + 1;
> @@ -348,6 +347,53 @@ static int goodix_check_cfg(struct goodix_ts_data *ts,
>  	return 0;
>  }
>  
> +static int goodix_check_cfg_16(struct goodix_ts_data *ts,
> +			const struct firmware *cfg)
> +{
> +	int i, raw_cfg_len = cfg->size - 3;
> +	u16 check_sum = 0;
> +
> +	for (i = 0; i < raw_cfg_len; i += 2)
> +		check_sum += get_unaligned_be16(&cfg->data[i]);
> +	check_sum = (~check_sum) + 1;
> +	if (check_sum != get_unaligned_be16(&cfg->data[raw_cfg_len])) {
> +		dev_err(&ts->client->dev,
> +			"The checksum of the config fw is not correct");
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->data[raw_cfg_len + 2] != 1) {
> +		dev_err(&ts->client->dev,
> +			"Config fw must have Config_Fresh register set");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * goodix_check_cfg - Checks if config fw is valid
> + *
> + * @ts: goodix_ts_data pointer
> + * @cfg: firmware config data
> + */
> +static int goodix_check_cfg(struct goodix_ts_data *ts,
> +			    const struct firmware *cfg)
> +{
> +	if (cfg->size > GOODIX_CONFIG_MAX_LENGTH) {
> +		dev_err(&ts->client->dev,
> +			"The length of the config fw is not correct");
> +		return -EINVAL;
> +	}
> +
> +	switch (ts->id) {
> +	case 1151:
> +		return goodix_check_cfg_16(ts, cfg);
> +	default:
> +		return goodix_check_cfg_8(ts, cfg);
> +	}

call the function pointer here instead of having a switch.

> +}
> +
>  /**
>   * goodix_send_cfg - Write fw config to device
>   *
> @@ -363,7 +409,7 @@ static int goodix_send_cfg(struct goodix_ts_data *ts,
>  	if (error)
>  		return error;
>  
> -	error = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, cfg->data,
> +	error = goodix_i2c_write(ts->client, ts->reg_config_data, cfg->data,
>  				 cfg->size);
>  	if (error) {
>  		dev_err(&ts->client->dev, "Failed to write config data: %d",
> @@ -490,7 +536,7 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  	u8 config[GOODIX_CONFIG_MAX_LENGTH];
>  	int error;
>  
> -	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
> +	error = goodix_i2c_read(ts->client, ts->reg_config_data,
>  				config, ts->cfg_len);
>  	if (error) {
>  		dev_warn(&ts->client->dev,
> @@ -571,7 +617,7 @@ static int goodix_i2c_test(struct i2c_client *client)
>  	u8 test;
>  
>  	while (retry++ < 2) {
> -		error = goodix_i2c_read(client, GOODIX_REG_CONFIG_DATA,
> +		error = goodix_i2c_read(client, GOODIX_REG_ID,
>  					&test, 1);
>  		if (!error)
>  			return 0;
> @@ -741,6 +787,7 @@ static int goodix_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	ts->reg_config_data = goodix_get_reg_config_data(ts->id);

Add the switch only here and assign ts->reg_config_data and the
function pointer, depending on the device.

>  	ts->cfg_len = goodix_get_cfg_len(ts->id);
>  
>  	if (ts->gpiod_int && ts->gpiod_rst) {
> @@ -870,6 +917,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id goodix_of_match[] = {
> +	{ .compatible = "goodix,gt1151" },
>  	{ .compatible = "goodix,gt911" },
>  	{ .compatible = "goodix,gt9110" },
>  	{ .compatible = "goodix,gt912" },
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
