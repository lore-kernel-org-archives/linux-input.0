From: chinyeow.sim.xt@renesas.com
Subject: RE: [PATCH v4] Input: add ST1232 touchscreen controller driver.
Date: Thu, 16 Dec 2010 16:06:10 +0900
Message-ID: <35A4DE2FC0284919B500602E82E7DC71@rso.adwin.renesas.com>
References: <20101216061914.GA26567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:63172 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab0LPHGS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 02:06:18 -0500
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LDI006XLEEBJO80@relmlor4.idc.renesas.com> for
 linux-input@vger.kernel.org; Thu, 16 Dec 2010 16:06:11 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LDI00DE8EEA49H0@relmlir3.idc.renesas.com> for
 linux-input@vger.kernel.org; Thu, 16 Dec 2010 16:06:11 +0900 (JST)
In-reply-to: <20101216061914.GA26567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: tsoni@codeaurora.org, rydberg@euromail.se, linux-input@vger.kernel.org

Hi Dmitry,

Thanks for modifing the changes! It works well!

/ Tony

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Thursday, December 16, 2010 3:19 PM
> To: chinyeow.sim.xt@renesas.com
> Cc: tsoni@codeaurora.org; rydberg@euromail.se; 
> linux-input@vger.kernel.org
> Subject: Re: [PATCH v4] Input: add ST1232 touchscreen 
> controller driver.
> 
> 
> Hi Tony,
> 
> On Thu, Dec 16, 2010 at 09:45:25AM +0900, 
> chinyeow.sim.xt@renesas.com wrote:
> > From: Tony SIM <chinyeow.sim.xt@renesas.com>
> > 
> > This patch set introduces for Sitronix ST1232 touchscreen controller
> > driver. This is an integrated capacitive touchscreen with LCD module
> > which can detect two fingers's touch X/Y coordinate.
> > 
> > Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
> > ---
> > 
> > Thanks for review!
> > 
> > Changes since v3:
> > - Removed unused variable.
> > - Changed touch counting flag.
> 
> This looks great now, just a couple more comments:
> 
> > +
> > +struct st1232_ts_finger {
> > +	uint8_t is_valid;
> > +	uint16_t x;
> > +	uint16_t y;
> > +	uint8_t t;
> > +};
> 
> If you regroup fields the structure can be packed better. 
> Also we prefer
> u8, u16 instead of uint8_t, uint16_t in the kernel.
> 
> > +	ts->input_dev->name = "st1232-touchscreen";
> 
> 	Also need to set input->id.bus = BUS_I2C and parent device.
> 
> > +
> > +	__set_bit(EV_SYN, ts->input_dev->evbit);
> > +	__set_bit(EV_KEY, ts->input_dev->evbit);
> > +	__set_bit(EV_ABS, ts->input_dev->evbit);
> > +
> > +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> > +				0, MAX_AREA, 0, 0);
> > +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> > +				MIN_X, MAX_X, 0, 0);
> > +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> > +				MIN_Y, MAX_Y, 0, 0);
> > +
> > +	ret = input_register_device(ts->input_dev);
> > +	if (ret) {
> > +		dev_err(&client->dev, "Unable to register %s input device\n",
> > +			ts->input_dev->name);
> > +		goto err_free_input_device;
> > +	}
> > +
> > +	ret = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
> > +					IRQF_ONESHOT, client->name, ts);
> > +	if (ret) {
> > +		dev_err(&client->dev, "Failed to register interrupt\n");
> > +		goto err_free_input_device;
> 
> Registered devices should be destroyed by call to
> input_unregister_device() instead of input_free_device().
> 
> Does the following (applied on top of your patch) still work? Thanks!
> 
> -- 
> Dmitry
> 
> Input: st1232 - assorted changes
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/touchscreen/Kconfig  |   21 +++---
>  drivers/input/touchscreen/st1232.c |  133 
> ++++++++++++++++++------------------
>  2 files changed, 78 insertions(+), 76 deletions(-)
> 
> 
> diff --git a/drivers/input/touchscreen/Kconfig 
> b/drivers/input/touchscreen/Kconfig
> index 3ca7700..07ac77d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -659,17 +659,17 @@ config TOUCHSCREEN_PCAP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pcap_ts.
>  
> -config TOUCHSCREEN_TPS6507X
> -	tristate "TPS6507x based touchscreens"
> +config TOUCHSCREEN_ST1232
> +	tristate "Sitronix ST1232 touchscreen controllers"
>  	depends on I2C
>  	help
> -	  Say Y here if you have a TPS6507x based touchscreen
> -	  controller.
> +	  Say Y here if you want to support Sitronix ST1232
> +	  touchscreen controller.
>  
>  	  If unsure, say N.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called tps6507x_ts.
> +	  module will be called st1232_ts.
>  
>  config TOUCHSCREEN_STMPE
>  	tristate "STMicroelectronics STMPE touchscreens"
> @@ -681,15 +681,16 @@ config TOUCHSCREEN_STMPE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stmpe-ts.
>  
> -config TOUCHSCREEN_ST1232
> -	tristate "Sitronix ST1232 touchscreen controllers"
> +config TOUCHSCREEN_TPS6507X
> +	tristate "TPS6507x based touchscreens"
>  	depends on I2C
>  	help
> -	  Say Y here if you want to support Sitronix ST1232
> -	  touchscreen controller.
> +	  Say Y here if you have a TPS6507x based touchscreen
> +	  controller.
>  
>  	  If unsure, say N.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called st1232_ts.
> +	  module will be called tps6507x_ts.
> +
>  endif
> diff --git a/drivers/input/touchscreen/st1232.c 
> b/drivers/input/touchscreen/st1232.c
> index f94a718..4ab3713 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -16,7 +16,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
>   */
>  
>  #include <linux/delay.h>
> @@ -25,21 +24,22 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/types.h>
>  
>  #define ST1232_TS_NAME	"st1232-ts"
>  
> -#define MIN_X	0x00
> -#define MIN_Y	0x00
> -#define MAX_X	0x31f	/* (800 - 1) */
> -#define MAX_Y	0x1df	/* (480 - 1) */
> +#define MIN_X		0x00
> +#define MIN_Y		0x00
> +#define MAX_X		0x31f	/* (800 - 1) */
> +#define MAX_Y		0x1df	/* (480 - 1) */
>  #define MAX_AREA	0xff
>  #define MAX_FINGERS	2
>  
>  struct st1232_ts_finger {
> -	uint8_t is_valid;
> -	uint16_t x;
> -	uint16_t y;
> -	uint8_t t;
> +	u16 x;
> +	u16 y;
> +	u8 t;
> +	bool is_valid;
>  };
>  
>  struct st1232_ts_data {
> @@ -50,14 +50,15 @@ struct st1232_ts_data {
>  
>  static int st1232_ts_read_data(struct st1232_ts_data *ts)
>  {
> -	int ret;
> -	struct i2c_msg msg[2];
> -	uint8_t start_reg;
> -	uint8_t buf[10];
>  	struct st1232_ts_finger *finger = ts->finger;
> +	struct i2c_client *client = ts->client;
> +	struct i2c_msg msg[2];
> +	int error;
> +	u8 start_reg;
> +	u8 buf[10];
>  
>  	/* read touchscreen data from ST1232 */
> -	msg[0].addr = ts->client->addr;
> +	msg[0].addr = client->addr;
>  	msg[0].flags = 0;
>  	msg[0].len = 1;
>  	msg[0].buf = &start_reg;
> @@ -68,11 +69,11 @@ static int st1232_ts_read_data(struct st1232_ts_data *ts)
>  	msg[1].len = sizeof(buf);
>  	msg[1].buf = buf;
>  
> -	ret = i2c_transfer(ts->client->adapter, msg, 2);
> -	if (ret < 0)
> -		return ret;
> +	error = i2c_transfer(client->adapter, msg, 2);
> +	if (error < 0)
> +		return error;
>  
> -	/* get valid bit */
> +	/* get "valid" bits */
>  	finger[0].is_valid = buf[2] >> 7;
>  	finger[1].is_valid = buf[5] >> 7;
>  
> @@ -94,10 +95,11 @@ static int st1232_ts_read_data(struct st1232_ts_data *ts)
>  
>  static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  {
> -	int i, ret;
> -	int count = 0;
>  	struct st1232_ts_data *ts = dev_id;
>  	struct st1232_ts_finger *finger = ts->finger;
> +	struct input_dev *input_dev = ts->input_dev;
> +	int count = 0;
> +	int i, ret;
>  
>  	ret = st1232_ts_read_data(ts);
>  	if (ret < 0)
> @@ -108,20 +110,19 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  		if (!finger[i].is_valid)
>  			continue;
>  
> -		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> -					finger[i].t);
> -		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, finger[i].x);
> -		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, finger[i].y);
> -		input_mt_sync(ts->input_dev);
> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, finger[i].t);
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, finger[i].x);
> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, finger[i].y);
> +		input_mt_sync(input_dev);
>  		count++;
>  	}
>  
>  	/* SYN_MT_REPORT only if no contact */
>  	if (!count)
> -		input_mt_sync(ts->input_dev);
> +		input_mt_sync(input_dev);
>  
>  	/* SYN_REPORT */
> -	input_sync(ts->input_dev);
> +	input_sync(input_dev);
>  
>  end:
>  	return IRQ_HANDLED;
> @@ -131,65 +132,67 @@ static int __devinit st1232_ts_probe(struct i2c_client *client,
>  					const struct i2c_device_id *id)
>  {
>  	struct st1232_ts_data *ts;
> -	int ret;
> +	struct input_dev *input_dev;
> +	int error;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>  		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
>  		return -EIO;
>  	}
>  
> -	ts = kzalloc(sizeof(struct st1232_ts_data), GFP_KERNEL);
> -	if (!ts) {
> -		ret = -ENOMEM;
> -		goto err;
> +	if (!client->irq) {
> +		dev_err(&client->dev, "no IRQ?\n");
> +		return -EINVAL;
>  	}
>  
> -	ts->client = client;
> -	i2c_set_clientdata(client, ts);
>  
> -	ts->input_dev = input_allocate_device();
> -	if (!ts->input_dev) {
> -		ret = -ENOMEM;
> -		dev_err(&client->dev, "Failed to allocate input device\n");
> +	ts = kzalloc(sizeof(struct st1232_ts_data), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!ts || !input_dev) {
> +		error = -ENOMEM;
>  		goto err_free_mem;
>  	}
> -	ts->input_dev->name = "st1232-touchscreen";
>  
> -	__set_bit(EV_SYN, ts->input_dev->evbit);
> -	__set_bit(EV_KEY, ts->input_dev->evbit);
> -	__set_bit(EV_ABS, ts->input_dev->evbit);
> +	ts->client = client;
> +	ts->input_dev = input_dev;
>  
> -	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> -				0, MAX_AREA, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> -				MIN_X, MAX_X, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> -				MIN_Y, MAX_Y, 0, 0);
> +	input_dev->name = "st1232-touchscreen";
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
>  
> -	ret = input_register_device(ts->input_dev);
> -	if (ret) {
> -		dev_err(&client->dev, "Unable to register %s input device\n",
> -			ts->input_dev->name);
> -		goto err_free_input_device;
> -	}
> +	__set_bit(EV_SYN, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(EV_ABS, input_dev->evbit);
>  
> -	ret = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
> -					IRQF_ONESHOT, client->name, ts);
> -	if (ret) {
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
> +
> +	error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
> +				     IRQF_ONESHOT, client->name, ts);
> +	if (error) {
>  		dev_err(&client->dev, "Failed to register interrupt\n");
> -		goto err_free_input_device;
> +		goto err_free_mem;
>  	}
>  
> +	error = input_register_device(ts->input_dev);
> +	if (error) {
> +		dev_err(&client->dev, "Unable to register %s input device\n",
> +			input_dev->name);
> +		goto err_free_irq;
> +	}
> +
> +	i2c_set_clientdata(client, ts);
>  	device_init_wakeup(&client->dev, 1);
>  
>  	return 0;
>  
> -err_free_input_device:
> -	input_free_device(ts->input_dev);
> +err_free_irq:
> +	free_irq(client->irq, ts);
>  err_free_mem:
> +	input_free_device(input_dev);
>  	kfree(ts);
> -err:
> -	return ret;
> +	return error;
>  }
>  
>  static int __devexit st1232_ts_remove(struct i2c_client *client)
> @@ -207,8 +210,7 @@ static int __devexit st1232_ts_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM
>  static int st1232_ts_suspend(struct device *dev)
>  {
> -	struct st1232_ts_data *ts = dev_get_drvdata(dev);
> -	struct i2c_client *client = ts->client;
> +	struct i2c_client *client = to_i2c_client(dev);
>  
>  	if (device_may_wakeup(&client->dev))
>  		enable_irq_wake(client->irq);
> @@ -220,8 +222,7 @@ static int st1232_ts_suspend(struct device *dev)
>  
>  static int st1232_ts_resume(struct device *dev)
>  {
> -	struct st1232_ts_data *ts = dev_get_drvdata(dev);
> -	struct i2c_client *client = ts->client;
> +	struct i2c_client *client = to_i2c_client(dev);
>  
>  	if (device_may_wakeup(&client->dev))
>  		disable_irq_wake(client->irq);

