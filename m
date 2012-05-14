From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add MELFAS mms114 touchscreen driver
Date: Mon, 14 May 2012 08:56:34 +0200
Message-ID: <20120514065634.GA18514@polaris.bitmath.org>
References: <1336100056-19884-1-git-send-email-jy0922.shim@samsung.com>
 <20120504094308.GA7124@polaris.bitmath.org>
 <4FB091D3.1070400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:37116 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab2ENGuv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 02:50:51 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 3A891EB99A
	for <linux-input@vger.kernel.org>; Mon, 14 May 2012 08:50:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FB091D3.1070400@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

> >>+struct mms114_data {
> >>+	struct i2c_client	*client;
> >>+	struct input_dev	*input_dev;
> >>+	struct mutex		mutex;
> >Other similar drivers seem to get by with the input mutex.
> 
> This is the mutex for i2c synchronization, not for input.

Yes, but you have disable_irq()/enable_irq() for that.

> >>+static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
> >>+			     unsigned int len, u8 *val)
> >>+{
> >>+	struct i2c_client *client = data->client;
> >>+	struct i2c_msg xfer;
> >>+	u8 buf = reg&  0xff;
> >>+	int ret;
> >>+
> >>+	if (reg == MMS114_MODE_CONTROL) {
> >>+		dev_err(&client->dev, "No support to read mode control reg\n");
> >>+		return -EINVAL;
> >>+	}
> >>+
> >>+	mutex_lock(&data->mutex);
> >Looks like this mutex is malplaced. The function is called both from
> >interrupt context and from user-driven context.
> 
> This driver uses threaded irq, it is not interrupt context.

Interrupt-driven context, I meant to say. Technically, your code
works, but the pattern is unusual. The serialization is needed to
remove the race between a call initiated by the interrupt and a call
initiated by the user, coming in through suspend/resume. The standard
pattern for the latter is to turn interrupts off and wait for
interrupt completion, which you already do, then continue
execution. The effect is the same, without the mutex.

> >>+	touchdata->strength = buf[5];
> >Does not seem to be used anywhere.
> 
> It seems to be used for pressure.

It is assigned a variable, but it is not reported to userland.

> >>+static int mms114_suspend(struct device *dev)
> >>+{
> >>+	struct i2c_client *client = to_i2c_client(dev);
> >>+	struct mms114_data *data = i2c_get_clientdata(client);
> >>+	struct mms114_touchdata *touchdata = data->touchdata;
> >>+	int id;
> >>+	int ret;
> >>+
> >It would seem the mutex should be here instead.
> 
> Any reasons? I did not feel the mutex needs here.

Oh well, as long as suspend/resume is the only user intervention, and
because those are already serialized, then maybe so. Something to
revisit in the next patch version, I presume.

Thanks,
Henrik
