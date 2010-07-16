From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Input: ADP5588 - Support gpio function on unused
 pin
Date: Fri, 16 Jul 2010 09:20:18 -0700
Message-ID: <20100716162017.GA9232@core.coreip.homeip.net>
References: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
 <AANLkTimbg9yhPvR8vya2dN4MIOF0JxyKbOrpQ_T0R_T3@mail.gmail.com>
 <544AC56F16B56944AEC3BD4E3D5917712E7EA5A357@LIMKCMBX1.ad.analog.com>
 <AANLkTimCA8gNc6aQW46ESbSbqxT6UGoqbT5PWC3vwkBc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38253 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965945Ab0GPQU1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 12:20:27 -0400
Received: by pzk26 with SMTP id 26so688116pzk.19
        for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 09:20:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimCA8gNc6aQW46ESbSbqxT6UGoqbT5PWC3vwkBc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolong CHEN <a21785@motorola.com>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>, david-b@pacbell.net, Xiaolong CHEN <xiao-long.chen@motorola.com>, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi Xiaolong,

On Fri, Jul 16, 2010 at 07:48:07PM +0800, Xiaolong CHEN wrote:
> Hi, Michael,
> 
> Thanks for your comments, I agree with you, it's a better way to
> export only the spare pins as GPIO.
> I update this patch, any comments and suggestion, feel free let me know.
> 

Looks nice, a few comments though.

> Patch:
> 
> From 027a344b0fc49f87edd325d5896c3d0985ec5869 Mon Sep 17 00:00:00 2001
> From: Xiaolong Chen <a21785@motorola.com>
> Date: Sat, 17 Jul 2010 03:18:28 +0800
> Subject: [PATCH] Input: ADP5588 - Support gpio function on unused pin
> 
> This implements an optional gpio function on unused pin by adp5588
> kpad.
> 
> adp5588_kpad_platform_data has been extended with support_gpio,
> support gpio function if it equals 1, and gpio_start, the gpio chip
> base for this module.

Why do we do this conditionally? Is there a reason why exporting unused
gpio pins would be unwelcome?

