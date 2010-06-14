From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 V2] mfd: add STMPE811 core support
Date: Mon, 14 Jun 2010 12:50:32 +0100
Message-ID: <20100614115032.GA14604@rakim.wolfsonmicro.main>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de>
 <1276511558-27121-2-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43186 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751882Ab0FNLue (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 07:50:34 -0400
Content-Disposition: inline
In-Reply-To: <1276511558-27121-2-git-send-email-l.fu@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luotao Fu <l.fu@pengutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 14, 2010 at 12:32:36PM +0200, Luotao Fu wrote:

> +static void stmpe811_mask_work(struct work_struct *work)
> +{
> +	struct stmpe811 *stm = container_of(work, struct stmpe811, mask_work);
> +
> +	stmpe811_reg_write(stm, STMPE811_REG_INT_EN, stm->int_en_mask);
> +
> +	mutex_unlock(&stm->irq_mask_lock);
> +}

Why are you doing this in a workqueue?  You shouldn't need to do this -
you should implement the bus_lock() and bus_unlock() callbacks instead.

> +	ret = request_threaded_irq(client->irq, NULL, stmpe811_irq,
> +				   pdata->irq_flags, "stmpe811", stm);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to request IRQ: %d\n", ret);
> +		goto err_free;
> +	}

I suspect you should be unconditionally putting IRQF_ONESHOT here since
the threaded IRQ requires it.
