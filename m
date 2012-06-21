From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Thu, 21 Jun 2012 08:35:14 +0200
Message-ID: <20120621063357.GA23231@hposo>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be>
 <20120620184015.GA5390@polaris.bitmath.org>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53639 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab2FUGfb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:31 -0400
Received: by eeit10 with SMTP id t10so55551eei.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jun 2012 23:35:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620184015.GA5390@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Jan Paesmans <jan.paesmans@gmail.com>

Hi Henrik,

Thanks for the review.

On Wed, Jun 20, 2012 at 08:40:15PM +0200, Henrik Rydberg wrote:
> Hi Olivier,
> 
> > This driver adds support for the EDT touchscreens based on the
> > FocalTech chips.
> > 
> > Some part of the driver are based on patch for this chip sent by
> > Simon Budig to the linux-input mailing list.
> > 
> > Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> > ---
> >  drivers/input/touchscreen/Kconfig      |   12 +
> >  drivers/input/touchscreen/Makefile     |    1 +
> >  drivers/input/touchscreen/edt-ft5x06.c |  816 ++++++++++++++++++++++++++++++++
> >  include/linux/input/edt-ft5x06.h       |    8 +
> >  4 files changed, 837 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/edt-ft5x06.c
> >  create mode 100644 include/linux/input/edt-ft5x06.h
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index f67657b..032cbea 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -216,6 +216,18 @@ config TOUCHSCREEN_DYNAPRO
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called dynapro.
> >  
> > +config TOUCHSCREEN_EDT_FT5X06
> > +	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
> > +	help
> > +	  Say Y here if you have an EDT "Polytouch" touchscreen based
> > +	  on the FocalTech FT5x06 family of controllers connected to
> > +	  your system.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called edt-ft5x06.
> > +
> >  config TOUCHSCREEN_HAMPSHIRE
> >  	tristate "Hampshire serial touchscreen"
> >  	select SERIO
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > index eb8bfe1..bed430d7 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_TOUCHSCREEN_CYTTSP_SPI)	+= cyttsp_spi.o
> >  obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
> >  obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
> > +obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+= edt-ft5x06.o
> >  obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
> >  obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
> >  obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > new file mode 100644
> > index 0000000..43c72a0
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -0,0 +1,816 @@
> > +/*
> > + * Part of this code is inspired from a first version of a driver for
> > + * this chip sent by Simon Budig to the linux-input mailing list
> > + */
> 
> Replacing the above with the standard GPL header with both of your
> names ought to resolve any eventual issues, no?
No problem for me to add it. But not for Simon... look at his mail.
But is it really needed to put the GPL header at the top of each
driver? There is the MODULE_LICENSE that specify that the driver is
GPL.

> 
> > +
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/i2c.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/delay.h>
> > +#include <linux/slab.h>
> > +#include <linux/gpio.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/input/edt-ft5x06.h>
> > +
> > +/* Commands in working mode */
> > +#define CMD_RDWR_REG		0xfc
> > +#define CMD_GET_TOUCH_DATA	0xf9
> > +#define CMD_GET_FW_VERSION	0xbb
> > +
> > +/* Commands in factory mode */
> > +#define CMD_RDWR_REG_FACTORY	0xf3
> > +#define CMD_RDATA_SHOW_FACTORY	0xf5
> > +
> > +/* Registers in working mode */
> > +#define W_REGISTER_THRESHOLD	0x00
> > +#define W_REGISTER_RATE		0x08
> > +#define W_REGISTER_GAIN		0x30
> > +#define W_REGISTER_OFFSET	0x31
> > +#define W_REGISTER_NUM_X	0x33
> > +#define W_REGISTER_NUM_Y	0x34
> > +#define W_REGISTER_OPMODE	0x3c
> > +
> > +/* Registers in factory mode */
> > +#define F_REGISTER_OPMODE	0x01
> > +#define F_REGISTER_RAWDATA	0x08
> > +
> > +/* Various defines */
> > +#define SENSOR_RESOLUTION	64
> > +#define MAX_TOUCHES		5
> > +#define CHANGE_MODE_RETRIES	10
> > +#define CHANGE_MODE_DELAY	5
> > +#define RAW_DATA_RETRIES	5
> > +#define RAW_DATA_DELAY		20
> > +#define MODEL_FW_LEN		22
> > +#define RX_TOUCH_DATA_HEADER	0xaaaa
> > +
> > +/* Events */
> > +#define EVENT_TOUCH_DOWN	(0 << 2)
> > +#define EVENT_TOUCH_UP		(1 << 2)
> > +#define EVENT_TOUCH_ON		(2 << 2)
> > +#define EVENT_TOUCH_RESERVED	(3 << 2)
> > +
> > +#define FOREACH_TOUCH(p, frm) \
> > +	for (p = &frm->p[0]; p < &frm->p[frm->ntouches]; p++)
> 
> Foreach is a great construct in many places, but a) it is only used
> once, and b) C is preferred.
Ok I'll remove my foreach :-/ Or try to use it a second time ;-)

