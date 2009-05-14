From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add synaptics_i2c driver
Date: Thu, 14 May 2009 08:03:08 -0700
Message-ID: <20090514150305.GA30027@dtor-d630.eng.vmware.com>
References: <1242225003-8049-1-git-send-email-mike@compulab.co.il> <20090514025030.GB9461@dtor-d630.eng.vmware.com> <4A0C28AB.9030802@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:25714 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbZENPDP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 11:03:15 -0400
Received: by rv-out-0506.google.com with SMTP id f9so770905rvb.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2009 08:03:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A0C28AB.9030802@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: grinberg@compulab.co.il, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Thu, May 14, 2009 at 05:20:27PM +0300, Mike Rapoport wrote:
> 
> 
> Dmitry Torokhov wrote:
> > 
> > Also please add long long explanantion that the driver will _not_ work
> > with Synaptics X driver. There is no chance to enable absolute mode, is
> > there?
> 
> I tried :)
> 

;( That's too bad.

> 
> >> +/* The Acceleration Factor:
> >> + * from 0.5 (1) to 4 (8) in dozes of 0.5
> >> + * the transformation is done in order to get 0.5 resolution.
> >> + * values above 8 will affect poor performance without proper smoothing.
> >> + */
> >> +#define ACCEL_DIVIDER 10
> >> +#define ACCEL_DOZE 2
> >> +static int accel = 4;
> >> +module_param(accel, int, 0644);
> >> +MODULE_PARM_DESC(accel, "Set Acceleration parameter 1..8. Default = 4");
> >> +
> >> +/* Control touchpad's No Deceleration option */
> >> +static int no_decel = 1;
> >> +module_param(no_decel, bool, 0644);
> >> +MODULE_PARM_DESC(no_decel, "No Deceleration. Default = 1 (on)");
> >> +
> > 
> > Accelkeration and deceleration handling should be done in userspace. X
> > already does this, does it not?
> 
> AFAIK Xfbdev does not really takes care of it. I think the acceleration and
> deceleration comes from xf86-input drivers.

Huh? "xset m" does not work?

> Besides, it's quite possible that
> the device will be used without X and we still want to be able to control
> acceleration and deceleration.

GPM supports that too and anything else that works with mice really.

> 
> Although the acceleration and deceleration are module_param, they cannot be
> changed in the runtime via /sys/module/synaptics_i2c/parameters.
> 

I think you meant "can" rather than "cannot" but I still believe it does
not belong in the kernel driver.

> 
> >> +
> >> +/* The Thread */
> >> +static int synaptics_i2c_touchd(void *_touch)
> >> +{
> >> +	struct synaptics_i2c *touch = _touch;
> >> +	unsigned long sleep_delay;
> >> +	int data = 1;
> >> +
> >> +	sleep_delay = synaptics_i2c_fix_delay(touch, data);
> >> +
> >> +	daemonize("synaptics_i2cd");
> >> +	while (!kthread_should_stop()) {
> >> +		if (touch->thread_stop)
> >> +			break;
> >> +		synaptics_i2c_check_params(touch);
> >> +
> >> +		wait_for_completion_interruptible_timeout(&touch->touch_completion, sleep_delay);
> >> +
> >> +		if (touch->thread_stop)
> >> +			break;
> >> +
> >> +		try_to_freeze();
> >> +		if (!touch->suspend_link) {
> >> +			do {
> >> +				data = synaptics_i2c_get_input(touch);
> >> +				sleep_delay = synaptics_i2c_fix_delay(touch, data);
> >> +			} while (data);
> >> +		}
> >> +	}
> >> +	complete_and_exit(&touch->thread_completion, 0);
> > 
> > Why don't you just use workqueue (keventd)?
> 
> We tried to use workqueue. Probably we did something entirely wrong, but with
> workqueue implementation we've got strange artefacts and random delays on
> "pen-down" events...
> 

You need to revisit this topic - your thread does not request elevated
priority so the artifacts that you have seen should not have been result
of the scheduling. It is possible that something else is hogging keventd
but that can be resolved by creating a dedicated singkethreaded workqueue,
but I don't think it would be needed either.

I guess the reason for great responsivness of your current
implementation is because you never re-initialize touch_completion so
your polling thread never sleeps and polls the device constntly without
any delays.

> +
> +	/* Report the button event */
> +	if (gesture)
> +		input_report_key(input, BTN_LEFT, 1);
> +	else
> +		input_report_key(input, BTN_LEFT, 0);
> +

That can be written simply as:

	input_report_key(input, BYN_LEFT, gesture);

Thanks.

-- 
Dmitry
