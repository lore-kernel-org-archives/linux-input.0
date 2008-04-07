From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input/Touchscreen Driver: add support AD7877
	touchscreen driver
Date: Mon, 7 Apr 2008 16:16:05 -0400
Message-ID: <20080407161007.ZZRA012@mailhub.coreip.homeip.net>
References: <1202980649-13309-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:1571 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYDGUQN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Apr 2008 16:16:13 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1589847wxd.4
        for <linux-input@vger.kernel.org>; Mon, 07 Apr 2008 13:16:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1202980649-13309-1-git-send-email-bryan.wu@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <bryan.wu@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

Hi Bryan, Michael,

On Thu, Feb 14, 2008 at 05:17:28PM +0800, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> [try #3] Changlog (Add feedback from Dmitry Torokhov):
>  - Change handling of spi_sync / spi_async return value handling
>  - Remove depreciated dev->power.power_state
>  - Fix error return path in ad7877_probe
>  - delete pending kernel timer
>  - Some minor cleanup (indention, use dev_err etc.)

Sorry for the long silence... I have a couple of comments at the moment
but I am sure i will have more ;)

> +
> +	status = spi_sync(spi, &req->msg);
> +
> +	if (status == 0)
> +		status = req->msg.status;
> +
> +	kfree(req);
> +	return status ? status : req->sample;

Use after free here.

> +
> +	ts->irq_disabled = 1;
> +	disable_irq(spi->irq);

I am a bit uneasy here... do we need to wait for an async spi completion
here before proceeding? Overall I have some concerns about the
irq/spi/removal/sysfs iteractions, I will need some more time to look
through the driver.

> +	status = spi_sync(spi, &req->msg);
> +	ts->irq_disabled = 0;
> +	enable_irq(spi->irq);
> +

-- 
Dmitry