> 
> > +
> > +struct ft5x06 {
> > +	struct i2c_client *client;
> > +	struct input_dev *input;
> > +	int gpio_reset;
> > +	char model[MODEL_FW_LEN];
> > +	char fw_version[MODEL_FW_LEN];
> > +	int num_x;
> > +	int num_y;
> > +	/* mutex used to prevent access problems when switching between
> > +	 * modes */
> 
> "serialize mode switch"?
> 
> > +	struct mutex mutex;
> > +	bool factory_mode;
> > +};
> > +
> > +struct tx_write_reg {
> > +	u8 addr;
> > +	u8 val;
> > +	u8 crc;
> > +} __packed;
> > +
> > +struct rx_read_reg {
> > +	u8 val;
> > +	u8 crc;
> > +} __packed;
> > +
> > +struct rx_touch_data {
> > +	__be16 header;
> > +	u8 len;
> > +	u8 ntouches;
> > +	u8 reserved;
> > +	struct ft5x06_xy_coordinate {
> > +#if defined(__LITTLE_ENDIAN_BITFIELD)
> > +		u8 x_high:4;
> > +		u8 event:4;
> > +#else
> > +		u8 event:4;
> > +		u8 x_high:4;
> > +#endif
> > +		u8 x_low;
> > +
> > +#if defined(__LITTLE_ENDIAN_BITFIELD)
> > +		u8 y_high:4;
> > +		u8 tid:4;
> > +#else
> > +		u8 tid:4;
> > +		u8 y_high:4;
> > +#endif
> 
> Here, OTOH, a define would make the code cleaner. Something like "u8
> NIBBLES(a, b)" perhaps?
Ok thanks for the suggestion. I'll do that.

> > +		u8 y_low;
> > +	} __packed p[MAX_TOUCHES];
> > +	u8 crc;
> > +} __packed;
> > +
> > +static int ft5x06_i2c_cmd(const struct i2c_client *client, u8 cmd,
> > +			  void *wr_buf, size_t wr_len,
> > +			  void *rd_buf, size_t rd_len)
> > +{
> > +	struct i2c_msg msgs[3];
> > +	int i = 1, rc;
> > +
> > +	msgs[0].addr  = client->addr;
> > +	msgs[0].flags = 0;
> > +	msgs[0].len = sizeof(cmd);
> > +	msgs[0].buf = &cmd;
> > +
> > +	if (wr_len) {
> > +		msgs[i].addr  = client->addr;
> > +		msgs[i].flags = 0;
> > +		msgs[i].len = wr_len;
> > +		msgs[i].buf = wr_buf;
> > +		i++;
> > +	}
> > +
> > +	if (rd_len) {
> > +		msgs[i].addr  = client->addr;
> > +		msgs[i].flags = I2C_M_RD;
> > +		msgs[i].len = rd_len;
> > +		msgs[i].buf = rd_buf;
> > +		i++;
> > +	}
> > +
> > +	rc = i2c_transfer(client->adapter, msgs, i);
> > +	if (rc != i) {
> > +		dev_err(&client->dev, "i2c_transfer failed, error: %d\n",
> > +			rc);
> > +		return -EIO;
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static int ft5x06_check_frame_crc(const struct rx_touch_data *frm)
> > +{
> > +	const u8 *_frm = (const void *) frm;
> > +	u8 crc = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < sizeof(struct rx_touch_data); i++)
> > +		crc ^= _frm[i];
> > +
> > +	return crc ? -EINVAL : 0;
> > +}
> 
> I suoppose this is what the "reserved" field is for? Maybe there is a
> better name for that field?
I'm not sure to understand what you mean.
For the crc, there is a crc field at the end of the rx_touch_data
structure.
If I remembed well, the value of the field 'reserved' is always 0x00.

> 
> > +
> > +static void ft5x06_report_events(const struct ft5x06 *priv,
> > +				 const struct rx_touch_data *frm)
> > +{
> > +	struct device *dev = &priv->client->dev;
> > +	struct input_dev *input = priv->input;
> > +	int x, y;
> > +	const struct ft5x06_xy_coordinate *p;
> > +	char touch[MAX_TOUCHES];
> > +	int i;
> > +
> > +	if (frm->header != RX_TOUCH_DATA_HEADER
> > +	    || frm->len != sizeof(struct rx_touch_data)
> > +	    || frm->ntouches > MAX_TOUCHES) {
> > +		dev_dbg(dev,
> > +			"Invalid frame header (%04x), len (%d) or ntouches (%d)\n",
> > +			frm->header, frm->len, frm->ntouches);
> > +		return;
> > +	}
> > +
> > +	if (ft5x06_check_frame_crc(frm) < 0) {
> > +		dev_dbg(dev, "Invalid frame CRC\n");
> > +		return;
> > +	}
> > +
> > +	memset(touch, 0x00, sizeof(touch));
> > +
> > +	FOREACH_TOUCH(p, frm) {
> > +		if (p->event == EVENT_TOUCH_RESERVED)
> > +			continue;
> > +
> > +		if (p->tid > MAX_TOUCHES - 1)
> > +			continue;
> > +
> > +		touch[p->tid] = 1;
> > +
> > +		input_mt_slot(input, p->tid);
> > +		input_mt_report_slot_state(input, MT_TOOL_FINGER,
> > +					   p->event != EVENT_TOUCH_UP);
> > +
> > +		if (p->event != EVENT_TOUCH_UP) {
> > +			x = (p->x_high << 8) | p->x_low;
> > +			y = (p->y_high << 8) | p->y_low;
> > +
> > +			input_report_abs(input, ABS_MT_POSITION_X, x);
> > +			input_report_abs(input, ABS_MT_POSITION_Y, y);
> > +		}
> > +	}
> > +
> > +	/* This loop is needed because the hardware doesn't always
> > +	 * report the 'TOUCH_UP' event */
> > +	for (i = 0; i < MAX_TOUCHES; i++) {
> > +		if (touch[i])
> > +			continue;
> > +
> > +		input_mt_slot(input, i);
> > +		input_mt_report_slot_state(input, MT_TOOL_FINGER, 0);
> > +	}
> 
> And we aren't so lucky that p->tid is filled in for all these, or that
> p is not filled in at all for these?
After getting the TOUCH_UP event, we don't get anymore info about the
finger. Im mean the p is not anymore filled in. That's why if we miss the
TOUCH_UP event, then we never report that the finger is not anymore on
the touchscreen without this loop.

> 
> > +
> > +	input_mt_report_pointer_emulation(input, false);
> > +	input_sync(input);
> > +}
> > +
> > +static irqreturn_t ft5x06_isr(int irq, void *irq_data)
> > +{
> > +	struct ft5x06 *priv = irq_data;
> > +	struct i2c_client *client = priv->client;
> > +	struct device *dev = &client->dev;
> > +	struct rx_touch_data frm;
> > +	int rc;
> > +
> > +	memset(&frm, 0, sizeof(frm));
> > +
> > +	rc = ft5x06_i2c_cmd(client, CMD_GET_TOUCH_DATA, NULL, 0,
> > +			    &frm, sizeof(frm));
> > +	if (rc < 0) {
> > +		dev_err(dev, "Unable to get touch data, error: %d\n", rc);
> > +		goto out;
> > +	}
> > +
> > +	ft5x06_report_events(priv, &frm);
> > +
> > +out:
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int ft5x06_register_write(const struct ft5x06 *priv, u8 addr,
> > +				 u8 value)
> > +{
> > +	struct tx_write_reg wr_reg;
> > +	u8 cmd;
> > +
> > +	if (priv->factory_mode) {
> > +		cmd = CMD_RDWR_REG_FACTORY;
> > +		wr_reg.addr = addr & 0x7f;
> > +	} else {
> > +		cmd = CMD_RDWR_REG;
> > +		wr_reg.addr = addr & 0x3f;
> > +	}
> > +
> > +	wr_reg.val = value;
> > +	wr_reg.crc = cmd ^ wr_reg.addr ^ wr_reg.val;
> > +
> > +	return ft5x06_i2c_cmd(priv->client, cmd, &wr_reg, sizeof(wr_reg),
> > +			      NULL, 0);
> > +}
> > +
> > +static int ft5x06_register_read(const struct ft5x06 *priv, u8 addr)
> > +{
> > +	struct i2c_client *client = priv->client;
> > +	struct device *dev = &client->dev;
> > +	struct rx_read_reg rd_reg;
> > +	int rc;
> > +	u8 cmd;
> > +
> > +	if (priv->factory_mode) {
> > +		cmd  = CMD_RDWR_REG_FACTORY;
> > +		addr = (addr & 0x7f) | 0x80;
> > +	} else {
> > +		cmd  = CMD_RDWR_REG;
> > +		addr = (addr & 0x3f) | 0x40;
> > +	}
> > +
> > +	rc = ft5x06_i2c_cmd(client, cmd, &addr, sizeof(addr),
> > +			    &rd_reg, sizeof(rd_reg));
> > +
> > +	if ((cmd ^ addr ^ rd_reg.val) != rd_reg.crc)
> > +		dev_err(dev, "crc error: 0x%02x expected, got 0x%02x\n",
> > +			(cmd ^ addr ^ rd_reg.val), rd_reg.crc);
> > +
> > +	return (rc < 0) ? rc : rd_reg.val;
> > +}
> > +
> > +static ssize_t ft5x06_setting_show(struct device *dev, u8 addr, char *buf)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	int rc = 0;
> > +
> > +	mutex_lock(&priv->mutex);
> > +
> > +	if (priv->factory_mode) {
> > +		dev_err(dev, "Cannot get registers in factory mode\n");
> > +		rc = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	rc = ft5x06_register_read(priv, addr);
> > +	if (rc < 0) {
> > +		dev_err(dev, "Unable to get register value, error: %d\n",
> > +			rc);
> > +		goto out;
> > +	}
> > +
> > +	rc = sprintf(buf, "%d\n", rc);
> > +
> > +out:
> > +	mutex_unlock(&priv->mutex);
> > +	return rc;
> > +}
> > +
> > +static ssize_t ft5x06_setting_store(struct device *dev, u8 addr,
> > +				    unsigned int val)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	int rc = 0;
> > +
> > +	mutex_lock(&priv->mutex);
> > +
> > +	if (priv->factory_mode) {
> > +		dev_err(dev, "Cannot set registers in factory mode\n");
> > +		rc = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	rc = ft5x06_register_write(priv, addr, val);
> > +	if (rc < 0) {
> > +		dev_err(dev, "Unable to set register value, error: %d\n",
> > +			rc);
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&priv->mutex);
> > +	return rc;
> > +}
> > +
> > +static unsigned int get_value(const char *buf, unsigned int min,
> > +			      unsigned int max)
> > +{
> > +	unsigned int val;
> > +
> > +	if (kstrtouint(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	if ((val < min) || (val > max))
> > +		return -EINVAL;
> > +
> > +	return val;
> > +}
> > +
> > +static ssize_t ft5x06_store_rate(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 const char *buf, size_t count)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	unsigned int max = 12;
> > +	unsigned int val;
> > +
> > +	if (!strcmp(priv->model, "EP0570M06")
> > +	    || !strcmp(priv->model, "EP0700M06"))
> > +		max = 8;
> > +
> > +	val = get_value(buf, 3, max);
> > +	if (val < 0) {
> > +		dev_err(dev, "Invalid value for rate (min: 3, max: %d)\n",
> > +			max);
> > +		return val;
> > +	}
> > +
> > +	return ft5x06_setting_store(dev, W_REGISTER_RATE, val) ? : count;
> > +}
> > +
> > +static ssize_t ft5x06_show_rate(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	return ft5x06_setting_show(dev, W_REGISTER_RATE, buf);
> > +}
> > +static DEVICE_ATTR(rate, 0664, ft5x06_show_rate, ft5x06_store_rate);
> > +
> > +#define ft5x06_setting(name, addr, min, max) \
> > +static ssize_t ft5x06_store_##name(struct device *dev, \
> > +				   struct device_attribute *attr, \
> > +				   const char *buf, size_t count) \
> > +{ \
> > +	unsigned int val = get_value(buf, min, max); \
> > +	if (val < 0) { \
> 
> Ain't gonna happen...
Doh! Indeed sorry... I'll fix that.

> 
> > +		dev_err(dev, "Invalid value for " #name \
> > +			"(min: %d, max: %d)\n", min, max); \
> > +		return val; \
> > +	} \
> > +	return ft5x06_setting_store(dev, addr, val) ? : count; \
> > +} \
> > +static ssize_t ft5x06_show_##name(struct device *dev, \
> > +				  struct device_attribute *attr, \
> > +				  char *buf) \
> > +{ \
> > +	return ft5x06_setting_show(dev, addr, buf); \
> > +} \
> > +static DEVICE_ATTR(name, 0664, ft5x06_show_##name, ft5x06_store_##name)
> > +
> > +ft5x06_setting(threshold, W_REGISTER_THRESHOLD, 20, 80);
> > +ft5x06_setting(gain, W_REGISTER_GAIN, 0, 31);
> > +ft5x06_setting(offset, W_REGISTER_OFFSET, 0, 31);
> 
> Question: will the driver work without fiddling with these settings?
> If so, are they really necessary? Maybe some part could be moved to
> debugfs instead?
I think these four entries (threshold, gain, offset and rate) should go
in sysfs so the user is able to adjust it at runtime. However, I think
the raw entry would be better in debugfs as it is not needed to use the
touchscreen.

> 
> > +
> > +static ssize_t ft5x06_factory_mode_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	return sprintf(buf, "%d\n", priv->factory_mode);
> > +}
> > +
> > +static int ft5x06_change_mode(struct device *dev, bool factory_mode)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	u8 reg, new_reg, val;
> > +	int i, rc;
> > +
> > +	if (factory_mode) {
> > +		reg = W_REGISTER_OPMODE;
> > +		new_reg = F_REGISTER_OPMODE;
> > +		val = 0x03;
> > +	} else {
> > +		reg = F_REGISTER_OPMODE;
> > +		new_reg = W_REGISTER_OPMODE;
> > +		val = 0x01;
> > +	}
> > +
> > +	rc = ft5x06_register_write(priv, reg, val);
> > +	if (rc < 0) {
> > +		dev_err(dev, "Failed to change mode, error: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	priv->factory_mode = factory_mode;
> > +
> > +	i = CHANGE_MODE_RETRIES;
> > +	do {
> > +		mdelay(CHANGE_MODE_DELAY);
> > +		rc = ft5x06_register_read(priv, new_reg);
> > +		if (rc == val)
> > +			break;
> > +	} while (--i);
> 
> With the break inside, this looks like a standard while/for loop.
Ok I'll change it by a for loop if you prefer.

> 
> > +
> > +	if (rc != val) {
> > +		priv->factory_mode = factory_mode ? false : true;
> 
> Double boolean logic.
What do you suggest ?

> 
> > +		dev_err(dev, "Not in %s mode after %d ms.\n",
> > +			factory_mode ? "factory" : "working",
> > +			CHANGE_MODE_RETRIES * CHANGE_MODE_DELAY);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t ft5x06_factory_mode_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t count)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	unsigned int fmode;
> > +	int rc;
> > +
> > +	if (kstrtouint(buf, 10, &fmode))
> > +		return -EINVAL;
> > +
> > +	if (fmode > 1) {
> > +		dev_err(dev, "Invalid mode\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fmode == priv->factory_mode)
> > +		return count;
> > +
> > +	mutex_lock(&priv->mutex);
> > +
> > +	if (fmode)
> > +		disable_irq(client->irq);
> > +
> > +	rc = ft5x06_change_mode(dev, fmode);
> > +
> > +	if (!priv->factory_mode)
> > +		enable_irq(client->irq);
> 
> Leaving it off on error? When is it started again? Why not use the
> error code for this path?
I don't know what's the best.
To summarize:
 - In factory mode, the interrupt should be disabled
 - In operation mode, the interrupt should be activated so we get
   it when the user touches the screen.
With the above code, if we fail:
 - to change from factory mode to operation, then we do not re-enable
   the interrupt
 - to change from operation mode to factory, then we re-enable the
   interrupt
Are you OK with this?

Checking the rc code doesn't help us to know in which mode we were before
it failed or in which mode we are now, but combination with fmode and
rc will. So I can replace:
if (!priv->factory_mode)
	enable_irq(client->irq);
by:
if ((fmode && rc) || (!fmode && !rc))
	enable_irq(client->irq);

Do you prefer ?

> 
> > +
> > +	mutex_unlock(&priv->mutex);
> > +	return rc ? : count;
> > +}
> > +static DEVICE_ATTR(factory_mode, 0664, ft5x06_factory_mode_show,
> > +		   ft5x06_factory_mode_store);
> > +
> > +static ssize_t ft5x06_raw_data_show(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    char *buf)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(dev);
> > +	int i, rc;
> > +	char *ptr, wrbuf[2];
> > +
> > +	mutex_lock(&priv->mutex);
> > +
> > +	if (!priv->factory_mode) {
> > +		dev_err(dev, "Raw data not available in work mode\n");
> > +		rc = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	rc = ft5x06_register_write(priv, F_REGISTER_RAWDATA, 0x01);
> > +	if (rc < 0) {
> > +		dev_err(dev,
> > +			"Error writing in rawdata register, error: %d\n",
> > +			rc);
> > +		goto out;
> > +	}
> > +
> > +	i = RAW_DATA_RETRIES;
> > +	do {
> > +		rc = ft5x06_register_read(priv, F_REGISTER_RAWDATA);
> > +		if (rc < 1)
> > +			break;
> > +		msleep(RAW_DATA_DELAY);
> > +	} while (--i);
> 
> Recurrent pattern, function.
Ok.

> 
> > +
> > +	if (rc < 0) {
> > +		rc = (rc < 0) ? rc : -ETIMEDOUT;
> > +		dev_err(dev, "Waiting time exceeded or error: %d\n", rc);
> > +		goto out;
> > +	}
> > +
> > +	ptr = buf;
> > +	wrbuf[0] = 0x0e;
> > +	for (i = 0; i <= priv->num_x; i++) {
> > +		wrbuf[1] = i;
> > +		rc = ft5x06_i2c_cmd(priv->client, CMD_RDATA_SHOW_FACTORY,
> > +				     wrbuf, sizeof(wrbuf),
> > +				     ptr, priv->num_y * 2);
> > +		if (rc < 0)
> > +			goto out;
> > +
> > +		ptr += priv->num_y * 2;
> > +	}
> > +
> > +	rc = ptr - buf;
> > +out:
> > +	mutex_unlock(&priv->mutex);
> > +	return rc;
> > +}
> > +static DEVICE_ATTR(raw_data, 0444, ft5x06_raw_data_show, NULL);
> 
> Same comments + debugfs.
Ok for me to put this into debugfs. Aswell as the factory_mode entry.

> 
> > +
> > +static struct attribute *ft5x06_attrs[] = {
> > +	&dev_attr_gain.attr,
> > +	&dev_attr_offset.attr,
> > +	&dev_attr_threshold.attr,
> > +	&dev_attr_rate.attr,
> > +	&dev_attr_factory_mode.attr,
> > +	&dev_attr_raw_data.attr,
> > +	NULL
> > +};
> 
> Stopping here.
> 
> Clearly, there is a lot of work behind this driver, but not all of it
> needs or should be carried in the kernel. A general cleanup and
> reduction of sysfs usage would be good, if possible.

Thanks for your help !

> 
> Thanks,
> Henrik
> 
> > +
> > +static const struct attribute_group ft5x06_attr_group = {
> > +	.attrs = ft5x06_attrs,
> > +};
> > +
> > +static
> > +int __devinit ft5x06_get_model_and_fw(const struct i2c_client *client,
> > +				      char model[MODEL_FW_LEN],
> > +				      char fw_version[MODEL_FW_LEN])
> > +{
> > +	const struct device *dev = &client->dev;
> > +	u8 buf[MODEL_FW_LEN];
> > +	int rc;
> > +	char *tmp;
> > +
> > +	rc = ft5x06_i2c_cmd(client, CMD_GET_FW_VERSION, NULL, 0,
> > +			     buf, MODEL_FW_LEN);
> > +	if (rc < 0) {
> > +		dev_err(dev, "Failed to get firmware version, error: %d\n",
> > +			rc);
> > +		return rc;
> > +	}
> > +
> > +	/* Format: 0xbb,EPxx0M06*Azz_YYMMDD$ (22 chars) */
> > +	if (buf[0] != 0xbb || buf[MODEL_FW_LEN-1] != 0x24)
> > +		return -EINVAL;
> > +
> > +	buf[MODEL_FW_LEN-1] = 0x00;
> > +
> > +	tmp = strchr(buf, '*');
> > +	if (tmp) {
> > +		tmp[0] = '\0';
> > +		strlcpy(fw_version, ++tmp, MODEL_FW_LEN);
> > +	}
> > +
> > +	strlcpy(model, &buf[1], MODEL_FW_LEN);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __devinit ft5x06_reset(struct ft5x06 *priv)
> > +{
> > +	struct i2c_client *client = priv->client;
> > +	struct device *dev = &client->dev;
> > +	struct edt_ft5x06_platform_data *pdata = dev->platform_data;
> > +	int rc;
> > +
> > +	priv->gpio_reset = pdata->gpio_reset;
> > +	if (!gpio_is_valid(priv->gpio_reset))
> > +		return 0;
> > +
> > +	rc = gpio_request_one(priv->gpio_reset, GPIOF_OUT_INIT_LOW,
> > +			      "edt-ft5x06 reset pin");
> > +	if (rc < 0) {
> > +		dev_err(dev,
> > +			"Failed to get reset pin (GPIO %d), error %d\n",
> > +			priv->gpio_reset, rc);
> > +		return rc;
> > +	}
> > +
> > +	mdelay(50);
> > +	gpio_set_value(priv->gpio_reset, 1);
> > +	mdelay(100);
> > +
> > +	return 0;
> > +}
> > +
> > +static void __devinit ft5x06_init_input_dev(struct ft5x06 *priv)
> > +{
> > +	struct i2c_client *client = priv->client;
> > +	struct device *dev = &client->dev;
> > +	struct input_dev *input = priv->input;
> > +
> > +	priv->num_x = ft5x06_register_read(priv, W_REGISTER_NUM_X);
> > +	priv->num_y = ft5x06_register_read(priv, W_REGISTER_NUM_Y);
> > +
> > +	__set_bit(EV_SYN, input->evbit);
> > +	__set_bit(EV_KEY, input->evbit);
> > +	__set_bit(EV_ABS, input->evbit);
> > +	__set_bit(BTN_TOUCH, input->keybit);
> > +
> > +	/* Single touch */
> > +	input_set_abs_params(input, ABS_X, 0,
> > +			     priv->num_x * SENSOR_RESOLUTION - 1, 0, 0);
> > +	input_set_abs_params(input, ABS_Y, 0,
> > +			     priv->num_y * SENSOR_RESOLUTION - 1, 0, 0);
> > +
> > +	/* Multi touch */
> > +	input_mt_init_slots(input, MAX_TOUCHES);
> > +	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> > +			     priv->num_x * SENSOR_RESOLUTION - 1, 0, 0);
> > +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> > +			     priv->num_y * SENSOR_RESOLUTION - 1, 0, 0);
> > +
> > +	input->name = priv->model;
> > +	input->id.bustype = BUS_I2C;
> > +	input->dev.parent = dev;
> > +
> > +	input_set_drvdata(input, priv);
> > +
> > +	dev_dbg(dev, "Model: %s, Firmware: %s, %dx%d sensors\n",
> > +		priv->model, priv->fw_version ? : "Unknown",
> > +		priv->num_x, priv->num_y);
> > +}
> > +
> > +static int __devinit ft5x06_i2c_probe(struct i2c_client *client,
> > +				      const struct i2c_device_id *id)
> > +{
> > +	struct ft5x06 *priv;
> > +	struct device *dev = &client->dev;
> > +	int rc;
> > +
> > +	dev_dbg(dev, "Probing for EDT FT5x06 I2C\n");
> > +
> > +	if (!client->irq) {
> > +		dev_err(dev, "No IRQ?\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		dev_err(dev, "Failed to allocate driver data!\n");
> > +		rc = -ENOMEM;
> > +		goto err_mem;
> > +	}
> > +
> > +	priv->input = input_allocate_device();
> > +	if (!priv->input) {
> > +		dev_err(dev, "Failed to allocate input device!\n");
> > +		rc = -ENOMEM;
> > +		goto err_mem;
> > +	}
> > +
> > +	dev_set_drvdata(dev, priv);
> > +	priv->client = client;
> > +	mutex_init(&priv->mutex);
> > +
> > +	rc = ft5x06_reset(priv);
> > +	if (rc)
> > +		goto err_reset;
> > +
> > +	rc = ft5x06_get_model_and_fw(client, priv->model,
> > +				     priv->fw_version);
> > +	if (rc)
> > +		goto err_reset;
> > +
> > +	ft5x06_init_input_dev(priv);
> > +
> > +	rc = request_threaded_irq(client->irq, NULL, ft5x06_isr,
> > +				  IRQF_TRIGGER_FALLING,
> > +				  client->name, priv);
> > +	if (rc) {
> > +		dev_err(dev, "Unable to get touchscreen IRQ, error: %d\n",
> > +			rc);
> > +		goto err_irq;
> > +	}
> > +
> > +	rc = sysfs_create_group(&dev->kobj, &ft5x06_attr_group);
> > +	if (rc)
> > +		goto err_sysfs;
> > +
> > +	rc = input_register_device(priv->input);
> > +	if (rc)
> > +		goto err_register;
> > +
> > +	device_init_wakeup(dev, 1);
> > +
> > +	dev_dbg(dev, "EDT FT5x06 initialized (IRQ %d)\n", client->irq);
> > +
> > +	return 0;
> > +
> > +err_register:
> > +	sysfs_remove_group(&dev->kobj, &ft5x06_attr_group);
> > +err_sysfs:
> > +	free_irq(client->irq, priv);
> > +err_irq:
> > +	if (gpio_is_valid(priv->gpio_reset))
> > +		gpio_free(priv->gpio_reset);
> > +err_reset:
> > +	input_free_device(priv->input);
> > +err_mem:
> > +	kfree(priv);
> > +	return rc;
> > +}
> > +
> > +static int __devexit ft5x06_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct ft5x06 *priv = dev_get_drvdata(&client->dev);
> > +	struct device *dev = &client->dev;
> > +
> > +	sysfs_remove_group(&dev->kobj, &ft5x06_attr_group);
> > +
> > +	free_irq(client->irq, priv);
> > +
> > +	input_unregister_device(priv->input);
> > +
> > +	if (gpio_is_valid(priv->gpio_reset))
> > +		gpio_free(priv->gpio_reset);
> > +
> > +	kfree(priv);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int ft5x06_i2c_suspend(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +
> > +	if (device_may_wakeup(dev))
> > +		enable_irq_wake(client->irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ft5x06_i2c_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +
> > +	if (device_may_wakeup(dev))
> > +		disable_irq_wake(client->irq);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(ft5x06_pm, ft5x06_i2c_suspend, ft5x06_i2c_resume);
> > +
> > +static const struct i2c_device_id ft5x06_i2c_id[] = {
> > +	{ "edt-ft5x06", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ft5x06_i2c_id);
> > +
> > +static struct i2c_driver ft5x06_i2c_driver = {
> > +	.driver = {
> > +		.owner = THIS_MODULE,
> > +		.name = "edt-ft5x06_i2c",
> > +		.pm = &ft5x06_pm,
> > +	},
> > +	.id_table = ft5x06_i2c_id,
> > +	.probe    = ft5x06_i2c_probe,
> > +	.remove   = __devexit_p(ft5x06_i2c_remove),
> > +};
> > +module_i2c_driver(ft5x06_i2c_driver);
> > +
> > +MODULE_AUTHOR("Olivier Sobrie <olivier@sobrie.be>");
> > +MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/input/edt-ft5x06.h b/include/linux/input/edt-ft5x06.h
> > new file mode 100644
> > index 0000000..e687ffb
> > --- /dev/null
> > +++ b/include/linux/input/edt-ft5x06.h
> > @@ -0,0 +1,8 @@
> > +#ifndef _EDT_FT5X06_H
> > +#define _EDT_FT5X06_H
> > +
> > +struct edt_ft5x06_platform_data {
> > +	unsigned int gpio_reset;
> > +};
> > +
> > +#endif
> > -- 
> > 1.7.9.5
> > 

-- 
Olivier
