From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH] Input: add support for the Samsung S6SY761 touchscreen
Date: Fri, 22 Sep 2017 13:17:02 +0900
Message-ID: <20170922041702.GE2957@gangnam>
References: <CGME20170921132940epcas2p35b501f1ccc79d55c0427bb1ed36e10c6@epcas2p3.samsung.com>
        <20170921132950.17452-1-andi.shyti@samsung.com>
        <20170921205607.GA15858@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:56672 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdIVEQu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 00:16:50 -0400
Content-disposition: inline
In-reply-to: <20170921205607.GA15858@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>

Hi Dmitry,

thanks for your review!

[...]

> > +static void s6sy761_report_coordinates(struct s6sy761_data *sdata, u8 *event)
> > +{
> > +	u8 tid = ((event[0] & S6SY761_MASK_TID) >> 2) - 1;
> 
> Should we make sure that event[0] & S6SY761_MASK_TID is not 0?

I check event[0] already in s6sy761_handle_events (called by the
irq handler), if we get here event[0] is for sure positive...

[...]

> > +static void s6sy761_handle_events(struct s6sy761_data *sdata, u8 left_event)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < left_event; i++) {
> > +		u8 *event = &sdata->data[i * S6SY761_EVENT_SIZE];
> > +		u8 event_id = event[0] & S6SY761_MASK_EID;
> > +
> > +		if (!event[0])
> > +			return;
		   ^^^^^^^^
... exactly here.

'!event[0]' means also to me that there is nothing left,
therefore I can discard whatever is next (given that there is
something left).

> > +		switch (event_id) {
> > +
> > +		case S6SY761_EVENT_ID_COORDINATE:
> > +			s6sy761_handle_coordinates(sdata, event);
> > +			break;
> > +
> > +		case S6SY761_EVENT_ID_STATUS:
> > +			break;
> > +
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}

[...]

> > +static ssize_t s6sy761_sysfs_low_power_store(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf, size_t len)
> > +{
> > +	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> > +	unsigned long value;
> > +	s32 ret;
> > +	u8 new_status;
> > +
> > +	if (kstrtoul(buf, 0, &value))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The device does not respond to read/write in low power,
> > +	 * it will enable only in case of external events (e.g. touch).
> > +	 * The i2c read will fail as expected if no external events occur
> > +	 */
> 
> I am not quite sure how to parse this. Are you saying that the device in
> low power mode will wake up when touched? Then your runtime PM
> implementation seems incomplete.

I was startled as well when I saw this working. It cannot be in
the PM runtime because the device would freeze (unless is
touched). I don't know if it's a bug in the firmware or this is
how it meant to be.

> In any case, I'd rather we did not expose this state as a custom
> attribute.

I can remove it completely, indeed I don't see much use of it.

[...]

> > +	sdata->devid = buffer[1] << 8 | buffer[2];
> 
> 	get_unaligned_be16()?

Thanks!

[...]

> > +	/* check if both max_x and max_y have a value */
> > +	if (unlikely(!sdata->prop.max_x || !sdata->prop.max_y))
> 
> This is not in hot path, we do not need unlikely() here.

OK, Thanks!

> > +		return -EINVAL;
> > +
> > +	/* if no tx channels defined, at least keep one */
> > +	sdata->tx_channel = !buffer[8] ? 1 : buffer[8];
> 
> 	sdata->tx_channel = max(buffer[8], 1);

Thanks!

[...]

> > +static int s6sy761_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{

[...]

> > +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > +					s6sy761_irq_handler,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +					"s6sy761_irq", sdata);
> > +	if (err)
> > +		return err;
> > +
> > +	disable_irq(client->irq);
> 
> Can you request IRQ after allocating and setting up the input device?
> Then you do not need to check for its presence in the interrupt handler.

The reason I do it here is because the x and y are embedded in
the device itself. This means that I first need to enable the
device, read x and y and then register the input device.

At power up I might expect an interrupt coming, thus I need to
check if 'input' is not 'NULL'.

[...]

> > +	err = sysfs_create_group(&sdata->client->dev.kobj,
> > +				 &s6sy761_attribute_group);
> 
> We have devm_device_add_groups() now.

Thanks! I will patch also the other driver I sent, then (the
stmfts).

[...]

> Thanks.

Thank you!

Andi
