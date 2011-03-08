From: Mohan Pallaka <mohan1234@gmail.com>
Subject: Re: Add driver for Atmel AT42QT1070 driver
Date: Tue, 08 Mar 2011 23:08:50 +0530
Message-ID: <4D7669AA.7080209@gmail.com>
References: <1299575978-16134-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64258 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab1CHRjA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 12:39:00 -0500
Received: by pxi15 with SMTP id 15so914095pxi.19
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2011 09:38:59 -0800 (PST)
In-Reply-To: <1299575978-16134-1-git-send-email-voice.shen@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: voice <voice.shen@atmel.com>
Cc: linux-input@vger.kernel.org, jm.lin@atmel.com

Please find my review comments inline,

On 3/8/2011 2:49 PM, voice wrote:
> Add driver for Atmel AT42QT1070 QTouch sensor chip.
> The AT42QT1070 QTouch sensor support up to 7 keys.
> The driver has been tested on Atmel AT91SAM9M10-G45-EK board, it should work fine on other platform.
>
> Signed-off-by: Shen Bo<voice.shen@atmel.com>
> ---
>   drivers/input/keyboard/Kconfig  |    9 +
>   drivers/input/keyboard/Makefile |    1 +
>   drivers/input/keyboard/qt1070.c |  328 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 338 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 9cc488d..2e7af9f 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -124,6 +124,15 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
>   	  right-hand column will be interpreted as the key shown in the
>   	  left-hand column.
>
> +config KEYBOARD_QT1070
> +       tristate "Atmel AT42QT1070 Touch Sensor Chip"
> +       depends on I2C
> +       help
> +         Say Y here if you want to use Atmel AT42QT1070 QTouch
> +         Sensor chip as input device.
> +         To compile this driver as a module, choose M here:
> +         the module will be called qt1070
> +
>   config KEYBOARD_QT2160
>   	tristate "Atmel AT42QT2160 Touch Sensor Chip"
>   	depends on I2C&&  EXPERIMENTAL
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 504b591..23ecb51 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
>   obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
>   obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
>   obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
> +obj-$(CONFIG_KEYBOARD_QT1070)           += qt1070.o
>   obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
>   obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
>   obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> new file mode 100755
> index 0000000..37b25d3
> --- /dev/null
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -0,0 +1,328 @@
> +/*
> + *  qt1070.c - Atmel AT42QT1070 QTouch Sensor Controller
> + *
> + *  Copyright (C) 2011 Atmel
> + *
> + *  Authors: Bo Shen<voice.shen@atmel.com>
> + *
> + *  Base on qt2160.c by:
> + *  Raphael Derosso Pereira<raphaelpereira@gmail.com>
> + *  Copyright (C) 2009
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
Please don't add file names in the comment header.
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/init.h>
> +#include<linux/i2c.h>
> +#include<linux/input.h>
> +#include<linux/slab.h>
> +#include<linux/irq.h>
> +#include<linux/interrupt.h>
> +#include<linux/jiffies.h>
> +#include<linux/delay.h>
> +
> +/* QT1070 I2C Slave Address */
> +#define QT1070_ADDR        0x1B
> +
> +/* Address for each register */
> +#define CHIP_ID            0x00
> +#define QT1070_CHIP_ID     0x2E
> +
> +#define FW_VERSION         0x01
> +#define QT1070_FW_VERSION  0x15
> +
> +#define DET_STATUS         0x02
> +
> +#define KEY_STATUS         0x03
> +
> +/* Calibrate */
> +#define CALIBRATE_CMD      0x38
> +
> +/* Reset */
> +#define nRESET             0x39
No camel case, please use all caps.
> +
> +/* Key number will be used in system */
> +#define KEY_NUMBER         0x7
Is this ARRAY_SIZE of qt1070_key2code?
> +
> +static unsigned char qt1070_key2code[] = {
> +	KEY_1, KEY_2, KEY_3, KEY_4,
> +	KEY_4, KEY_5, KEY_6,
A typo; KEY_4 used twice. And also, consider passing this keymap as 
platform data.
> +};
> +
> +struct qt1070_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct delayed_work dwork;
> +	spinlock_t lock;
> +	unsigned char keycodes[ARRAY_SIZE(qt1070_key2code)];
> +	unsigned char key;
> +};
> +
> +static int qt1070_read(struct i2c_client *client, u8 reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(client, reg);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"can not send request, returned %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte(client);
> +	if (ret<  0) {
> +		dev_err(&client->dev,
> +			"can not read register, returned %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
Can't we use i2c_smbus_read_byte_data(...) here?
> +
> +static int qt1070_write(struct i2c_client *client, u8 reg, u8 data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(client, reg);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"can not send request, returned %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_write_byte(client, data);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"can not write register, returned %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
Can't we use i2c_smbus_write_byte_data(...) here? may be we can avoid 
the helpers by using
these functions directly.
> +static bool __devinit qt1070_identify(struct i2c_client *client)
> +{
> +	int id, ver;
> +
> +	/* Read Chip ID */
> +	id = qt1070_read(client, CHIP_ID);
> +	if (id != QT1070_CHIP_ID) {
> +		dev_err(&client->dev, "ID %d not supported\n", id);
> +		return false;
> +	}
> +
> +	/* Read firmware version */
> +	ver = qt1070_read(client, FW_VERSION);
> +	if (ver<  0) {
> +		dev_err(&client->dev, "could not read the firmware version\n");
> +		return false;
> +	}
> +
> +	dev_info(&client->dev, "AT42QT1070 firmware version %x\n", ver);
> +
> +	return true;
> +}
> +
> +static int qt1070_read_key(struct qt1070_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	struct input_dev *input = data->input;
> +	u8 new_key, old_key, keyval;
> +	int ret, i, mask;
> +
> +	/* Read the detected status register */
> +	ret = qt1070_read(client, DET_STATUS);
Do we need DET_STATUS value? I don't see it being used here. If this 
value is 0,
does that mean it is a spurious interrupt? or is it needed for FSM?
> +
> +	/* Read which key changed */
> +	ret = qt1070_read(client, KEY_STATUS);
> +	old_key = data->key;
> +	data->key = new_key = ret;
> +
> +	mask = 0x01;
> +	for (i = 0; i<  KEY_NUMBER; i++) {
> +		keyval = new_key&  mask;
> +		if ((old_key&  mask) != keyval)
> +			input_report_key(input, data->keycodes[i], keyval);
> +		mask<<= 1;
> +	}
> +	input_sync(input);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t qt1070_irq(int irq, void *data)
> +{
> +	struct qt1070_data *qt1070 = data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qt1070->lock, flags);
> +
> +	cancel_delayed_work(&qt1070->dwork);
Are you sure we have to cancel this work? If you quickly press & 
release, then
two interrupts might run before the worker has a chance to run. In this 
case, we
will miss the key events. How about disable interrupts in irq handler,
run the woker, enable irq at the end of worker. we can have an 
additional read
at the end of worker to maintain the FSM as well. With this we don't need
spinlocks also. And how about normal workers instead of delayed work?

Otherwise, you can use request_threaded_irq with IRQF_ONESHOT so that you
can run i2c commands in the handler itself.
> +	schedule_delayed_work(&qt1070->dwork, 0);
> +
> +	spin_unlock_irqrestore(&qt1070->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void qt1070_schedule_read(struct qt1070_data *data)
> +{
> +	spin_lock_irq(&data->lock);
> +	schedule_delayed_work(&data->dwork, 0);
> +	spin_unlock_irq(&data->lock);
> +}
> +
> +static void qt1070_worker(struct delayed_work *work)
> +{
> +	struct qt1070_data *data = container_of(work,
> +					struct qt1070_data, dwork.work);
> +	qt1070_read_key(data);
> +}
> +
> +static int __devinit qt1070_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct qt1070_data *data;
> +	struct input_dev *input;
> +	int i;
> +	int err;
> +
> +	err = i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE);
> +	if (!err) {
> +		dev_err(&client->dev, "%s adapter not supported\n",
> +			dev_driver_string(&client->adapter->dev));
> +		return -ENODEV;
> +	}
> +
> +	/* Identify the qt1070 chip */
> +	if (!qt1070_identify(client))
> +		return -ENODEV;
> +
> +	data = kzalloc(sizeof(struct qt1070_data), GFP_KERNEL);
> +	input = input_allocate_device();
> +	if (!data || !input) {
> +		dev_err(&client->dev, "insufficient memory\n");
> +		err = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	data->client = client;
> +	data->input = input;
> +	INIT_DELAYED_WORK(&data->dwork, qt1070_worker);
> +	spin_lock_init(&data->lock);
> +
> +	input->name = "AT42QT1070 Touch Sense Keyboard";
How about a short name with no spaces? please add parent also,

input->dev.parent = &client->dev;
> +	input->id.bustype = BUS_I2C;
> +
> +	/* Add the keycode */
> +	input->keycode = data->keycodes;
> +	input->keycodesize = sizeof(data->keycodes[0]);
> +	input->keycodemax = ARRAY_SIZE(qt1070_key2code);
> +
> +	__set_bit(EV_KEY, input->evbit);
> +	__clear_bit(EV_REP, input->evbit);
No need to clear the bit.
> +	for (i = 0; i<  ARRAY_SIZE(qt1070_key2code); i++) {
> +		data->keycodes[i] = qt1070_key2code[i];
> +		__set_bit(qt1070_key2code[i], input->keybit);
> +	}
> +
> +	__clear_bit(KEY_RESERVED, input->keybit);
same here.
> +
> +	/* Calibrate device */
> +	err = qt1070_write(client, CALIBRATE_CMD, 1);
> +	if (err) {
> +		dev_err(&client->dev, "Failure to calibrate device\n");
> +		goto err_free_mem;
> +	}
> +	msleep(100);
You can have a macro for 100.
> +
> +	if (client->irq) {
> +		err = request_irq(client->irq, qt1070_irq, 0, "qt1070", data);
consider using request_threaded_irq.
> +		if (err) {
> +			dev_err(&client->dev, "fail to request irq\n");
> +			goto err_free_mem;
> +		}
> +	}
> +
> +	/* Register the input device */
> +	err = input_register_device(data->input);
> +	if (err) {
> +		dev_err(&client->dev, "Failed to register input device\n");
> +		goto err_free_irq;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +
> +	/* Read to clear the chang line */
> +	qt1070_schedule_read(data);
> +
> +	return 0;
> +
> +err_free_irq:
> +	if (client->irq)
> +		free_irq(client->irq, data);
> +err_free_mem:
> +	input_free_device(input);
> +	kfree(data);
> +	return err;
> +}
> +
> +static int __devexit qt1070_remove(struct i2c_client *client)
> +{
> +	struct qt1070_data *data = i2c_get_clientdata(client);
> +
> +	/* Release IRQ */
> +	if (client->irq)
> +		free_irq(client->irq, data);
> +
> +	input_unregister_device(data->input);
> +	kfree(data);
> +
> +	i2c_set_clientdata(client, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id qt1070_id[] = {
> +	{ "qt1070", 0 },
> +	{ },
> +};
> +
> +static struct i2c_driver qt1070_driver = {
> +	.driver = {
> +		.name = "qt1070",
> +		.owner = THIS_MODULE,
> +	},
> +	.id_table	= qt1070_id,
> +	.probe = qt1070_probe,
> +	.remove = __devexit_p(qt1070_remove),
> +};
> +
> +static int __init qt1070_init(void)
> +{
> +	return i2c_add_driver(&qt1070_driver);
> +}
> +module_init(qt1070_init);
> +
> +static void __exit qt1070_exit(void)
> +{
> +	i2c_del_driver(&qt1070_driver);
> +}
> +module_exit(qt1070_exit);
> +
> +MODULE_AUTHOR("Bo Shen<voice.shen@atmel.com>");
> +MODULE_DESCRIPTION("Driver for AT42QT1070 QTouch sensor");
> +MODULE_LICENSE("GPL");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- Mohan
