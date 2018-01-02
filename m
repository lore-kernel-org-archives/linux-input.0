From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/3] uinput: Use monotonic times for uinput timestamps.
Date: Mon, 1 Jan 2018 22:46:52 -0800
Message-ID: <20180102064652.jjf4h4m33atgprbb@dtor-ws>
References: <20171218051844.10193-1-deepa.kernel@gmail.com>
 <20171218051844.10193-2-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:38775 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeABGq4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 01:46:56 -0500
Content-Disposition: inline
In-Reply-To: <20171218051844.10193-2-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org

On Sun, Dec 17, 2017 at 09:18:42PM -0800, Deepa Dinamani wrote:
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
> 
> The structure to maintain input events will be changed
> in a different patch.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> ---
>  drivers/input/misc/uinput.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 91df0df15e68..9251765645d1 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -84,11 +84,14 @@ static int uinput_dev_event(struct input_dev *dev,
>  			    unsigned int type, unsigned int code, int value)
>  {
>  	struct uinput_device	*udev = input_get_drvdata(dev);
> +	struct timespec64	ts;
>  
>  	udev->buff[udev->head].type = type;
>  	udev->buff[udev->head].code = code;
>  	udev->buff[udev->head].value = value;
> -	do_gettimeofday(&udev->buff[udev->head].time);
> +	ktime_get_ts64(&ts);
> +	udev->buff[udev->head].time.tv_sec = ts.tv_sec;
> +	udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>  	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
>  
>  	wake_up_interruptible(&udev->waitq);
> -- 
> 2.14.1
> 

-- 
Dmitry
