From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] max7359_keypad: remove code duplication
Date: Fri, 15 May 2015 13:52:59 -0700
Message-ID: <20150515205259.GF696@dtor-ws>
References: <20150514023628.GB28560@fifteen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514023628.GB28560@fifteen>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 14, 2015 at 05:36:28AM +0300, Evgeniy Dushistov wrote:
> max7359_keypad: remove code duplication,
>  max7359_build_keycode do the same thing as matrix_keypad_build_keymap, but
>  matrix_keypad_build_keymap can also handle DT bindings, so remove
>  max7359_build_keycode and use matrix_keypad_build_keymap instead. Tested on
>  beagleboard-xm.
> 
> Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig          |  1 +
>  drivers/input/keyboard/max7359_keypad.c | 30 +++++++++---------------------
>  2 files changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 106fbac..4d75062 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -367,6 +367,7 @@ config KEYBOARD_MAPLE
>  
>  config KEYBOARD_MAX7359
>  	tristate "Maxim MAX7359 Key Switch Controller"
> +	select INPUT_MATRIXKMAP
>  	depends on I2C
>  	help
>  	  If you say yes here you get support for the Maxim MAX7359 Key
> diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
> index 4e35904..5091133 100644
> --- a/drivers/input/keyboard/max7359_keypad.c
> +++ b/drivers/input/keyboard/max7359_keypad.c
> @@ -84,26 +84,6 @@ static int max7359_read_reg(struct i2c_client *client, int reg)
>  	return ret;
>  }
>  
> -static void max7359_build_keycode(struct max7359_keypad *keypad,
> -				const struct matrix_keymap_data *keymap_data)
> -{
> -	struct input_dev *input_dev = keypad->input_dev;
> -	int i;
> -
> -	for (i = 0; i < keymap_data->keymap_size; i++) {
> -		unsigned int key = keymap_data->keymap[i];
> -		unsigned int row = KEY_ROW(key);
> -		unsigned int col = KEY_COL(key);
> -		unsigned int scancode = MATRIX_SCAN_CODE(row, col,
> -						MAX7359_ROW_SHIFT);
> -		unsigned short keycode = KEY_VAL(key);
> -
> -		keypad->keycodes[scancode] = keycode;
> -		__set_bit(keycode, input_dev->keybit);
> -	}
> -	__clear_bit(KEY_RESERVED, input_dev->keybit);
> -}
> -
>  /* runs in an IRQ thread -- can (and will!) sleep */
>  static irqreturn_t max7359_interrupt(int irq, void *dev_id)
>  {
> @@ -232,7 +212,15 @@ static int max7359_probe(struct i2c_client *client,
>  	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
>  	input_set_drvdata(input_dev, keypad);
>  
> -	max7359_build_keycode(keypad, keymap_data);
> +	error = matrix_keypad_build_keymap(keymap_data, NULL,
> +					   MAX7359_MAX_KEY_ROWS,
> +					   MAX7359_MAX_KEY_COLS,
> +					   keypad->keycodes,
> +					   input_dev);
> +	if (error) {
> +		dev_err(&client->dev, "failed to build keymap\n");
> +		return error;
> +	}
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>  					  max7359_interrupt,
> -- 
> 2.3.6
> 
> -- 
> /Evgeniy

-- 
Dmitry
