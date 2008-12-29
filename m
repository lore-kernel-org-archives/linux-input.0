From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][patch] sh: maple: Dreamcast mouse driver
Date: Sun, 28 Dec 2008 16:28:15 -0800
Message-ID: <200812281628.15790.dmitry.torokhov@gmail.com>
References: <1230508197.7574.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:12111 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbYL2A2p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Dec 2008 19:28:45 -0500
In-Reply-To: <1230508197.7574.4.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>

Hi Adrian,

On Sunday 28 December 2008 15:49:57 Adrian McMenamin wrote:
> +
> +	mdev = to_maple_dev(dev);
> +	mdrv = to_maple_driver(dev->driver);
> +	if (!mdrv||!mdev) {
> +		error = EINVAL;
> +		goto fail;
> +	}

This still does not make sense, mdev and mdrv will never be NULL.

> +fail:
> +	return -error;

You just negated the error returned by input_register_device() and the module 
loading code will think that probe succeeded.

> +
> +static int remove_maple_mouse(struct device *dev)
> +{
> +	struct maple_device *mdev = to_maple_dev(dev);
> +	struct dc_mouse *mse = maple_get_drvdata(mdev);
> +
> +	mdev->callback = NULL;

I am uneasy about just whacking a NULL there. The other driver you sent 
implemented open and close methods and used maple_getcond_callback to 
manipulate callbacks which I assume is safer than just resetting the pointer.

-- 
Dmitry
