From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Tue, 27 Sep 2011 22:47:38 -0700
Message-ID: <20110928054738.GB28341@core.coreip.homeip.net>
References: <1317053189-29831-1-git-send-email-simon.budig@kernelconcepts.de>
 <1317053189-29831-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41642 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1I1Frq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Sep 2011 01:47:46 -0400
Received: by yib18 with SMTP id 18so6005652yib.19
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2011 22:47:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317053189-29831-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org, Simon Budig <simon@budig.de>

Hi Simon,

On Mon, Sep 26, 2011 at 06:06:29PM +0200, simon.budig@kernelconcepts.de wrote:
> From: Simon Budig <simon@budig.de>
> 
> ---
>  drivers/input/touchscreen/Kconfig      |    5 +
>  drivers/input/touchscreen/Makefile     |    1 +
>  drivers/input/touchscreen/edt-ft5x06.c |  714 ++++++++++++++++++++++++++++++++
>  include/linux/input/edt-ft5x06.h       |   16 +
>  4 files changed, 736 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/edt-ft5x06.c
>  create mode 100644 include/linux/input/edt-ft5x06.h
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 0b28adf..4c0672c 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -339,6 +339,11 @@ config TOUCHSCREEN_PENMOUNT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called penmount.
>  
> +config TOUCHSCREEN_EDT_FT5X06
> +	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
> +	help

A bit longer description of the touchscreen here would be nice.

> +	  If unsure, say N.
> +

"To compile this driver as a module..."

