From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] Input: driver for the Goodix touchpanel
Date: Tue, 28 Oct 2014 18:55:21 +0100
Message-ID: <1414518921.2406.11.camel@hadess.net>
References: <1411569838.29315.22.camel@hadess.net>
	 <20141007205803.GJ16469@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55752 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaJ1R4H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 13:56:07 -0400
In-Reply-To: <20141007205803.GJ16469@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, 2014-10-07 at 13:58 -0700, Dmitry Torokhov wrote:
> Hi Bastien,
> 
> On Wed, Sep 24, 2014 at 04:43:58PM +0200, Bastien Nocera wrote:
<snip>
> > +	if (touch_num > 1) {
> > +		ret = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR + 10,
> > +				   &data[10], 8 * (touch_num - 1));
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> 
> I am a bit confused about this function. It looks like contact packet
> size is 8 bytes, and they preceded by a byte with total number of
> contacts reported, so why instead of 9 bytes we are reading 10?

I have no idea. We didn't change the original code here:
https://github.com/hadess/gt9xx/commit/82b141220e8bce00060e0de697735d0a70af2678#diff-5d71019f9b92cc9d6e2e31ed2e6520b6R363

<snip>
> > +/**
> > + * goodix_process_events - Process incoming events
> > + *
> > + * @ts: our goodix_ts_data pointer
> > + *
> > + * Called when the IRQ is triggered. Read the current device state, and push
> > + * the input events to the user space.
> > + */
> > +static void goodix_process_events(struct goodix_ts_data *ts)
> > +{
> > +	u8  point_data[1 + 8 * GOODIX_MAX_TOUCH + 1];
> 
> Here again, why do we need extra byte?

Same answer:
https://github.com/hadess/gt9xx/commit/82b141220e8bce00060e0de697735d0a70af2678#diff-5d71019f9b92cc9d6e2e31ed2e6520b6R315

<snip>
> > +/**
> > + * goodix_ts_irq_handler - The IRQ handler
> > + *
> > + * @irq: interrupt number.
> > + * @dev_id: private data pointer.
> > + */
> > +static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct goodix_ts_data *ts = dev_id;
> > +	u8  end_cmd[1] = {0};
> > +
> > +	goodix_process_events(ts);
> > +
> > +	if (goodix_i2c_write(ts->client,
> > +				GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
> > +		dev_err(&ts->client->dev, "I2C write end_cmd error");
> 
> I am not happy that we need to allocate/deallocate memory for each
> interrupt. We only write one command to the driver, we could simply use
> i2c_master_send() with a constant buffer.

Sure. But I've split up the patch you sent us, and committed the
different bits separately in:
https://github.com/hadess/gt9xx/commits/master

And this one commit about removing goodix_i2c_write():
https://github.com/hadess/gt9xx/commit/146b4cc2eed5c67bcf1cb91e845bf9f97da4be1e

Breaks the driver.

> BTW, you need terminate kernel messages with \n.

All of them? If so, we have a few more that are still missing in the
latest version of the driver, which I can take care of.

> Also, below is a patch with a few assorted changes that I'd like you to
> try if you have time.

As mentioned, all the changes seem fine apart from the one removing
goodix_i2c_write().

I'll test to see if we can reduce the size of the point_data structure,
and see what's breaking the goodix_i2c_write() patch.

Thanks for the patch!

Cheers

