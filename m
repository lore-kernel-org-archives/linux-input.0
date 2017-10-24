From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Input: goodix - support gt1151 touchpanel
Date: Tue, 24 Oct 2017 11:07:40 -0700
Message-ID: <20171024180740.ozcyvsk5zji3hpcn@dtor-ws>
References: <20171024091305.16411-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171024091305.16411-1-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Antonio Ospite <ao2-qKGr9MkilAE@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 24, 2017 at 11:13:05AM +0200, Marcin Niestroj wrote:
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
> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applied, thank you.

> ---
> Changes v1 -> v2:
>  * Use constant chip data, which is assigned during probe, based on
>    read chip id (suggested by Dmitry)
>  * Use function pointer for checsum verification
>    (suggested by Antonio)
> 
>  .../bindings/input/touchscreen/goodix.txt          |   3 +-
>  drivers/input/touchscreen/goodix.c                 | 125 ++++++++++++++++-----
>  2 files changed, 100 insertions(+), 28 deletions(-)
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
> index b3bbad7d2282..69d0b8cbc71f 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -31,9 +31,18 @@
>  #include <linux/of.h>
>  #include <asm/unaligned.h>
>  
> +struct goodix_ts_data;
> +
> +struct goodix_chip_data {
> +	u16 config_addr;
> +	int config_len;
> +	int (*check_config)(struct goodix_ts_data *, const struct firmware *);
> +};
> +
>  struct goodix_ts_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
> +	const struct goodix_chip_data *chip;
>  	int abs_x_max;
>  	int abs_y_max;
>  	bool swapped_x_y;
> @@ -41,7 +50,6 @@ struct goodix_ts_data {
>  	bool inverted_y;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> -	int cfg_len;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -69,7 +77,8 @@ struct goodix_ts_data {
>  #define GOODIX_CMD_SCREEN_OFF		0x05
>  
>  #define GOODIX_READ_COOR_ADDR		0x814E
> -#define GOODIX_REG_CONFIG_DATA		0x8047
> +#define GOODIX_GT1X_REG_CONFIG_DATA	0x8050
> +#define GOODIX_GT9X_REG_CONFIG_DATA	0x8047
>  #define GOODIX_REG_ID			0x8140
>  
>  #define GOODIX_BUFFER_STATUS_READY	BIT(7)
> @@ -79,6 +88,35 @@ struct goodix_ts_data {
>  #define MAX_CONTACTS_LOC	5
>  #define TRIGGER_LOC		6
>  
> +static int goodix_check_cfg_8(struct goodix_ts_data *ts,
> +			const struct firmware *cfg);
> +static int goodix_check_cfg_16(struct goodix_ts_data *ts,
> +			const struct firmware *cfg);
> +
> +static const struct goodix_chip_data gt1x_chip_data = {
> +	.config_addr		= GOODIX_GT1X_REG_CONFIG_DATA,
> +	.config_len		= GOODIX_CONFIG_MAX_LENGTH,
> +	.check_config		= goodix_check_cfg_16,
> +};
> +
> +static const struct goodix_chip_data gt911_chip_data = {
> +	.config_addr		= GOODIX_GT9X_REG_CONFIG_DATA,
> +	.config_len		= GOODIX_CONFIG_911_LENGTH,
> +	.check_config		= goodix_check_cfg_8,
> +};
> +
> +static const struct goodix_chip_data gt967_chip_data = {
> +	.config_addr		= GOODIX_GT9X_REG_CONFIG_DATA,
> +	.config_len		= GOODIX_CONFIG_967_LENGTH,
> +	.check_config		= goodix_check_cfg_8,
> +};
> +
> +static const struct goodix_chip_data gt9x_chip_data = {
> +	.config_addr		= GOODIX_GT9X_REG_CONFIG_DATA,
> +	.config_len		= GOODIX_CONFIG_MAX_LENGTH,
> +	.check_config		= goodix_check_cfg_8,
> +};
> +
>  static const unsigned long goodix_irq_flags[] = {
>  	IRQ_TYPE_EDGE_RISING,
>  	IRQ_TYPE_EDGE_FALLING,
> @@ -177,22 +215,25 @@ static int goodix_i2c_write_u8(struct i2c_client *client, u16 reg, u8 value)
>  	return goodix_i2c_write(client, reg, &value, sizeof(value));
>  }
>  
> -static int goodix_get_cfg_len(u16 id)
> +static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
>  {
>  	switch (id) {
> +	case 1151:
> +		return &gt1x_chip_data;
> +
>  	case 911:
>  	case 9271:
>  	case 9110:
>  	case 927:
>  	case 928:
> -		return GOODIX_CONFIG_911_LENGTH;
> +		return &gt911_chip_data;
>  
>  	case 912:
>  	case 967:
> -		return GOODIX_CONFIG_967_LENGTH;
> +		return &gt967_chip_data;
>  
>  	default:
> -		return GOODIX_CONFIG_MAX_LENGTH;
> +		return &gt9x_chip_data;
>  	}
>  }
>  
> @@ -332,25 +373,12 @@ static int goodix_request_irq(struct goodix_ts_data *ts)
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
> @@ -369,6 +397,48 @@ static int goodix_check_cfg(struct goodix_ts_data *ts,
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
> +	return ts->chip->check_config(ts, cfg);
> +}
> +
>  /**
>   * goodix_send_cfg - Write fw config to device
>   *
> @@ -384,7 +454,7 @@ static int goodix_send_cfg(struct goodix_ts_data *ts,
>  	if (error)
>  		return error;
>  
> -	error = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, cfg->data,
> +	error = goodix_i2c_write(ts->client, ts->chip->config_addr, cfg->data,
>  				 cfg->size);
>  	if (error) {
>  		dev_err(&ts->client->dev, "Failed to write config data: %d",
> @@ -511,8 +581,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  	u8 config[GOODIX_CONFIG_MAX_LENGTH];
>  	int error;
>  
> -	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
> -				config, ts->cfg_len);
> +	error = goodix_i2c_read(ts->client, ts->chip->config_addr,
> +				config, ts->chip->config_len);
>  	if (error) {
>  		dev_warn(&ts->client->dev,
>  			 "Error reading config (%d), using defaults\n",
> @@ -592,7 +662,7 @@ static int goodix_i2c_test(struct i2c_client *client)
>  	u8 test;
>  
>  	while (retry++ < 2) {
> -		error = goodix_i2c_read(client, GOODIX_REG_CONFIG_DATA,
> +		error = goodix_i2c_read(client, GOODIX_REG_ID,
>  					&test, 1);
>  		if (!error)
>  			return 0;
> @@ -762,7 +832,7 @@ static int goodix_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	ts->cfg_len = goodix_get_cfg_len(ts->id);
> +	ts->chip = goodix_get_chip_data(ts->id);
>  
>  	if (ts->gpiod_int && ts->gpiod_rst) {
>  		/* update device config */
> @@ -891,6 +961,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
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

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
