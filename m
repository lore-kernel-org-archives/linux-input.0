From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v4 1/4] uinput: Use monotonic times for uinput
 timestamps.
Date: Thu, 14 Dec 2017 21:17:29 +0000
Message-ID: <1513286249.18523.280.camel@codethink.co.uk>
References: <20171207181306.5623-1-deepa.kernel@gmail.com>
         <20171207181306.5623-2-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:34271 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdLNVRc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Dec 2017 16:17:32 -0500
In-Reply-To: <20171207181306.5623-2-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: y2038@lists.linaro.org, peter.hutterer@who-t.net, arnd@arndb.de

On Thu, 2017-12-07 at 10:13 -0800, Deepa Dinamani wrote:
> struct timeval which is part of struct input_event to
> maintain the event times is not y2038 safe.
> 
> Real time timestamps are also not ideal for input_event
> as this time can go backwards as noted in the patch
> a80b83b7b8 by John Stultz.
> 
> The patch switches the timestamps to use monotonic time
> from realtime time. This is assuming no one is using
> absolute times from these timestamps.

Why is this change not opt-in, as for evdev?  I assume there were
compatibility reasons for not changing evdev's clock by default, so I
would expect them to apply to uinput as well.  (But I'm also prepared
to believe that user-space is now generally compatible with and would
prefer monotonic time from all input devices.)

Ben.

> The structure to maintain input events will be changed
> in a different patch.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  drivers/input/misc/uinput.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 39ddd9a73feb..d521aecbc078 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -84,11 +84,14 @@ static int uinput_dev_event(struct input_dev *dev,
> >  			    unsigned int type, unsigned int code, int value)
>  {
>  	struct uinput_device	*udev = input_get_drvdata(dev);
> +	struct timespec64	ts;
>  
>  	udev->buff[udev->head].type = type;
>  	udev->buff[udev->head].code = code;
>  	udev->buff[udev->head].value = value;
> -	do_gettimeofday(&udev->buff[udev->head].time);
> +	ktime_get_ts64(&ts);
> +	udev->buff[udev->head].time.tv_sec = ts.tv_sec;
> +	udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>  	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
>  
>  	wake_up_interruptible(&udev->waitq);
-- 
Ben Hutchings
Software Developer, Codethink Ltd.

