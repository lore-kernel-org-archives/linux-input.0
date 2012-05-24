From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v5] input: Add MELFAS mms114 touchscreen driver
Date: Thu, 24 May 2012 09:21:08 +0200
Message-ID: <20120524072108.GA3975@polaris.bitmath.org>
References: <1337841467-20717-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:54870 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2EXHOW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 03:14:22 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 0038124029
	for <linux-input@vger.kernel.org>; Thu, 24 May 2012 09:14:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1337841467-20717-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

Hi Joonyoung,

> This is a initial driver for new touchscreen chip mms114 of MELFAS.
> It uses I2C interface and supports 10 multi touch.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> This v5 patch was updated from Henrik review mainly.

Looking neat now, thanks for making the changes. One comment and one question:

> +#define MMS114_PACKET_NUM		8

I would have dropped this in favor of sizeof(touch[0]) instead.

> +static irqreturn_t mms114_interrupt(int irq, void *dev_id)
> +{
> +	struct mms114_data *data = dev_id;
> +	struct mms114_touch touch[MMS114_MAX_TOUCH];
> +	int packet_size;
> +	int touch_size;
> +	int index;
> +	int error;
> +
> +	if (!data->enabled)
> +		goto out;
> +
> +	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
> +	if (packet_size <= 0)
> +		goto out;
> +
> +	touch_size = packet_size / MMS114_PACKET_NUM;

Since MMS114_PACKET_NUM changed, this calculation is no longer the
same. Will you still get the correct number of touches for all
firmware versions?

> +
> +	error = __mms114_read_reg(data, MMS114_INFOMATION, packet_size,
> +			(u8 *)touch);
> +	if (error < 0)
> +		goto out;
> +
> +	for (index = 0; index < touch_size; index++)
> +		mms114_proc_mt(data, touch + index);
> +
> +	input_mt_report_pointer_emulation(data->input_dev, true);
> +	input_sync(data->input_dev);
> +
> +out:
> +	return IRQ_HANDLED;
> +}

Thanks,
Henrik
