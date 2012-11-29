From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 1/5] Input: tca8418_keypad - use a temporary variable
 for parent device
Date: Thu, 29 Nov 2012 14:47:47 +0100
Message-ID: <20121129144747.3beece83@avionic-0020.adnet.avionic-design.de>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49547 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab2K2Nrv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 08:47:51 -0500
In-Reply-To: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 14 Nov 2012 08:48:04 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Use a temporary variable for our parent device (coming from I2C client
> structure); we'll be also using it during conversion to managed resources.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Alban Bedel <alban.bedel@avionic-design.de>

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 65cf5fa..4618ce0 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -281,6 +281,7 @@ static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data,
>  static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  					  const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;
>  	const struct tca8418_keypad_platform_data *pdata =
>  						client->dev.platform_data;
>  	struct tca8418_keypad *keypad_data;
> @@ -294,7 +295,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  	/* Copy the platform data */
>  	if (pdata) {
>  		if (!pdata->keymap_data) {
> -			dev_err(&client->dev, "no keymap data defined\n");
> +			dev_err(dev, "no keymap data defined\n");
>  			return -EINVAL;
>  		}
>  		keymap_data = pdata->keymap_data;
> @@ -303,25 +304,25 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  		rep  = pdata->rep;
>  		irq_is_gpio = pdata->irq_is_gpio;
>  	} else {
> -		struct device_node *np = client->dev.of_node;
> +		struct device_node *np = dev->of_node;
>  		of_property_read_u32(np, "keypad,num-rows", &rows);
>  		of_property_read_u32(np, "keypad,num-columns", &cols);
>  		rep = of_property_read_bool(np, "keypad,autorepeat");
>  	}
>  
>  	if (!rows || rows > TCA8418_MAX_ROWS) {
> -		dev_err(&client->dev, "invalid rows\n");
> +		dev_err(dev, "invalid rows\n");
>  		return -EINVAL;
>  	}
>  
>  	if (!cols || cols > TCA8418_MAX_COLS) {
> -		dev_err(&client->dev, "invalid columns\n");
> +		dev_err(dev, "invalid columns\n");
>  		return -EINVAL;
>  	}
>  
>  	/* Check i2c driver capabilities */
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
> -		dev_err(&client->dev, "%s adapter not supported\n",
> +		dev_err(dev, "%s adapter not supported\n",
>  			dev_driver_string(&client->adapter->dev));
>  		return -ENODEV;
>  	}
> @@ -362,7 +363,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  	error = matrix_keypad_build_keymap(keymap_data, NULL, rows, cols,
>  					   keypad_data->keymap, input);
>  	if (error) {
> -		dev_dbg(&client->dev, "Failed to build keymap\n");
> +		dev_dbg(dev, "Failed to build keymap\n");
>  		goto fail2;
>  	}
>  
> @@ -381,16 +382,15 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  				     IRQF_ONESHOT,
>  				     client->name, keypad_data);
>  	if (error) {
> -		dev_dbg(&client->dev,
> -			"Unable to claim irq %d; error %d\n",
> +		dev_dbg(dev, "Unable to claim irq %d; error %d\n",
>  			client->irq, error);
>  		goto fail2;
>  	}
>  
>  	error = input_register_device(input);
>  	if (error) {
> -		dev_dbg(&client->dev,
> -			"Unable to register input device, error: %d\n", error);
> +		dev_dbg(dev, "Unable to register input device, error: %d\n",
> +			error);
>  		goto fail3;
>  	}
>  

