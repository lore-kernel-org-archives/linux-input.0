Return-Path: <SRS0=GsZw=3Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2714C35247
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 18:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8555C21741
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580840145;
	bh=C4dZbtbxCP+NfpJwttHNh1gdX8huQVEhH6UPfXRkksA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Up/qSZSKF/G9xGyR/qGZl1Ja4l3GLEKEG27BTPiWecWFKNBt6HbbffA/xHOSiNJuy
	 k4HqVktGI2+Lf9KZ7L1fYS00EZYz0olHQCiNnu3cdcQS48G0L0AaCMQpV0iw/oQ82c
	 AOrk0IsbAjTSVYmiNWmwL5VZ4d996/dbGU8RMBcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBDSPp (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbgBDSPp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Feb 2020 13:15:45 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BD12082E;
        Tue,  4 Feb 2020 18:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580840144;
        bh=C4dZbtbxCP+NfpJwttHNh1gdX8huQVEhH6UPfXRkksA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZhOVr6Ja+kObt4OaPSGI74BYX0hEACHN8zidY2Hiv6u6nl5M3yyhA/4TwrKo0S4q
         YB47VXkOmBV5WDncCAcn7lgaulF81Nm3a9vAmoMJsM629CXgR+mmcuW16i/TkSgder
         6YZiKmPpejRIXI++ov45QKDfIvKTZ8dfHQjhhqK8=
Date:   Tue, 4 Feb 2020 18:15:42 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lauri Jakku <lja@iki.fi>
Cc:     oneukum@suse.com, benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5] USB: HID: random timeout failures tackle try.
Message-ID: <20200204181542.GB1115743@kroah.com>
References: <20200204175238.3817-1-lja@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204175238.3817-1-lja@iki.fi>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Feb 04, 2020 at 07:52:39PM +0200, Lauri Jakku wrote:
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 5adf489428aa..2e0bfe70f7c5 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c

Ok, changelog issues aside:


> @@ -20,6 +20,7 @@
>  #include <linux/usb/hcd.h>	/* for usbcore internals */
>  #include <linux/usb/of.h>
>  #include <asm/byteorder.h>
> +#include <linux/errno.h>
>  
>  #include "usb.h"
>  
> @@ -137,7 +138,10 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
>  		    __u16 size, int timeout)
>  {
>  	struct usb_ctrlrequest *dr;
> -	int ret;
> +	int ret = -ETIMEDOUT;

No need to initialize this.

> +
> +	/* retry_cnt * 20ms, max retry time set to 400ms */
> +	int retry_cnt = 20;

Why?  You just now changed how all drivers will deal with timeouts.  And
you didn't change any drivers :(


>  
>  	dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_NOIO);
>  	if (!dr)
> @@ -149,11 +153,52 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
>  	dr->wIndex = cpu_to_le16(index);
>  	dr->wLength = cpu_to_le16(size);
>  
> -	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
> +	do {
> +		ret = usb_internal_control_msg(dev,
> +					pipe,
> +					dr,
> +					data,
> +					size,
> +					timeout);
> +
> +		/*
> +		 * Linger a bit, prior to the next control message
> +		 * or if return value is timeout, but do try few
> +		 * times (max 400ms) before quitting. Adapt timeout
> +		 * to be smaller when we have timeout'd first time.
> +		 */
> +		if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
> +			msleep(200);
> +		else if (ret == -ETIMEDOUT) {
> +			static int timeout_happened = 0;

Woah, what about this function being called multiple times from
different devices all at the same time?

Are you _SURE_ you want this to be static?

Hint, no way, not at all, this doesn't do at all what you think it does.
We support more than one USB device in the system at a time :)

> +
> +			if ( ! timeout_happened ) {
> +				timeout_happened = 1;
> +
> +				/* 
> +				 * If timeout is given, divide it
> +				 * by 100, if not, put 10ms timeout.
> +				 * 

Always run scripts/checkpatch.pl on your patches so you do not get
grumpy maintainers telling you to run scripts/checkpatch.pl on your
patches.


> +				 * Then safeguard: if timeout is under
> +				 * 10ms, make timeout to be 10ms.
> +				 */
> +
> +				if (timeout > 0)
> +					timeout /= 100;
> +				else
> +					timeout = 10;
> +
> +				if (timeout < 10)
> +					timeout = 10;

What is with this "backing off"?  Why?

Again, you just broke how all USB drivers treat the timeout value here,
what happens for devices that do NOT want this retried?

We do not want to retry in the USB core, _UNLESS_ the caller asks us to
do so.  Otherwise we will break things.

I understand this works for your one device, but realize we need to
support all devices in existance, at the same time :)

thanks,

greg k-h
