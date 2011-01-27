From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 12:47:27 +0100
Message-ID: <20110127114727.GA15626@polaris.bitmath.org>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
 <20110127110255.GA15159@polaris.bitmath.org>
 <871v3ysibp.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:52057 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754108Ab1A0LrD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 06:47:03 -0500
Content-Disposition: inline
In-Reply-To: <871v3ysibp.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il

>  >> Fix it by only handling each full input_event structure and return -EINVAL
>  >> if less than 1 struct was written, similar to how it is done in evdev_read.
>  >> 
>  >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
>  Henrik> Why not add the Reported-by here yourself?
> 
> Because I sent this mail before seing Baruch's reply.
> 
> I can send a v3 with it, but I wanted to wait a bit to see if there was
> any more feedback.

Great, no problem.

>  >> @@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  >> struct input_event event;
>  >> int retval;
>  >> 
>  >> +	if (count < input_event_size())
>  >> +		return -EINVAL;
>  >> +
> 
>  Henrik> This assumes that write will only ever be called with sufficient
>  Henrik> data. It is not an error to write (and report) less data than
>  Henrik> specified, so perhaps the above will yield unpleasant surprises.
> 
> Well, like this it's consistent with evdev_read(). We can only consume
> complete input_event structures, so we can either return 0 (no events
> consumed) or -EINVAL (invalid data).

But read and write are not completely symmetric.

> Before the patch we returned sizeof input_event (if data after write
> buffer is accessible) or -EINVAL otherwise.
> 
> The v1 patch returned 0, but that causes problems with userspace, as it
> often does:
> 
>     wlile (len) {
>         n = write(fd, buf, len);
>         if (n <= 0) break;
>         len -= n;
>         buf += n;
>     }
> 
> Which will then loop forever.

I won't argue against this case (with < 0) being frequent, but one
should really check "n < len" to be safe. Hopefully Dmitry has some
more input.

Either way, thanks for finding this problem.

Henrik
