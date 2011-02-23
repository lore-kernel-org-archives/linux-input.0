From: jcbian <jcbian@pixcir.com.cn>
Subject: Re: [PATCH v2] input: add driver for pixcir i2c touchscreens
Date: Wed, 23 Feb 2011 09:28:10 +0800 (HKT)
Message-ID: <1bab07f.b240.12e5021693b.Coremail.jcbian@pixcir.com.cn>
References: <20110222081534.GA2004@polaris.bitmath.org>
 <1eeef53.91a4.12e4b7257f9.Coremail.jcbian@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail37.corpease.net ([61.145.121.42]:51891 "EHLO corpease.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755124Ab1BWB2V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 20:28:21 -0500
In-Reply-To: <20110222081534.GA2004@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

Hi Henrik
    Thank you very much!

> 
> Hi jcbian,
> 
> Here are some duplicate comments and additions to what you already
> heard from Mark and Dmitry.
> 
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index 61834ae..f11c1ab 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -693,4 +693,13 @@ config TOUCHSCREEN_TPS6507X
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called tps6507x_ts.
> >  
> > +config TOUCHSCREEN_PIXCIR
> > +	tristate "PIXCIR touchscreen panel support"
> > +	depends on I2C
> > +	help
> > +	  Say Y here if you have a PIXCIR based touchscreen.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called pixcir_i2c_ts.
> > +
> >  endif
> 
> Please keep Kconfig entries in alphabetical order.
> 
> > +#define DRIVER_VERSION	"v1.0"
> > +#define DRIVER_AUTHOR	"Bee<jcbian@pixcir.com.cn>,Reed<dqmeng@pixcir.com.cn>"
> > +#define DRIVER_DESC		"Pixcir I2C Touchscreen Driver"
> > +#define DRIVER_LICENSE	"GPL"
> 
> Please insert these directly in the module definition.
> 
> > +/* todo:check specs for resolution of touch screen */
> > +#define	TOUCHSCREEN_MINX	0
> > +#define	TOUCHSCREEN_MAXX	400
> > +#define	TOUCHSCREEN_MINY	0
> > +#define	TOUCHSCREEN_MAXY	600
> 
> This should really be settled before mainline inclusion.
> 
> > +
> > +#define	DEBUG	0
> 
> Odd one...
> 
> > +
> > +static struct workqueue_struct *pixcir_wq;
> > +
> > +struct pixcir_i2c_ts_data {
> > +	struct i2c_client *client;
> > +	struct input_dev *input;
> > +	struct delayed_work work;
> > +	int irq;
> > +};
> > +
> > +static void pixcir_ts_poscheck(struct work_struct *work)
> > +{
> > +	struct pixcir_i2c_ts_data *tsdata = container_of(work,
> > +						  struct pixcir_i2c_ts_data,
> > +						  work.work);
> > +
> > +	unsigned char touching, oldtouching;
> > +	int posx1, posy1, posx2, posy2;
> > +	u_int8_t Rdbuf[10], Wrbuf[1];
> 
> Please do not use capitals in variable names.
> 
> > +	int ret;
> > +	int z = 50;
> > +	int w = 15;
> 
> Please remove these fake values altogether.
> 
> > +
> > +	memset(Wrbuf, 0, sizeof(Wrbuf));
> > +	memset(Rdbuf, 0, sizeof(Rdbuf));
> > +
> > +	Wrbuf[0] = 0;
> > +	ret = i2c_master_send(tsdata->client, Wrbuf, 1);
> > +	if (ret != 1) {
> > +		dev_err(&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
> > +		goto out;
> > +	}
> > +
> > +	ret = i2c_master_recv(tsdata->client, Rdbuf, sizeof(Rdbuf));
> > +	if (ret != sizeof(Rdbuf)) {
> > +		dev_err(&tsdata->client->dev, "Unable to read i2c page!\n");
> > +		goto out;
> > +	}
> > +
> > +	touching = Rdbuf[0];
> > +	oldtouching = Rdbuf[1];
> > +	posx1 = ((Rdbuf[3] << 8) | Rdbuf[2]);
> > +	posy1 = ((Rdbuf[5] << 8) | Rdbuf[4]);
> > +	posx2 = ((Rdbuf[7] << 8) | Rdbuf[6]);
> > +	posy2 = ((Rdbuf[9] << 8) | Rdbuf[8]);
> > +
> > +	input_report_key(tsdata->input, BTN_TOUCH, (touching != 0 ? 1 : 0));
> > +
> > +	if (touching == 1) {
> > +		input_report_abs(tsdata->input, ABS_X, posx1);
> > +		input_report_abs(tsdata->input, ABS_Y, posy1);
> > +	}
> > +
> > +	if (!(touching)) {
> > +		z = 0;
> > +		w = 0;
> > +	}
> > +	if (touching == 2) {
> > +		input_report_abs(tsdata->input, ABS_MT_TOUCH_MAJOR, z);
> > +		input_report_abs(tsdata->input, ABS_MT_WIDTH_MAJOR, w);
> > +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
> > +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
> > +		input_mt_sync(tsdata->input);
> > +
> > +		input_report_abs(tsdata->input, ABS_MT_TOUCH_MAJOR, z);
> > +		input_report_abs(tsdata->input, ABS_MT_WIDTH_MAJOR, w);
> > +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
> > +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);
> > +		input_mt_sync(tsdata->input);
> > +	}
> > +	input_sync(tsdata->input);
> 
> Please use the slotted type B protocol instead. If the device can
> track fingers, it is very simple to do, see for instance
> drivers/input/touchscreen/wacom_w8001.c. If the device cannot do
> tracking, please do tell and we will add in pending tracking support
> to the input core together with this driver.
> 
> Thanks,
> Henrik





