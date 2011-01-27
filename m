From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 12:21:30 +0100
Message-ID: <871v3ysibp.fsf@macbook.be.48ers.dk>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
	<20110127110255.GA15159@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42445 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab1A0LVm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 06:21:42 -0500
Received: by wyb28 with SMTP id 28so1957075wyb.19
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 03:21:41 -0800 (PST)
In-Reply-To: <20110127110255.GA15159@polaris.bitmath.org> (Henrik Rydberg's
	message of "Thu, 27 Jan 2011 12:02:55 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il

>>>>> "Henrik" == Henrik Rydberg <rydberg@euromail.se> writes:

Hi Henrik,

 >> Fix it by only handling each full input_event structure and return -EINVAL
 >> if less than 1 struct was written, similar to how it is done in evdev_read.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Henrik> Why not add the Reported-by here yourself?

Because I sent this mail before seing Baruch's reply.

I can send a v3 with it, but I wanted to wait a bit to see if there was
any more feedback.

 >> @@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 >> struct input_event event;
 >> int retval;
 >> 
 >> +	if (count < input_event_size())
 >> +		return -EINVAL;
 >> +

 Henrik> This assumes that write will only ever be called with sufficient
 Henrik> data. It is not an error to write (and report) less data than
 Henrik> specified, so perhaps the above will yield unpleasant surprises.

Well, like this it's consistent with evdev_read(). We can only consume
complete input_event structures, so we can either return 0 (no events
consumed) or -EINVAL (invalid data).

Before the patch we returned sizeof input_event (if data after write
buffer is accessible) or -EINVAL otherwise.

The v1 patch returned 0, but that causes problems with userspace, as it
often does:

    wlile (len) {
        n = write(fd, buf, len);
        if (n <= 0) break;
        len -= n;
        buf += n;
    }

Which will then loop forever.

Returning -EINVAL on something that can never work seems like the sanest
option.

-- 
Bye, Peter Korsgaard
