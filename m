From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 5/5] Input: tca8418-keypad - switch to use managed
 resources
Date: Thu, 29 Nov 2012 14:51:01 +0100
Message-ID: <20121129145101.5ea779e4@avionic-0020.adnet.avionic-design.de>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
	<1352911688-5001-5-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56411 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2K2NvE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 08:51:04 -0500
In-Reply-To: <1352911688-5001-5-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 14 Nov 2012 08:48:08 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Let's switch to using devm_*() interfaces to manage our resources, thus will
> simplify error unwinding a bit.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Alban Bedel <alban.bedel@avionic-design.de>

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 78 +++++++++++----------------------
>  1 file changed, 25 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 10047eb..f9a13c9 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -111,14 +111,10 @@
>  #define KEY_EVENT_VALUE		0x80
>  
>  struct tca8418_keypad {
> -	unsigned int irq;
> -	unsigned int row_shift;
> -
>  	struct i2c_client *client;
>  	struct input_dev *input;
>  
> -	/* Flexible array member, must be at end of struct */
> -	unsigned short keymap[];
> +	unsigned int row_shift;
>  };
>  
>  /*
> @@ -163,6 +159,8 @@ static int tca8418_read_byte(struct tca8418_keypad *keypad_data,
>  
>  static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
>  {
> +	struct input_dev *input = keypad_data->input;
> +	unsigned short *keymap = input->keycode;
>  	int error, col, row;
>  	u8 reg, state, code;
>  
> @@ -181,9 +179,8 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
>  		col = (col) ? col - 1 : TCA8418_MAX_COLS - 1;
>  
>  		code = MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
> -		input_event(keypad_data->input, EV_MSC, MSC_SCAN, code);
> -		input_report_key(keypad_data->input,
> -				keypad_data->keymap[code], state);
> +		input_event(input, EV_MSC, MSC_SCAN, code);
> +		input_report_key(input, keymap[code], state);
>  
>  		/* Read for next loop */
>  		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
> @@ -193,7 +190,7 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
>  		dev_err(&keypad_data->client->dev,
>  			"unable to read REG_KEY_EVENT_A\n");
>  
> -	input_sync(keypad_data->input);
> +	input_sync(input);
>  }
>  
>  /*
> @@ -275,6 +272,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  	u32 rows = 0, cols = 0;
>  	bool rep = false;
>  	bool irq_is_gpio = false;
> +	int irq;
>  	int error, row_shift, max_keys;
>  
>  	/* Copy the platform data */
> @@ -315,9 +313,8 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  	row_shift = get_count_order(cols);
>  	max_keys = rows << row_shift;
>  
> -	/* Allocate memory for keypad_data, keymap and input device */
> -	keypad_data = kzalloc(sizeof(*keypad_data) +
> -			max_keys * sizeof(keypad_data->keymap[0]), GFP_KERNEL);
> +	/* Allocate memory for keypad_data and input device */
> +	keypad_data = devm_kzalloc(dev, sizeof(*keypad_data), GFP_KERNEL);
>  	if (!keypad_data)
>  		return -ENOMEM;
>  
> @@ -327,29 +324,26 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  	/* Initialize the chip or fail if chip isn't present */
>  	error = tca8418_configure(keypad_data, rows, cols);
>  	if (error < 0)
> -		goto fail1;
> +		return error;
>  
>  	/* Configure input device */
> -	input = input_allocate_device();
> -	if (!input) {
> -		error = -ENOMEM;
> -		goto fail1;
> -	}
> +	input = devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;
> +
>  	keypad_data->input = input;
>  
>  	input->name = client->name;
> -	input->dev.parent = &client->dev;
> -
>  	input->id.bustype = BUS_I2C;
>  	input->id.vendor  = 0x0001;
>  	input->id.product = 0x001;
>  	input->id.version = 0x0001;
>  
>  	error = matrix_keypad_build_keymap(keymap_data, NULL, rows, cols,
> -					   keypad_data->keymap, input);
> +					   NULL, input);
>  	if (error) {
>  		dev_err(dev, "Failed to build keymap\n");
> -		goto fail2;
> +		return error;
>  	}
>  
>  	if (rep)
> @@ -358,49 +352,28 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  
>  	input_set_drvdata(input, keypad_data);
>  
> +	irq = client->irq;
>  	if (irq_is_gpio)
> -		client->irq = gpio_to_irq(client->irq);
> +		irq = gpio_to_irq(irq);
>  
> -	error = request_threaded_irq(client->irq, NULL, tca8418_irq_handler,
> -				     IRQF_TRIGGER_FALLING |
> -				     IRQF_SHARED |
> -				     IRQF_ONESHOT,
> -				     client->name, keypad_data);
> +	error = devm_request_threaded_irq(dev, irq, NULL, tca8418_irq_handler,
> +					  IRQF_TRIGGER_FALLING |
> +						IRQF_SHARED |
> +						IRQF_ONESHOT,
> +					  client->name, keypad_data);
>  	if (error) {
>  		dev_err(dev, "Unable to claim irq %d; error %d\n",
>  			client->irq, error);
> -		goto fail2;
> +		return error;
>  	}
>  
>  	error = input_register_device(input);
>  	if (error) {
>  		dev_err(dev, "Unable to register input device, error: %d\n",
>  			error);
> -		goto fail3;
> +		return error;
>  	}
>  
> -	i2c_set_clientdata(client, keypad_data);
> -	return 0;
> -
> -fail3:
> -	free_irq(client->irq, keypad_data);
> -fail2:
> -	input_free_device(input);
> -fail1:
> -	kfree(keypad_data);
> -	return error;
> -}
> -
> -static int __devexit tca8418_keypad_remove(struct i2c_client *client)
> -{
> -	struct tca8418_keypad *keypad_data = i2c_get_clientdata(client);
> -
> -	free_irq(keypad_data->client->irq, keypad_data);
> -
> -	input_unregister_device(keypad_data->input);
> -
> -	kfree(keypad_data);
> -
>  	return 0;
>  }
>  
> @@ -425,7 +398,6 @@ static struct i2c_driver tca8418_keypad_driver = {
>  		.of_match_table = of_match_ptr(tca8418_dt_ids),
>  	},
>  	.probe		= tca8418_keypad_probe,
> -	.remove		= __devexit_p(tca8418_keypad_remove),
>  	.id_table	= tca8418_id,
>  };
>  

