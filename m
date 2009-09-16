From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Tue, 15 Sep 2009 23:00:17 -0700
Message-ID: <20090916060017.GG2756@core.coreip.homeip.net>
References: <4AB07B5E.7040501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:50914 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbZIPGAS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 02:00:18 -0400
Received: by yxe1 with SMTP id 1so6271000yxe.21
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2009 23:00:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AB07B5E.7040501@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

Hi Joonyoung,

On Wed, Sep 16, 2009 at 02:45:02PM +0900, Joonyoung Shim wrote:
> +
> +static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
> +{
> +	struct mcs5000_ts_data *data = dev_id;
> +	struct i2c_client *client = data->client;
> +	u8 buffer[READ_BLOCK_SIZE];
> +	int err;
> +	int x;
> +	int y;
> +
> +	disable_irq_nosync(irq);
> +

I don't think we need to disable IRQ in the threaded handler - it should
be masked off until we return...

> +
> +static irqreturn_t mcs5000_ts_hardirq(int irq, void *dev_id)
> +{
> +	return IRQ_WAKE_THREAD;
> +}

This is not needed, just pass NULL to request_threaded_irq().

Thanks.

-- 
Dmitry
