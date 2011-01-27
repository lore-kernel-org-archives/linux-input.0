From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 13:26:35 +0200
Message-ID: <20110127112635.GF12588@jasper.tkos.co.il>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
 <20110127110255.GA15159@polaris.bitmath.org>
 <871v3ysibp.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tango.tkos.co.il ([62.219.50.35]:60181 "EHLO tango.tkos.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368Ab1A0L06 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 06:26:58 -0500
Content-Disposition: inline
In-Reply-To: <871v3ysibp.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Henrik Rydberg <rydberg@euromail.se>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Peter,

On Thu, Jan 27, 2011 at 12:21:30PM +0100, Peter Korsgaard wrote:
> >>>>> "Henrik" == Henrik Rydberg <rydberg@euromail.se> writes:
>  >> @@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const 
>  >> char __user *buffer,
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
> 
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

Well this code won't loop forever, since n == 0. Only if you do:

    if (n < 0) break;

That is.

baruch

> Returning -EINVAL on something that can never work seems like the sanest
> option.

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
