From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3] input: add EETI eGalax I2C capacitive multi touch
 driver.
Date: Thu, 10 Nov 2011 10:38:19 -0800
Message-ID: <20111110183819.GB18002@core.coreip.homeip.net>
References: <CACrgxGAxntDkvgnz7Py=-e3i0C8qx0TMdLEiek6-3FJ3+8FWnA@mail.gmail.com>
 <1320919302-31730-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57496 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab1KJSq1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Nov 2011 13:46:27 -0500
Received: by eye27 with SMTP id 27so2713878eye.19
        for <linux-input@vger.kernel.org>; Thu, 10 Nov 2011 10:46:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1320919302-31730-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: rydberg@euromail.se, linux-input@vger.kernel.org

Hi Zhang,

On Thu, Nov 10, 2011 at 06:01:42PM +0800, Zhang Jiejing wrote:
> This patch adds the EETI eGalax serial multi touch controller driver.
> 
> EETI eGalax serial touch screen controller is a I2C based multiple
> capacitive touch screen controller, it can support 5 touch events maximum.
> 
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> 
> ---
> V1 changes:
> * use mt protocol B for report pointer.
> * get the pressure value from pointer.
> * use macro to define X,Y max value.
> 
> V2 changes:
> * change MODE_SINGLE to a meanful name MODE_MOUSE
> * add some comment on each mode to avoid misunderstand
> 
> V3 changes:
> * some typo fix
> * remove MODE_MOUSE, since it can't support both mode 100% well.
>   also use this chip as MODE_MOUSE is very rare case.

Looks much nicer now.

...

>  obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
>  obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
> +obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o

'g' is before 'l'...

> +
> +/* EETI eGalax serial touch screen controller is a I2C based multiple
> + * touch screen controller, it can supports 5 pointer multiple touch. */

s/it can supports 5 pointer/it supports 5 point/

> +
> +/* TODO:
> +  - auto idle mode support
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/input/mt.h>
> +
> +/* Mouse Mode: some panel may configure the controller to mouse mode,
> + * which can only report one point at a given time.
> + * This driver will ignore events in this mode.
> + */
> +#define REPORT_MODE_MOUSE		0x1
> +/* Vendor Mode: this mode is used to transfer some vendor specify

s/specify/specific/

> + * messages, it was ignore in this driver.

s/, it was ignore in this driver//

> + * This driver will ignore events in this mode.
> + */
> +#define REPORT_MODE_VENDOR		0x3
> +/* Multiple Touch Mode */
> +#define REPORT_MODE_MTTOUCH		0x4
> +
> +#define MAX_SUPPORT_POINTS		5
> +
> +#define EVENT_VALID_OFFSET	7
> +#define EVENT_VALID_MASK	(0x1 << EVENT_VALID_OFFSET)
> +#define EVENT_ID_OFFSET		2
> +#define EVENT_ID_MASK		(0xf << EVENT_ID_OFFSET)
> +#define EVENT_IN_RANGE		(0x1 << 1)
> +#define EVENT_DOWN_UP		(0X1 << 0)
> +
> +#define MAX_I2C_DATA_LEN	10
> +
> +#define EGALAX_MAX_X	32760
> +#define EGALAX_MAX_Y	32760
> +
> +struct egalax_ts {
> +	struct i2c_client		*client;
> +	struct input_dev		*input_dev;
> +};
> +
> +static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
> +{
> +	struct egalax_ts *data = dev_id;
> +	struct input_dev *input_dev = data->input_dev;
> +	struct i2c_client *client = data->client;
> +	u8 buf[MAX_I2C_DATA_LEN];
> +	int id, ret, x, y, z;
> +	bool down, valid;
> +	u8 state;
> +
> +retry:
> +	ret = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
> +	if (ret == -EAGAIN)
> +		goto retry;
> +

Can't allow spinnig indefinitely...

	do {
		error = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
	} while (error == -EAGAIN && tries++ < EGALAX_MAX_TRIES);

> +
> +	input_dev->name = "EETI eGalax Touch Screen";
> +	input_dev->phys = "I2C",

I'd just drop this phys, it does not provide any additional information
compared to BUS_I2C below.

> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(EV_SYN, input_dev->evbit);

	Not need, always set by input core.

> +	__set_bit(ABS_X, input_dev->absbit);
> +	__set_bit(ABS_Y, input_dev->absbit);

	Calls below will take care of these 2.

> +
> +	input_set_abs_params(input_dev, ABS_X, 0, EGALAX_MAX_X, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, EGALAX_MAX_Y, 0, 0);
> +	input_set_abs_params(input_dev,
> +			     ABS_MT_POSITION_X, 0, EGALAX_MAX_X, 0, 0);
> +	input_set_abs_params(input_dev,
> +			     ABS_MT_POSITION_X, 0, EGALAX_MAX_Y, 0, 0);
> +	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS);
> +
> +	input_set_drvdata(input_dev, data);
> +
> +	ret = request_threaded_irq(client->irq, NULL, egalax_ts_interrupt,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				   "egalax_ts", data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_dev;
> +	}
> +
> +	ret = input_register_device(data->input_dev);
> +	if (ret < 0)
> +		goto err_free_irq;
> +	i2c_set_clientdata(client, data);
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(client->irq, data);
> +err_free_dev:
> +	input_free_device(input_dev);
> +err_free_data:
> +	kfree(data);
> +
> +	return ret;
> +}
> +
> +static __devexit int egalax_ts_remove(struct i2c_client *client)
> +{
> +	struct egalax_ts *data = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, data);
> +	input_unregister_device(data->input_dev);
> +	input_free_device(data->input_dev);

No calls to input_free_device after input_unregister_device.

Thanks.

-- 
Dmitry