>  config TOUCHSCREEN_QT602240
>  	tristate "QT602240 I2C Touchscreen"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index bd54dfe..1288ab6 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_TOUCHSCREEN_BU21013)       += bu21013_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
> +obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+= edt-ft5x06.o
>  obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
>  obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
>  obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> new file mode 100644
> index 0000000..7e2b04b
> --- /dev/null
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -0,0 +1,714 @@
> +/* drivers/input/touchscreen/edt-ft5x06.c

No file names in comments please.

> + *
> + * Copyright (C) 2011 Simon Budig, <simon.budig@kernelconcepts.de>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +/*
> + * This is a driver for the EDT "Polytouch" family of touch controllers
> + * based on the FocalTech FT5x06 line of chips.
> + *
> + * Development of this driver has been sponsored by Glyn:
> + *    http://www.glyn.com/Products/Displays
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <asm/uaccess.h>
> +#include <linux/smp_lock.h>

This file is long gone from mainline.

> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +
> +#include <linux/gpio.h>
> +
> +#include "linux/input/edt-ft5x06.h"

Should use <>.

> +
> +#define DRIVER_VERSION "v0.5"
> +
> +#define WORK_REGISTER_THRESHOLD   0x00
> +#define WORK_REGISTER_GAIN        0x30
> +#define WORK_REGISTER_OFFSET      0x31
> +#define WORK_REGISTER_NUM_X       0x33
> +#define WORK_REGISTER_NUM_Y       0x34
> +
> +#define WORK_REGISTER_OPMODE      0x3c
> +#define FACTORY_REGISTER_OPMODE   0x01
> +
> +static struct i2c_driver edt_ft5x06_i2c_ts_driver;

I don't think this forward declaration is needed.

> +
> +struct edt_ft5x06_i2c_ts_data
> +{
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	int irq;
> +	int irq_pin;
> +	int reset_pin;
> +	int num_x;
> +	int num_y;
> +
> +	struct mutex mutex;
> +	int factory_mode;

This looks like a bool.

> +	int threshold;
> +	int gain;
> +	int offset;
> +};
> +
> +static int edt_ft5x06_ts_readwrite (struct i2c_client *client,
> +                                    u16 wr_len, u8 *wr_buf,
> +                                    u16 rd_len, u8 *rd_buf)
> +{
> +	struct i2c_msg wrmsg[2];
> +	int i, ret;
> +
> +	i = 0;
> +	if (wr_len) {
> +		wrmsg[i].addr  = client->addr;
> +		wrmsg[i].flags = 0;
> +		wrmsg[i].len = wr_len;
> +		wrmsg[i].buf = wr_buf;
> +		i++;
> +	}
> +	if (rd_len) {
> +		wrmsg[i].addr  = client->addr;
> +		wrmsg[i].flags = I2C_M_RD;
> +		wrmsg[i].len = rd_len;
> +		wrmsg[i].buf = rd_buf;
> +		i++;
> +	}
> +
> +	ret = i2c_transfer (client->adapter, wrmsg, i);

Please no spaces between function names and opening parenthesis (the
keywords should have the space). This applies to the entire driver.

> +	if (ret < 0) {
> +		dev_info (&client->dev, "i2c_transfer failed: %d\n", ret);

Should probably be dev_err() or dev_warn() to denote proper severity.

> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +
> +static irqreturn_t edt_ft5x06_ts_isr (int irq, void *dev_id)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_id;
> +	unsigned char touching = 0;
> +	unsigned char rdbuf[26], wrbuf[1];
> +	int i, have_abs, type, ret;
> +
> +	memset (wrbuf, 0, sizeof (wrbuf));
> +	memset (rdbuf, 0, sizeof (rdbuf));
> +
> +	wrbuf[0] = 0xf9;
> +
> +	mutex_lock (&tsdata->mutex);
> +	ret = edt_ft5x06_ts_readwrite (tsdata->client,
> +	                               1, wrbuf,
> +	                               sizeof (rdbuf), rdbuf);

i2c_transfer() already provides necessary locking on adapter level so
several transfers would not race with each other. This locking seems
excessive.

> +	mutex_unlock (&tsdata->mutex);
> +	if (ret < 0) {
> +		dev_err (&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
> +		goto out;
> +	}
> +
> +	if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa || rdbuf[2] != 26) {
> +		dev_err (&tsdata->client->dev, "Unexpected header: %02x%02x%02x!\n", rdbuf[0], rdbuf[1], rdbuf[2]);
> +	}
> +
> +	have_abs = 0;
> +	touching = rdbuf[3];
> +	for (i = 0; i < touching; i++) {
> +		type = rdbuf[i*4+5] >> 6;
> +		if (type == 0x01 || type == 0x03)  /* ignore Touch Down and Reserved events */
> +			continue;
> +
> +		if (!have_abs) {
> +			input_report_key (tsdata->input, BTN_TOUCH,    1);
> +			input_report_abs (tsdata->input, ABS_PRESSURE, 1);

If the device does not report true pressure readings please do not fake
them. BTN_TOUCH alone should suffice.

> +			input_report_abs (tsdata->input, ABS_X, ((rdbuf[i*4+5] << 8) | rdbuf[i*4+6]) & 0x0fff);
> +			input_report_abs (tsdata->input, ABS_Y, ((rdbuf[i*4+7] << 8) | rdbuf[i*4+8]) & 0x0fff);
> +			have_abs = 1;
> +		}
> +		input_report_abs (tsdata->input, ABS_MT_POSITION_X, ((rdbuf[i*4+5] << 8) | rdbuf[i*4+6]) & 0x0fff);
> +		input_report_abs (tsdata->input, ABS_MT_POSITION_Y, ((rdbuf[i*4+7] << 8) | rdbuf[i*4+8]) & 0x0fff);
> +		input_report_abs (tsdata->input, ABS_MT_TRACKING_ID, (rdbuf[i*4+7] >> 4) & 0x0f);
> +		input_mt_sync (tsdata->input);

Any change to use stateful MT-B protocol here?

