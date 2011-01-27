From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 12:02:55 +0100
Message-ID: <20110127110255.GA15159@polaris.bitmath.org>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:55361 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753923Ab1A0LCu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 06:02:50 -0500
Content-Disposition: inline
In-Reply-To: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il

Hi Peter,

> As was recently brought up on the busybox list
> (http://lists.busybox.net/pipermail/busybox/2011-January/074565.html),
> evdev_write doesn't properly check the count argument, which will
> lead to a return value > count on partial writes if the remaining bytes
> are accessible - Causing userspace confusion.
> 
> Fix it by only handling each full input_event structure and return -EINVAL
> if less than 1 struct was written, similar to how it is done in evdev_read.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Why not add the Reported-by here yourself?

> @@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  	struct input_event event;
>  	int retval;
>  
> +	if (count < input_event_size())
> +		return -EINVAL;
> +

This assumes that write will only ever be called with sufficient
data. It is not an error to write (and report) less data than
specified, so perhaps the above will yield unpleasant surprises.

>  	retval = mutex_lock_interruptible(&evdev->mutex);
>  	if (retval)
>  		return retval;
> @@ -330,7 +333,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  		goto out;
>  	}
>  
> -	while (retval < count) {
> +	while ((retval + input_event_size()) <= count) {

Too many parenthesis.

>  
>  		if (input_event_from_user(buffer + retval, &event)) {
>  			retval = -EFAULT;

Thanks,
Henrik
