From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 2/3] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Wed, 18 Jan 2017 10:58:04 +0900
Message-ID: <20170118015804.4j26oruyyej54qt4@gangnam.samsung>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p25a2bfb3a8e1e785177ea842310401d24@epcas5p2.samsung.com>
 <20170117135441.31450-3-andi.shyti@samsung.com> <20170117212128.GC6888@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42057 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdARB6N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Jan 2017 20:58:13 -0500
Content-disposition: inline
In-reply-to: <20170117212128.GC6888@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>

Hi Dmitry,

thanks for looking into the driver and the review!
I agree with almost everything, some comments below.

> > +	/* optional tuning */
> > +	err = stmfts_write_and_wait(sdata, STMFTS_MS_CX_TUNING);
> > +	if (err)
> > +		dev_warn(&sdata->client->dev, "failed to perform mutual auto tune\n");
> > +
> > +	/* optional tuning */
> > +	err = stmfts_write_and_wait(sdata, STMFTS_SS_CX_TUNING);
> > +	if (err)
> > +		dev_warn(&sdata->client->dev, "failed to perform self auto tune\n");
> > +
> > +	err = stmfts_write_and_wait(sdata, STMFTS_FULL_FORCE_CALIBRATION);
> > +	if (err)
> > +		return err;
> 
> Hmm, do you need to calibrate on boot, or maybe wait for the device to
> be opened first?

The datasheet says that I need to calibrate during boot. Anyway,
the calibration requires some time (it can be up to a couple of
seconds), therefore I wouldn't like to calibrate everytime
someone opens the device.

> > +static int stmfts_enable_key(struct stmfts_data *sdata)
> > +{
> > +	int err;
> > +
> > +	sdata->input_key = devm_input_allocate_device(&sdata->client->dev);
> > +	if (!sdata->input_key)
> > +		return -ENOMEM;
> > +
> > +	sdata->input_key->name = "stmfts_key";
> > +	sdata->input_key->id.bustype = BUS_I2C;
> > +	sdata->input_key->open = stmfts_input_key_open;
> > +	sdata->input_key->close = stmfts_input_key_close;
> 
> If you want separate input device for keys I'd recommend setting ->phys
> on them. Another option is to add keys to teh touchscreen device. Do you
> expect different actors listening to these devices? Even with different
> actors you can program event masks so that if process is not interested
> in some events (like ABS_MT_* events) it is not woken up when dveice
> generates them.

Are you suggesting to drop one event interface?

The reason why I chose to generate two interfaces is indeed
because there might be be different processes completely
unrelated to each other that will interact with the device (for
example in Jaechul's driver that you just reviewed, touchscreen
and touchkey are different devices).

I chose it for coherency with the common userspace architecture.
But of course, I can do as you recommend.

I have one more question. This touchscreen has also a proximity
functionality that works exactly as a proximity sensor and I
planned to add it in the future. Would it make sense to use the
iio framework (as it behaves as a proximity sensor) or use the
current interface? For instance, I was going to use the iio.

> > +	/* get the regulator for powering the leds on */
> > +	sdata->ledvdd = devm_regulator_get(&sdata->client->dev, "ledvdd");
> > +	if (IS_ERR(sdata->ledvdd))
> > +		/* there is no LED connected to the touch key */
> > +		sdata->ledvdd = NULL;
> 
> As I mentioned, is it truly regulator, or just a GPIO?

As I wrote in the previous mail, this is truly a regulator. If it
was a gpio, I would still prefer to use the regulator_* functions
as those would be managed by regulator-gpio and I don't need to
change the driver for that.

Thanks a lot,
Andi