> +	}
> +	if (!have_abs) {
> +		input_report_key (tsdata->input, BTN_TOUCH,    0);
> +		input_report_abs (tsdata->input, ABS_PRESSURE, 0);
> +	}
> +	input_sync (tsdata->input);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int edt_ft5x06_i2c_register_write (struct edt_ft5x06_i2c_ts_data *tsdata,
> +                                          u8 addr, u8 value)
> +{
> +	u8 wrbuf[4];
> +	int ret;
> +
> +	wrbuf[0]  = tsdata->factory_mode ? 0xf3 : 0xfc;
> +	wrbuf[1]  = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
> +	wrbuf[2]  = value;
> +	wrbuf[3]  = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
> +
> +	disable_irq (tsdata->irq);

Do you really need to disable IRQ here? We already established that
i2c_transefr()s won't race.

> +
> +	ret = edt_ft5x06_ts_readwrite (tsdata->client,
> +	                               4, wrbuf,
> +	                               0, NULL);
> +
> +	enable_irq (tsdata->irq);
> +
> +	return ret;
> +}
> +
> +static int edt_ft5x06_i2c_register_read (struct edt_ft5x06_i2c_ts_data *tsdata,
> +                                         u8 addr)
> +{
> +	u8 wrbuf[2], rdbuf[2];
> +	int ret;
> +
> +	wrbuf[0]  = tsdata->factory_mode ? 0xf3 : 0xfc;
> +	wrbuf[1]  = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
> +	wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
> +
> +	disable_irq (tsdata->irq);
> +
> +	ret = edt_ft5x06_ts_readwrite (tsdata->client,
> +	                               2, wrbuf,
> +	                               2, rdbuf);
> +
> +	enable_irq (tsdata->irq);
> +
> +#if 0
> +	dev_info (&tsdata->client->dev, "wr: %02x %02x -> rd: %02x %02x\n",
> +	          wrbuf[0], wrbuf[1], rdbuf[0], rdbuf[1]);
> +#endif

Either lose it or turn to dev_dbg().

> +
> +	if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1])
> +		dev_err (&tsdata->client->dev, "crc error: 0x%02x expected, got 0x%02x\n",
> +		         (wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]), rdbuf[1]);
> +
> +	return ret < 0 ? ret : rdbuf[0];
> +}
> +
> +static ssize_t edt_ft5x06_i2c_setting_show (struct device *dev,
> +                                            struct device_attribute *attr,
> +                                            char *buf)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (dev);
> +	struct i2c_client *client = tsdata->client;
> +	int ret = 0;
> +	int *value;
> +	u8 addr;
> +
> +	switch (attr->attr.name[0]) {
> +		case 't':    /* threshold */

case label should be aligned with switch().

> +			addr = WORK_REGISTER_THRESHOLD;
> +			value = &tsdata->threshold;
> +			break;
> +		case 'g':    /* gain */
> +			addr = WORK_REGISTER_GAIN;
> +			value = &tsdata->gain;
> +			break;
> +		case 'o':    /* offset */
> +			addr = WORK_REGISTER_OFFSET;
> +			value = &tsdata->offset;
> +			break;
> +		default:
> +			dev_err (&client->dev, "unknown attribute for edt_ft5x06_i2c_setting_show: %s\n", attr->attr.name);
> +			return -EINVAL;
> +	}
> +
> +	mutex_lock (&tsdata->mutex);
> +
> +	if (tsdata->factory_mode == 1) {
> +		dev_err (dev, "setting register not available in factory mode\n");

You just left with mutex locked. Mutex is most likely not needed at all.

> +		return -EIO;
> +	}
> +
> +	ret = edt_ft5x06_i2c_register_read (tsdata, addr);
> +	if (ret < 0) {
> +		dev_err (&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
> +		mutex_unlock (&tsdata->mutex);
> +		return ret;
> +	}
> +	mutex_unlock (&tsdata->mutex);
> +
> +	if (ret != *value) {
> +		dev_info (&tsdata->client->dev, "i2c read (%d) and stored value (%d) differ. Huh?\n", ret, *value);
> +		*value = ret;
> +	}
> +
> +	return sprintf (buf, "%d\n", ret);
> +}
> +
> +static ssize_t edt_ft5x06_i2c_setting_store (struct device *dev,
> +                                             struct device_attribute *attr,
> +                                             const char *buf, size_t count)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (dev);
> +	struct i2c_client *client = tsdata->client;
> +	int ret = 0;
> +	u8 addr;
> +	unsigned int val;
> +
> +	mutex_lock (&tsdata->mutex);
> +
> +	if (tsdata->factory_mode == 1) {
> +		dev_err (dev, "setting register not available in factory mode\n");
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	if (sscanf(buf, "%u", &val) != 1) {
> +		dev_err (dev, "Invalid value for attribute %s\n", attr->attr.name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	switch (attr->attr.name[0]) {
> +		case 't':    /* threshold */
> +			addr = WORK_REGISTER_THRESHOLD;
> +			val = val < 20 ? 20 : val > 80 ? 80 : val;
> +			tsdata->threshold = val;
> +			break;
> +		case 'g':    /* gain */
> +			addr = WORK_REGISTER_GAIN;
> +			val = val < 0 ? 0 : val > 31 ? 31 : val;
> +			tsdata->gain = val;
> +			break;
> +		case 'o':    /* offset */
> +			addr = WORK_REGISTER_OFFSET;
> +			val = val < 0 ? 0 : val > 31 ? 31 : val;
> +			tsdata->offset = val;
> +			break;
> +		default:
> +			dev_err (&client->dev, "unknown attribute for edt_ft5x06_i2c_setting_show: %s\n", attr->attr.name);
> +			ret = -EINVAL;
> +			goto out;
> +	}
> +
> +	ret = edt_ft5x06_i2c_register_write (tsdata, addr, val);
> +
> +	if (ret < 0) {
> +		dev_err (&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
> +		goto out;
> +	}
> +
> +	mutex_unlock (&tsdata->mutex);
> +	return count;
> +
> +out:
> +	mutex_unlock (&tsdata->mutex);
> +	return ret;

Just use "return  ret < 0 ? ret : count;" and have single mutex_unlock()
path (if locking is needed).


> +}
> +
> +
> +static ssize_t edt_ft5x06_i2c_mode_show (struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (dev);
> +	return sprintf (buf, "%d\n", tsdata->factory_mode);
> +}
> +
> +static ssize_t edt_ft5x06_i2c_mode_store (struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          const char *buf, size_t count)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (dev);
> +	int i, ret = 0;
> +	unsigned int mode;
> +
> +	if (sscanf(buf, "%u", &mode) != 1 || (mode | 1) != 1) {
> +		dev_err (dev, "Invalid value for operation mode\n");
> +		return -EINVAL;
> +	}
> +
> +	/* no change, return without doing anything */
> +	if (mode == tsdata->factory_mode)
> +		return count;
> +
> +	mutex_lock (&tsdata->mutex);
> +	if (tsdata->factory_mode == 0) { /* switch to factory mode */
> +		disable_irq (tsdata->irq);
> +		/* mode register is 0x3c when in the work mode */
> +		ret = edt_ft5x06_i2c_register_write (tsdata, WORK_REGISTER_OPMODE, 0x03);
> +		if (ret < 0) {
> +			dev_err (dev, "failed to switch to factory mode (%d)\n", ret);
> +		} else {
> +			tsdata->factory_mode = 1;
> +			for (i = 0; i < 10; i++) {
> +				mdelay (5);
> +				/* mode register is 0x01 when in the factory mode */
> +				ret = edt_ft5x06_i2c_register_read (tsdata, FACTORY_REGISTER_OPMODE);
> +				if (ret == 0x03)
> +					break;
> +			}
> +			if (i == 10)
> +				dev_err (dev, "not in factory mode after %dms.\n", i*5);
> +		}
> +	} else {  /* switch to work mode */
> +		/* mode register is 0x01 when in the factory mode */
> +		ret = edt_ft5x06_i2c_register_write (tsdata, FACTORY_REGISTER_OPMODE, 0x01);
> +		if (ret < 0) {
> +			dev_err (dev, "failed to switch to work mode (%d)\n", ret);
> +		} else {
> +			tsdata->factory_mode = 0;
> +			for (i = 0; i < 10; i++) {
> +				mdelay (5);
> +				/* mode register is 0x01 when in the factory mode */
> +				ret = edt_ft5x06_i2c_register_read (tsdata, WORK_REGISTER_OPMODE);
> +				if (ret == 0x01)
> +					break;
> +			}
> +			if (i == 10)
> +				dev_err (dev, "not in work mode after %dms.\n", i*5);
> +
> +			/* restore parameters */
> +			edt_ft5x06_i2c_register_write (tsdata, WORK_REGISTER_THRESHOLD, tsdata->threshold);
> +			edt_ft5x06_i2c_register_write (tsdata, WORK_REGISTER_GAIN, tsdata->gain);
> +			edt_ft5x06_i2c_register_write (tsdata, WORK_REGISTER_OFFSET, tsdata->offset);
> +
> +			enable_irq (tsdata->irq);
> +		}
> +	}
> +
> +	mutex_unlock (&tsdata->mutex);
> +	return count;
> +}
> +
> +
> +static ssize_t edt_ft5x06_i2c_raw_data_show (struct device *dev,
> +                                             struct device_attribute *attr,
> +                                             char *buf)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (dev);
> +	int i, ret;
> +	char *ptr, wrbuf[3];
> +
> +	if (tsdata->factory_mode == 0) {
> +		dev_err (dev, "raw data not available in work mode\n");
> +		return -EIO;
> +	}
> +
> +	mutex_lock (&tsdata->mutex);
> +	ret = edt_ft5x06_i2c_register_write (tsdata, 0x08, 0x01);
> +	for (i = 0; i < 100; i++) {
> +		ret = edt_ft5x06_i2c_register_read (tsdata, 0x08);
> +		if (ret < 1)
> +			break;
> +		udelay (1000);
> +	}
> +
> +	if (i == 100 || ret < 0) {
> +		dev_err (dev, "waiting time exceeded or error: %d\n", ret);
> +		mutex_unlock (&tsdata->mutex);
> +		return ret || ETIMEDOUT;

-ENOPARSE.

> +	}
> +
> +	ptr = buf;
> +	wrbuf[0] = 0xf5;
> +	wrbuf[1] = 0x0e;
> +	for (i = 0; i <= tsdata->num_x; i++) {
> +		wrbuf[2] = i;
> +		ret = edt_ft5x06_ts_readwrite (tsdata->client,
> +		                               3, wrbuf,
> +		                               tsdata->num_y * 2, ptr);
> +		if (ret < 0) {
> +			mutex_unlock (&tsdata->mutex);
> +			return ret;
> +		}
> +
> +		ptr += tsdata->num_y * 2;
> +	}
> +
> +	mutex_unlock (&tsdata->mutex);
> +	return ptr - buf;
> +}
> +
> +
> +static DEVICE_ATTR(gain,      0664, edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
> +static DEVICE_ATTR(offset,    0664, edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
> +static DEVICE_ATTR(threshold, 0664, edt_ft5x06_i2c_setting_show, edt_ft5x06_i2c_setting_store);
> +static DEVICE_ATTR(mode,      0664, edt_ft5x06_i2c_mode_show, edt_ft5x06_i2c_mode_store);
> +static DEVICE_ATTR(raw_data,  0444, edt_ft5x06_i2c_raw_data_show, NULL);
> +
> +static struct attribute *edt_ft5x06_i2c_attrs[] = {
> +	&dev_attr_gain.attr,
> +	&dev_attr_offset.attr,
> +	&dev_attr_threshold.attr,
> +	&dev_attr_mode.attr,
> +	&dev_attr_raw_data.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group edt_ft5x06_i2c_attr_group = {
> +	.attrs = edt_ft5x06_i2c_attrs,
> +};
> +
> +static int edt_ft5x06_i2c_ts_probe (struct i2c_client *client,
> +                                    const struct i2c_device_id *id)
> +{
> +
> +	struct edt_ft5x06_i2c_ts_data *tsdata;
> +	struct input_dev *input;
> +	int error;
> +	u8 rdbuf[23];
> +	char *model_name = NULL;
> +	char *fw_version = NULL;

Why is this initialization needed?

> +
> +	dev_info (&client->dev, "probing for EDT FT5x06 I2C\n");

dev_dbg();

> +
> +	if (!client->irq) {
> +		dev_dbg (&client->dev, "no IRQ?\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!client->dev.platform_data) {
> +		dev_dbg (&client->dev, "no reset pin in platform data?\n");

The message does not really match the code.

> +		return -ENODEV;
> +	}
> +
> +	tsdata = kzalloc (sizeof (*tsdata), GFP_KERNEL);
> +	if (!tsdata) {
> +		dev_err (&client->dev, "failed to allocate driver data!\n");
> +		dev_set_drvdata (&client->dev, NULL);
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata (&client->dev, tsdata);
> +	tsdata->client = client;
> +
> +	tsdata->reset_pin = ((struct edt_ft5x06_platform_data *) client->dev.platform_data)->reset_pin;

Just have a temp for it.

> +	mutex_init (&tsdata->mutex);
> +
> +	error = gpio_request (tsdata->reset_pin, NULL);
> +	if (error < 0) {
> +		dev_err (&client->dev,
> +		         "Failed to request GPIO %d as reset pin, error %d\n",
> +		         tsdata->reset_pin, error);
> +		error = -ENOMEM;

Why -ENOMEM? Return the error that gpio_request() gave you.

> +		goto err_free_tsdata;
> +	}
> +
> +	/* this pulls reset down, enabling the low active reset */
> +	if (gpio_direction_output (tsdata->reset_pin, 0) < 0) {
> +		dev_info (&client->dev, "switching to output failed\n");
> +		error = -ENOMEM;
> +		goto err_free_reset_pin;
> +	}
> +
> +	/* request IRQ pin */
> +	tsdata->irq = client->irq;
> +	tsdata->irq_pin = irq_to_gpio (tsdata->irq);
> +
> +	error = gpio_request (tsdata->irq_pin, NULL);
> +	if (error < 0) {
> +		dev_err (&client->dev,
> +		         "Failed to request GPIO %d for IRQ %d, error %d\n",
> +		         tsdata->irq_pin, tsdata->irq, error);
> +		error = -ENOMEM;

Why -ENOMEM? Return the error that gpio_request() gave you.

> +		goto err_free_reset_pin;
> +	}
> +	gpio_direction_input (tsdata->irq_pin);
> +
> +	/* release reset */
> +	mdelay (50);
> +	gpio_set_value (tsdata->reset_pin, 1);
> +	mdelay (100);
> +
> +	mutex_lock (&tsdata->mutex);
> +
> +	tsdata->factory_mode = 0;
> +
> +	if (edt_ft5x06_ts_readwrite (client, 1, "\xbb", 22, rdbuf) < 0) {
> +		dev_err (&client->dev, "probing failed\n");
> +		error = -ENODEV;
> +		goto err_free_irq_pin;
> +	}
> +
> +	rdbuf[22] = '\0';
> +	if (rdbuf[21] == '$')
> +		rdbuf[21] = '\0';
> +
> +	model_name = rdbuf + 1;
> +	fw_version = rdbuf;
> +	/* look for Model/Version separator */
> +	while (fw_version[0] != '\0' && fw_version[0] != '*')
> +		fw_version++;

strchr()?

> +
> +	tsdata->threshold = edt_ft5x06_i2c_register_read (tsdata, WORK_REGISTER_THRESHOLD);
> +	tsdata->gain      = edt_ft5x06_i2c_register_read (tsdata, WORK_REGISTER_GAIN);
> +	tsdata->offset    = edt_ft5x06_i2c_register_read (tsdata, WORK_REGISTER_OFFSET);
> +	tsdata->num_x     = edt_ft5x06_i2c_register_read (tsdata, WORK_REGISTER_NUM_X);
> +	tsdata->num_y     = edt_ft5x06_i2c_register_read (tsdata, WORK_REGISTER_NUM_Y);
> +
> +	mutex_unlock (&tsdata->mutex);
> +
> +	if (fw_version[0] == '*') {
> +		fw_version[0] = '\0';
> +		fw_version++;
> +		dev_info (&client->dev, "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
> +		          model_name, fw_version, tsdata->num_x, tsdata->num_y);
> +	} else {
> +		dev_info (&client->dev, "Product ID \"%s\"\n", rdbuf + 1);
> +	}
> +
> +	input = input_allocate_device ();
> +	if (!input) {
> +		dev_err (&client->dev, "failed to allocate input device!\n");
> +		error = -ENOMEM;
> +		goto err_free_irq_pin;
> +	}
> +
> +	set_bit (EV_SYN, input->evbit);
> +	set_bit (EV_KEY, input->evbit);
> +	set_bit (EV_ABS, input->evbit);
> +	set_bit (BTN_TOUCH, input->keybit);

__set_bit() please, no need for locked instructions.

> +	input_set_abs_params (input, ABS_X, 0, tsdata->num_x * 64 - 1, 0, 0);
> +	input_set_abs_params (input, ABS_Y, 0, tsdata->num_y * 64 - 1, 0, 0);
> +	input_set_abs_params (input, ABS_PRESSURE, 0, 1, 0, 0);
> +	input_set_abs_params (input, ABS_MT_POSITION_X, 0, tsdata->num_x * 64 - 1, 0, 0);
> +	input_set_abs_params (input, ABS_MT_POSITION_Y, 0, tsdata->num_y * 64 - 1, 0, 0);
> +	input_set_abs_params (input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
> +
> +	input->name = kstrdup (model_name, GFP_NOIO);
> +	input->id.bustype = BUS_I2C;
> +	input->dev.parent = &client->dev;
> +
> +	input_set_drvdata (input, tsdata);
> +
> +	tsdata->input = input;
> +
> +	if ((error = input_register_device (input)))
> +		goto err_free_input_device;
> +
> +	if (request_threaded_irq (tsdata->irq, NULL, edt_ft5x06_ts_isr,
> +	                          IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +	                          client->name, tsdata)) {
> +		dev_err (&client->dev, "Unable to request touchscreen IRQ.\n");
> +		input = NULL;
> +		error = -ENOMEM;
> +		goto err_unregister_device;
> +	}
> +
> +	error = sysfs_create_group (&client->dev.kobj, &edt_ft5x06_i2c_attr_group);
> +	if (error)
> +		goto err_free_irq;
> +
> +	device_init_wakeup (&client->dev, 1);
> +
> +	dev_info (&tsdata->client->dev,
> +	          "EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
> +	          tsdata->irq_pin, tsdata->reset_pin);

dev_dbg() at most.

> +
> +	return 0;
> +
> +err_free_irq:
> +	free_irq (client->irq, tsdata);
> +err_unregister_device:
> +	input_unregister_device (input);
> +err_free_input_device:
> +	kfree (input->name);
> +	input_free_device (input);

Calls to input_free_device() are prohibited after calling
input_unregister_device().

> +err_free_irq_pin:
> +	gpio_free (tsdata->irq_pin);
> +err_free_reset_pin:
> +	gpio_free (tsdata->reset_pin);
> +err_free_tsdata:
> +	kfree (tsdata);
> +	return error;
> +}
> +
> +static int edt_ft5x06_i2c_ts_remove (struct i2c_client *client)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (&client->dev);
> +
> +	sysfs_remove_group (&client->dev.kobj, &edt_ft5x06_i2c_attr_group);
> +
> +	free_irq (client->irq, tsdata);
> +	input_unregister_device (tsdata->input);

tsdata->input is most likely already freed here.

> +	kfree (tsdata->input->name);

So this is use after free.

> +	input_free_device (tsdata->input);

As is this.

> +	gpio_free (tsdata->irq_pin);
> +	gpio_free (tsdata->reset_pin);
> +	kfree (tsdata);
> +
> +	dev_set_drvdata (&client->dev, NULL);

Not needed in mainline.

> +	return 0;
> +}
> +
> +static int edt_ft5x06_i2c_ts_suspend (struct i2c_client *client, pm_message_t mesg)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (&client->dev);
> +
> +	if (device_may_wakeup (&client->dev))
> +		enable_irq_wake (tsdata->irq);
> +
> +	return 0;
> +}
> +
> +static int edt_ft5x06_i2c_ts_resume (struct i2c_client *client)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (&client->dev);
> +
> +	if (device_may_wakeup (&client->dev))
> +		disable_irq_wake (tsdata->irq);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id edt_ft5x06_i2c_ts_id[] =
> +{
> +	{ "edt-ft5x06", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE (i2c, edt_ft5x06_i2c_ts_id);
> +
> +static struct i2c_driver edt_ft5x06_i2c_ts_driver =
> +{
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "edt_ft5x06_i2c",
> +	},
> +	.id_table = edt_ft5x06_i2c_ts_id,
> +	.probe    = edt_ft5x06_i2c_ts_probe,
> +	.remove   = edt_ft5x06_i2c_ts_remove,
> +	.suspend  = edt_ft5x06_i2c_ts_suspend,
> +	.resume   = edt_ft5x06_i2c_ts_resume,
> +};
> +
> +static int __init edt_ft5x06_i2c_ts_init (void)
> +{
> +	return i2c_add_driver (&edt_ft5x06_i2c_ts_driver);
> +}
> +module_init (edt_ft5x06_i2c_ts_init);
> +
> +static void __exit edt_ft5x06_i2c_ts_exit (void)
> +{
> +	i2c_del_driver (&edt_ft5x06_i2c_ts_driver);
> +}
> +module_exit (edt_ft5x06_i2c_ts_exit);
> +
> +MODULE_AUTHOR ("Simon Budig <simon.budig@kernelconcepts.de>");
> +MODULE_DESCRIPTION ("EDT FT5x06 I2C Touchscreen Driver");
> +MODULE_LICENSE (GPL);
> +
> diff --git a/include/linux/input/edt-ft5x06.h b/include/linux/input/edt-ft5x06.h
> new file mode 100644
> index 0000000..d7fd990
> --- /dev/null
> +++ b/include/linux/input/edt-ft5x06.h
> @@ -0,0 +1,16 @@
> +#ifndef _EDT_FT5X06_H
> +#define _EDT_FT5X06_H
> +
> +/*
> + * Copyright (c) 2011 Simon Budig, <simon.budig@kernelconcepts.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +struct edt_ft5x06_platform_data {
> +	unsigned int reset_pin;
> +};
> +
> +#endif /* _EDT_FT5X06_H */


Thanks.

-- 
Dmitry