> 
> Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
> Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
> Signed-off-by: Tao Hu <taohu@motorola.com>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/input/keyboard/adp5588-keys.c |  144 +++++++++++++++++++++++++++++++++
>  include/linux/i2c/adp5588.h           |    2 +
>  2 files changed, 146 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index 3c8876a..ed18c93 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/input.h>
>  #include <linux/i2c.h>
> +#include <linux/gpio.h>
> 
>  #include <linux/i2c/adp5588.h>
> 
> @@ -52,6 +53,10 @@
> 
>  #define KEYP_MAX_EVENT		10
> 
> +#define MAXGPIO			18
> +#define ADP_BANK(offs)		((offs) >> 3)
> +#define ADP_BIT(offs)		(1u << ((offs) & 0x7))
> +
>  /*
>   * Early pre 4.0 Silicon required to delay readout by at least 25ms,
>   * since the Event Counter Register updated 25ms after the interrupt
> @@ -67,6 +72,12 @@ struct adp5588_kpad {
>  	unsigned short keycode[ADP5588_KEYMAPSIZE];
>  	const struct adp5588_gpi_map *gpimap;
>  	unsigned short gpimapsize;
> +	unsigned char gpiomap[MAXGPIO];
> +	unsigned support_gpio;
> +	struct gpio_chip gpio_chip;
> +	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
> +	uint8_t dat_out[3];
> +	uint8_t dir[3];
>  };
> 
>  static int adp5588_read(struct i2c_client *client, u8 reg)
> @@ -84,6 +95,85 @@ static int adp5588_write(struct i2c_client *client,
> u8 reg, u8 val)
>  	return i2c_smbus_write_byte_data(client, reg, val);
>  }
> 
> +static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
> +{
> +	unsigned bank, bit;
> +	struct adp5588_kpad *dev =
> +	    container_of(chip, struct adp5588_kpad, gpio_chip);

Throughout the driver we normally name struct adp5588_kpad variables as
kpad, not dev. In fact, when I see dev I think "driver model
abstraction" and not "this particular hardware". Care to rename to kpad
here (and below) as well?

> +
> +	bank = ADP_BANK(dev->gpiomap[off]);
> +	bit = ADP_BIT(dev->gpiomap[off]);
> +
> +	return !!(adp5588_read(dev->client, GPIO_DAT_STAT1 + bank) & bit);
> +}
> +
> +static void adp5588_gpio_set_value(struct gpio_chip *chip,
> +				   unsigned off, int val)
> +{
> +	unsigned bank, bit;
> +	struct adp5588_kpad *dev =
> +	    container_of(chip, struct adp5588_kpad, gpio_chip);
> +
> +	bank = ADP_BANK(dev->gpiomap[off]);
> +	bit = ADP_BIT(dev->gpiomap[off]);
> +
> +	mutex_lock(&dev->gpio_lock);
> +	if (val)
> +		dev->dat_out[bank] |= bit;
> +	else
> +		dev->dat_out[bank] &= ~bit;
> +
> +	adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
> +			   dev->dat_out[bank]);
> +	mutex_unlock(&dev->gpio_lock);
> +}
> +
> +static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsigned off)
> +{
> +	int ret;
> +	unsigned bank, bit;
> +	struct adp5588_kpad *dev =
> +	    container_of(chip, struct adp5588_kpad, gpio_chip);
> +
> +	bank = ADP_BANK(dev->gpiomap[off]);
> +	bit = ADP_BIT(dev->gpiomap[off]);
> +
> +	mutex_lock(&dev->gpio_lock);
> +	dev->dir[bank] &= ~bit;
> +	ret = adp5588_write(dev->client, GPIO_DIR1 + bank, dev->dir[bank]);
> +	mutex_unlock(&dev->gpio_lock);
> +
> +	return ret;
> +}
> +
> +static int adp5588_gpio_direction_output(struct gpio_chip *chip,
> +					 unsigned off, int val)
> +{
> +	int ret;
> +	unsigned bank, bit;
> +	struct adp5588_kpad *dev =
> +	    container_of(chip, struct adp5588_kpad, gpio_chip);
> +
> +	bank = ADP_BANK(dev->gpiomap[off]);
> +	bit = ADP_BIT(dev->gpiomap[off]);
> +
> +	mutex_lock(&dev->gpio_lock);
> +	dev->dir[bank] |= bit;
> +
> +	if (val)
> +		dev->dat_out[bank] |= bit;
> +	else
> +		dev->dat_out[bank] &= ~bit;
> +
> +	ret = adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
> +				 dev->dat_out[bank]);
> +	ret |= adp5588_write(dev->client, GPIO_DIR1 + bank,
> +				 dev->dir[bank]);
> +	mutex_unlock(&dev->gpio_lock);
> +
> +	return ret;
> +}
> +
>  static void adp5588_work(struct work_struct *work)
>  {
>  	struct adp5588_kpad *kpad = container_of(work,
> @@ -204,6 +294,7 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,

Looks like your e-mail miight be line-wrapped...

>  	int ret, i;
>  	int error;
>  	int gpi_stat1 = 0, gpi_stat2 = 0, gpi_stat3 = 0;
> +	struct gpio_chip *gc;
> 
>  	if (!i2c_check_functionality(client->adapter,
>  					I2C_FUNC_SMBUS_BYTE_DATA)) {
> @@ -273,6 +364,24 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
>  	kpad->input = input;
>  	INIT_DELAYED_WORK(&kpad->work, adp5588_work);
> 
> +	kpad->support_gpio = pdata->support_gpio;
> +
> +	if (kpad->support_gpio) {
> +		gc = &kpad->gpio_chip;
> +		gc->direction_input = adp5588_gpio_direction_input;
> +		gc->direction_output = adp5588_gpio_direction_output;
> +		gc->get = adp5588_gpio_get_value;
> +		gc->set = adp5588_gpio_set_value;
> +		gc->can_sleep = 1;
> +
> +		gc->base = pdata->gpio_start;
> +		gc->ngpio = MAXGPIO;
> +		gc->label = client->name;
> +		gc->owner = THIS_MODULE;
> +
> +		mutex_init(&kpad->gpio_lock);
> +	}
> +
>  	ret = adp5588_read(client, DEV_ID);
>  	if (ret < 0) {
>  		error = ret;
> @@ -340,6 +449,38 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
>  	device_init_wakeup(&client->dev, 1);
>  	i2c_set_clientdata(client, kpad);
> 
> +	if (kpad->support_gpio) {
> +		int j = 0;
> +		unsigned char pin_used[MAXGPIO];

Make it bool (now that we have it)  and use boolean values below.

> +
> +		for (i = 0; i < pdata->rows; i++)
> +			pin_used[i] = 1;
> +
> +		for (i = 0; i < pdata->cols; i++)
> +			pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = 1;
> +
> +		for (i = 0; i < kpad->gpimapsize; i++)
> +			pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = 1;
> +
> +		for (i = 0; i < MAXGPIO; i++) {
> +			if (!pin_used[i])
> +				kpad->gpiomap[j++] = i;
> +		}
> +		kpad->gpio_chip.ngpio = j;
> +

What happens if we end up with ngpio == 0?

> +		ret = gpiochip_add(&kpad->gpio_chip);
> +		if (ret) {
> +			dev_err(&client->dev, "gpiochip_add err: %d\n", ret);
> +			goto err_free_irq;
> +		}
> +
> +		for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
> +			kpad->dat_out[i] = adp5588_read(client,
> +						GPIO_DAT_OUT1 + i);
> +			kpad->dir[i] = adp5588_read(client, GPIO_DIR1 + i);
> +		}
> +	}
> +
>  	if (kpad->gpimapsize) {
>  		gpi_stat1 = adp5588_read(client, GPIO_DAT_STAT1);
>  		gpi_stat2 = adp5588_read(client, GPIO_DAT_STAT2);
> @@ -389,12 +530,15 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> 
>  static int __devexit adp5588_remove(struct i2c_client *client)
>  {
> +	int ret;
>  	struct adp5588_kpad *kpad = i2c_get_clientdata(client);
> 
>  	adp5588_write(client, CFG, 0);
>  	free_irq(client->irq, kpad);
>  	cancel_delayed_work_sync(&kpad->work);
>  	input_unregister_device(kpad->input);
> +	if (kpad->support_gpio)
> +		ret = gpiochip_remove(&kpad->gpio_chip);
>  	i2c_set_clientdata(client, NULL);
>  	kfree(kpad);
> 
> diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
> index a00686c..35078c3 100644
> --- a/include/linux/i2c/adp5588.h
> +++ b/include/linux/i2c/adp5588.h
> @@ -123,6 +123,8 @@ struct adp5588_kpad_platform_data {
>  	unsigned short unlock_key2;	/* Unlock Key 2 */
>  	const struct adp5588_gpi_map *gpimap;
>  	unsigned short gpimapsize;
> +	unsigned support_gpio:1;	/* Support gpio on unused pin */

Bool here as well. In theory bools might cause to waste a byte or 2 but
it's ok (and in this case you are not saving anything...).

Thanks.

-- 
Dmitry
