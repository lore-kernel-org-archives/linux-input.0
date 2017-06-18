From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/4] Input: icn8318 - Move of specific probe code to a
 helper function
Date: Sun, 18 Jun 2017 14:55:06 -0700
Message-ID: <20170618215506.GA40590@dtor-ws>
References: <20170618101829.18734-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35082 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbdFRVzJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 17:55:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so14033776pfs.2
        for <linux-input@vger.kernel.org>; Sun, 18 Jun 2017 14:55:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170618101829.18734-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi Hans,

On Sun, Jun 18, 2017 at 12:18:26PM +0200, Hans de Goede wrote:
> This is a preparation patch for adding support for ACPI enumerated
> Chipone touchscreens. On ACPI platforms the wake GPIO is unused, move
> the code to get the GPIO to a new icn8318_probe_of helper function.

It might be used later though. If we decide that wakeup gpio is optional
then let's switch to devm_gpiod_get_optional().

Thanks.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/touchscreen/chipone_icn8318.c | 50 ++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
> index 0bf14067c167..ddaae91f02fc 100644
> --- a/drivers/input/touchscreen/chipone_icn8318.c
> +++ b/drivers/input/touchscreen/chipone_icn8318.c
> @@ -137,7 +137,8 @@ static int icn8318_start(struct input_dev *dev)
>  	struct icn8318_data *data = input_get_drvdata(dev);
>  
>  	enable_irq(data->client->irq);
> -	gpiod_set_value_cansleep(data->wake_gpio, 1);
> +	if (data->wake_gpio)
> +		gpiod_set_value_cansleep(data->wake_gpio, 1);
>  
>  	return 0;
>  }
> @@ -149,7 +150,8 @@ static void icn8318_stop(struct input_dev *dev)
>  	disable_irq(data->client->irq);
>  	i2c_smbus_write_byte_data(data->client, ICN8318_REG_POWER,
>  				  ICN8318_POWER_HIBERNATE);
> -	gpiod_set_value_cansleep(data->wake_gpio, 0);
> +	if (data->wake_gpio)
> +		gpiod_set_value_cansleep(data->wake_gpio, 0);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -180,8 +182,29 @@ static int icn8318_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(icn8318_pm_ops, icn8318_suspend, icn8318_resume);
>  
> -static int icn8318_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +#ifdef CONFIG_OF
> +static int icn8318_probe_of(struct icn8318_data *data, struct device *dev)
> +{
> +	int error;
> +
> +	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->wake_gpio)) {
> +		error = PTR_ERR(data->wake_gpio);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Error getting wake gpio: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int icn8318_probe_of(struct icn8318_data *data, struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +static int icn8318_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct icn8318_data *data;
> @@ -197,18 +220,13 @@ static int icn8318_probe(struct i2c_client *client,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
> -	if (IS_ERR(data->wake_gpio)) {
> -		error = PTR_ERR(data->wake_gpio);
> -		if (error != -EPROBE_DEFER)
> -			dev_err(dev, "Error getting wake gpio: %d\n", error);
> -		return error;
> -	}
> -
>  	input = devm_input_allocate_device(dev);
>  	if (!input)
>  		return -ENOMEM;
>  
> +	data->client = client;
> +	data->input = input;
> +
>  	input->name = client->name;
>  	input->id.bustype = BUS_I2C;
>  	input->open = icn8318_start;
> @@ -218,6 +236,10 @@ static int icn8318_probe(struct i2c_client *client,
>  	input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
>  	input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
>  
> +	error = icn8318_probe_of(data, dev);
> +	if (error)
> +		return error;
> +
>  	touchscreen_parse_properties(input, true, &data->prop);
>  	if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
>  	    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
> @@ -230,8 +252,6 @@ static int icn8318_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> -	data->client = client;
> -	data->input = input;
>  	input_set_drvdata(input, data);
>  
>  	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq,
> @@ -271,7 +291,7 @@ static struct i2c_driver icn8318_driver = {
>  		.pm	= &icn8318_pm_ops,
>  		.of_match_table = icn8318_of_match,
>  	},
> -	.probe = icn8318_probe,
> +	.probe_new = icn8318_probe,
>  	.id_table = icn8318_i2c_id,
>  };
>  
> -- 
> 2.13.0
> 

-- 
Dmitry
