From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Fri, 4 Feb 2011 11:24:05 +0100
Message-ID: <20110204102405.GA1567@polaris.bitmath.org>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
 <20110127110255.GA15159@polaris.bitmath.org>
 <871v3ysibp.fsf@macbook.be.48ers.dk>
 <20110127114727.GA15626@polaris.bitmath.org>
 <87pqrir1r2.fsf@macbook.be.48ers.dk>
 <20110127122625.GD15626@polaris.bitmath.org>
 <87lj26qzyy.fsf@macbook.be.48ers.dk>
 <20110204084652.GB13046@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41181 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755570Ab1BDKYM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Feb 2011 05:24:12 -0500
Content-Disposition: inline
In-Reply-To: <20110204084652.GB13046@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-input@vger.kernel.org, baruch@tkos.co.il

> > I doubt this will introduce any regressions (but you never know). The
> > only situation I can see is if userspace would fill out a proper struct
> > input_dev but use a wrong (too small) length in the write call. We used
> > to accept these, but with the patch here it will -EINVAL.
> 
> I think that returning -EINVAL is good idea, so I am going to apply it.
> I also think we can change this loop to do-while kind since we already
> checked there enough space for an event.

The code below will return -EINVAL even if some parts of the buffer
was successfully read, though.

> 
> -- 
> Dmitry
> 
> 
> Input: evdev - fix evdev_write return value on partial writes
> 
> From: Peter Korsgaard <jacmet@sunsite.dk>
> 
> As was recently brought up on the busybox list
> (http://lists.busybox.net/pipermail/busybox/2011-January/074565.html),
> evdev_write doesn't properly check the count argument, which will
> lead to a return value > count on partial writes if the remaining bytes
> are accessible - causing userspace confusion.
> 
> Fix it by only handling each full input_event structure and return -EINVAL
> if less than 1 struct was written, similar to how it is done in evdev_read.
> 
> Reported-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/evdev.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c8471a2..7f42d3a 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  	struct input_event event;
>  	int retval;

Alternatively,

size_t num_written = 0;
int ret = 0;

>  
> +	if (count < input_event_size())
> +		return -EINVAL;
> +
>  	retval = mutex_lock_interruptible(&evdev->mutex);
>  	if (retval)
>  		return retval;
> @@ -330,17 +333,16 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  		goto out;
>  	}
>  
> -	while (retval < count) {

while (num_written + input_event_size() <= count) {

> -
> +	do {
>  		if (input_event_from_user(buffer + retval, &event)) {
>  			retval = -EFAULT;

ret = -EFAULT;

>  			goto out;
>  		}
> +		retval += input_event_size();

num_written += input_event_size();

>  
>  		input_inject_event(&evdev->handle,
>  				   event.type, event.code, event.value);
> -		retval += input_event_size();
> -	}
> +	} while (retval + input_event_size() <= count);
>  
>   out:
>  	mutex_unlock(&evdev->mutex);

return ret ? ret : num_written;

Thanks,
Henrik

