From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v2 5/8] input: goodix: write configuration data to device
Date: Tue, 23 Jun 2015 13:27:01 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06166E@irsmsx105.ger.corp.intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
 <1433774273-23103-6-git-send-email-irina.tirdea@intel.com>
 <20150609181406.GJ6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11850 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754778AbbFWN1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 09:27:07 -0400
In-Reply-To: <20150609181406.GJ6338@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Purdila, Octavian" <octavian.purdila@intel.com>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Dmitry Torokhov
> Sent: 09 June, 2015 21:14
> To: Tirdea, Irina
> Cc: Bastien Nocera; Mark Rutland; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Rob
> Herring; Pawel Moll; Ian Campbell; Kumar Gala; Purdila, Octavian
> Subject: Re: [PATCH v2 5/8] input: goodix: write configuration data to device
> 
> Hi Irina,
> 

Hi Dmitry,

> On Mon, Jun 08, 2015 at 05:37:50PM +0300, Irina Tirdea wrote:
> > Goodix devices can be configured by writing custom data to the device at
> > init. The configuration data is read with request_firmware from
> > "goodix_<id>_cfg.bin", where <id> is the product id read from the device
> > (e.g.: goodix_911_cfg.bin for Goodix GT911, goodix_9271_cfg.bin for
> > GT9271).
> >
> > The configuration information has a specific format described in the Goodix
> > datasheet. It includes X/Y resolution, maximum supported touch points,
> > interrupt flags, various sesitivity factors and settings for advanced
> > features (like gesture recognition).
> >
> > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices).
> 
> I am afraid that just using request_firmware() in probe() is not the
> best option as it may cause either errors or delays in
> initialization of the driver is compiled into the kernel and tries to
> initialize before filesystem with configuration file is mounted (and
> firmware is not built into the kernel). We can either try switch to
> request_firmware_nowait() or at least document that we need firmware at
> boot.
> 

The reason I did not use request_firmware_nowait() is that this configuration data
includes information needed by probe (x/y resolution, interrupt trigger type, max
touch num), used in goodix_read_config, goodix_ts_report_touch  and for irq flags
when requesting the interrupt. I will document that we need this configuration
firmware at boot in the commit message and add a comment in the code.
Is there any other documentation I need to update?

> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  drivers/input/touchscreen/goodix.c | 128 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index c345eb7..1ce9278 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> > +#include <linux/firmware.h>
> >  #include <linux/gpio.h>
> >  #include <linux/of.h>
> >  #include <asm/unaligned.h>
> > @@ -95,6 +96,39 @@ static int goodix_i2c_read(struct i2c_client *client,
> >  	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
> >  }
> >
> > +/**
> > + * goodix_i2c_write - write data to a register of the i2c slave device.
> > + *
> > + * @client: i2c device.
> > + * @reg: the register to write to.
> > + * @buf: raw data buffer to write.
> > + * @len: length of the buffer to write
> > + */
> > +static int goodix_i2c_write(struct i2c_client *client, u16 reg, const u8 *buf,
> > +			    unsigned len)
> > +{
> > +	u8 *addr_buf;
> > +	struct i2c_msg msg;
> > +	int ret;
> > +
> > +	addr_buf = kmalloc(len + 2, GFP_KERNEL);
> > +	if (!addr_buf)
> > +		return -ENOMEM;
> > +
> > +	addr_buf[0] = reg >> 8;
> > +	addr_buf[1] = reg & 0xFF;
> > +	memcpy(&addr_buf[2], buf, len);
> > +
> > +	msg.flags = 0;
> > +	msg.addr = client->addr;
> > +	msg.buf = addr_buf;
> > +	msg.len = len + 2;
> > +
> > +	ret = i2c_transfer(client->adapter, &msg, 1);
> > +	kfree(addr_buf);
> > +	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
> > +}
> > +
> >  static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
> >  {
> >  	int touch_num;
> > @@ -192,6 +226,95 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +/**
> > + * goodix_check_cfg - Checks if config buffer is valid
> > + *
> > + * @ts: goodix_ts_data pointer
> > + * @fw: firmware config data
> > + */
> > +static int goodix_check_cfg(struct goodix_ts_data *ts,
> > +			    const struct firmware *fw)
> > +{
> > +	int i, raw_cfg_len;
> > +	u8 check_sum = 0;
> > +
> > +	if (fw->size > GOODIX_CONFIG_MAX_LENGTH) {
> > +		dev_err(&ts->client->dev,
> > +			"The length of the config buffer array is not correct");
> > +		return -EINVAL;
> > +	}
> > +
> > +	raw_cfg_len = fw->size - 2;
> > +	for (i = 0; i < raw_cfg_len; i++)
> > +		check_sum += fw->data[i];
> > +	check_sum = (~check_sum) + 1;
> > +	if (check_sum != fw->data[raw_cfg_len]) {
> > +		dev_err(&ts->client->dev,
> > +			"The checksum of the config buffer array is not correct");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fw->data[raw_cfg_len + 1] != 1) {
> > +		dev_err(&ts->client->dev,
> > +			"The Config_Fresh register needs to be set");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * goodix_send_cfg - Write device config
> > + *
> > + * @ts: goodix_ts_data pointer
> > + * @id: product id read from device
> > + */
> > +static int goodix_send_cfg(struct goodix_ts_data *ts, u16 id)
> > +{
> > +	const struct firmware *fw = NULL;
> > +	char *fw_name;
> > +	int ret;
> > +
> > +	fw_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin", id);
> > +	if (!fw_name)
> > +		return -ENOMEM;
> > +
> > +	ret = request_firmware(&fw, fw_name, &ts->client->dev);
> > +	if (ret) {
> > +		dev_err(&ts->client->dev, "Unable to open firmware %s\n",
> > +			fw_name);
> > +		goto err_free_fw_name;
> 
> That I think will cause driver to abort binding if config is not there.
> Do we always need to load the config? Is configuration stored in NVRAM?
> Maybe configuration should be only loaded when userspace requests it?
> 

The device has a default configuration, but usually this does not match the platform
needs. It is stored in volatile RAM, so we need to rewrite it after power off.
>From my tests, the default values are invalid if I do not write any config data
(goodix_read_config will print "Invalid config, using defaults").

However, we should still be able to use the device with these defaults even
if the config firmware is not there. I will just return 0 if firmware is not found.
Since configuration needs to be written before configuring the input device and
the interrupts, I don't think we can allow userspace to control it.

Thanks,
Irina

> Thanks.
> 
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
