From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] uinput: Add ioctl for using monotonic/ boot times
Date: Tue, 13 Sep 2016 17:07:56 +0200
Message-ID: <2791498.1bf6TGcxHc@wuerfel>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com> <1473775805-2242-2-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473775805-2242-2-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

On Tuesday, September 13, 2016 7:10:02 AM CEST Deepa Dinamani wrote:
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -46,11 +46,28 @@ static int uinput_dev_event(struct input_dev *dev,
>                             unsigned int type, unsigned int code, int value)
>  {
>         struct uinput_device    *udev = input_get_drvdata(dev);
> +       struct timespec64       ts;
> +       ktime_t kt;
>  
>         udev->buff[udev->head].type = type;
>         udev->buff[udev->head].code = code;
>         udev->buff[udev->head].value = value;
> -       do_gettimeofday(&udev->buff[udev->head].time);
> +
> +       kt = ktime_get();
> +       switch (udev->clk_type) {
> +       case CLOCK_REALTIME:
> +               ts = ktime_to_timespec64(ktime_mono_to_real(kt));
> +               break;
> +       case CLOCK_MONOTONIC:
> +               ts = ktime_to_timespec64(kt);
> +               break;
> +       case CLOCK_BOOTTIME:
> +               ts = ktime_to_timespec64(ktime_mono_to_any(kt, TK_OFFS_BOOT));
> +               break;
> +       }
> +
> +       udev->buff[udev->head].time.tv_sec = ts.tv_sec;
> +       udev->buff[udev->head].time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
> 

This is a bit inefficient. I think it's better to use
ktime_get_real_ts64(), ktime_get_ts64() and get_monotonic_boottime64().

I see that we do the same thing in evdev_events(), so maybe that isn't
overly critical though. Or we might want to change both.

The last one of these also uses the slow ktime_to_timespec64(), but
that is something we can improve later in the common code.

	Arnd
