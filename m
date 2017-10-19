From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca8418 - enable interrupt after it has been
 requested
Date: Thu, 19 Oct 2017 15:38:37 -0700
Message-ID: <20171019223837.m2ula6wocxhrjvnp@dtor-ws>
References: <20171016215714.3878-1-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:47935 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdJSWil (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Oct 2017 18:38:41 -0400
Content-Disposition: inline
In-Reply-To: <20171016215714.3878-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>, kernel@savoirfairelinux.com

On Mon, Oct 16, 2017 at 05:57:14PM -0400, Damien Riegel wrote:
> Currently, enabling keypad interrupts is one of the first operations
> done on the keypad, even before the interrupt is requested, so there is
> a small time window where the keypad can fire interrupts but the driver
> is not yet ready to handle them. It's fine for level interrupts because
> they will be handled anyway, but not so much for edge ones.
> 
> This commit modifies and moves the function in charge of configuring the
> keypad. Enabling interrupts is now the last thing done on the keypad,
> and after the interrupt has been requested by the driver.
> 
> Writing to the config register was also used to determine if the device
> was indeed present on the bus or not, this has been replaced by reading
> the lock/event count register to keep the same functionality.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Applied, thank you.

> ---
> I originally made this patch on top of:
> 
>     800e3b9a6801 Input: drop owner assignment from i2c_driver
> 
> But I only compile-tested it on top of input/next. The issue was spotted
> thanks to a bootloader that left the keypad configured, only with
> interrupts disabled. So any button pressed or released during Linux's
> boot was queued and triggered an interrupt as soon as the driver enabled
> interrupts. It would really be appreciated if someone could give this
> patch a try.
> 
>  drivers/input/keyboard/tca8418_keypad.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index e37e335e406f..6da607d3b811 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -234,14 +234,7 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
>  static int tca8418_configure(struct tca8418_keypad *keypad_data,
>  			     u32 rows, u32 cols)
>  {
> -	int reg, error;
> -
> -	/* Write config register, if this fails assume device not present */
> -	error = tca8418_write_byte(keypad_data, REG_CFG,
> -				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_KE_IEN);
> -	if (error < 0)
> -		return -ENODEV;
> -
> +	int reg, error = 0;
>  
>  	/* Assemble a mask for row and column registers */
>  	reg  =  ~(~0 << rows);
> @@ -257,6 +250,12 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
>  	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS2, reg >> 8);
>  	error |= tca8418_write_byte(keypad_data, REG_DEBOUNCE_DIS3, reg >> 16);
>  
> +	if (error)
> +		return error;
> +
> +	error = tca8418_write_byte(keypad_data, REG_CFG,
> +				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_KE_IEN);
> +
>  	return error;
>  }
>  
> @@ -268,6 +267,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
>  	struct input_dev *input;
>  	u32 rows = 0, cols = 0;
>  	int error, row_shift, max_keys;
> +	u8 reg;
>  
>  	/* Check i2c driver capabilities */
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
> @@ -301,10 +301,10 @@ static int tca8418_keypad_probe(struct i2c_client *client,
>  	keypad_data->client = client;
>  	keypad_data->row_shift = row_shift;
>  
> -	/* Initialize the chip or fail if chip isn't present */
> -	error = tca8418_configure(keypad_data, rows, cols);
> -	if (error < 0)
> -		return error;
> +	/* Read key lock register, if this fails assume device not present */
> +	error = tca8418_read_byte(keypad_data, REG_KEY_LCK_EC, &reg);
> +	if (error)
> +		return -ENODEV;
>  
>  	/* Configure input device */
>  	input = devm_input_allocate_device(dev);
> @@ -340,6 +340,11 @@ static int tca8418_keypad_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	/* Initialize the chip */
> +	error = tca8418_configure(keypad_data, rows, cols);
> +	if (error < 0)
> +		return error;
> +
>  	error = input_register_device(input);
>  	if (error) {
>  		dev_err(dev, "Unable to register input device, error: %d\n",
> -- 
> 2.14.2
> 

-- 
Dmitry
