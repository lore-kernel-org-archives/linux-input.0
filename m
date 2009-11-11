From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: keyboard leds not restored after s2ram in 2.6.32-rc6-00166-g799dd75
Date: Wed, 11 Nov 2009 12:05:42 -0800 (PST)
Message-ID: <800885.42568.qm@web58401.mail.re3.yahoo.com>
References: <761296.29412.qm@web58402.mail.re3.yahoo.com> <20091111095218.GA3654@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757294AbZKKUFm@vger.kernel.org>
In-Reply-To: <20091111095218.GA3654@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> > my laptop shows the caps lock and scroll lock leds as being on after s2ram
> > (and resume), even though they are off. If I press the caps lock key, the caps
> > lock led stays on, the num lock led turns off, and the screen unlock screen
> > warns about the caps lock being on.
> > 
> 
> Thank you for the report. Could youplease tell me if the patch below
> fixes the problem?

Yes, it does. Thanks, now my HP-dv5 is happy.

I did some tests suspending with the caps lock actually on, and it seems that
in that case the user might still be confused (caps lock is on but led is off).
At least on this machine this patch doesn't affect this theoretical problem
either way (2.6.31 behaves similarly), so it is ok.


Mikko


> 
> Thanks!
> 
> -- 
> Dmitry
> 
> 
> Input: force LED reset on resume
> 
> From: Dmitry Torokhov 
> 
> We should be sending EV_LED event down to drivers upon resume even in cases
> when in-kernel state of the LED is off since device could come up with some
> leds turned on.
> 
> Reported-by: Mikko Vinni 
> Signed-off-by: Dmitry Torokhov 
> ---
> 
> drivers/input/input.c |   29 ++++++++++++++++++-----------
> 1 files changed, 18 insertions(+), 11 deletions(-)
> 
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 61069b2..77b6efe 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1298,17 +1298,24 @@ static int input_dev_uevent(struct device *device, 
> struct kobj_uevent_env *env)
>     return 0;
> }
> 
> -#define INPUT_DO_TOGGLE(dev, type, bits, on)            \
> -    do {                            \
> -        int i;                        \
> -        if (!test_bit(EV_##type, dev->evbit))        \
> -            break;                    \
> -        for (i = 0; i < type##_MAX; i++) {        \
> -            if (!test_bit(i, dev->bits##bit) ||    \
> -                !test_bit(i, dev->bits))        \
> -                continue;            \
> -            dev->event(dev, EV_##type, i, on);    \
> -        }                        \
> +#define INPUT_DO_TOGGLE(dev, type, bits, on)                \
> +    do {                                \
> +        int i;                            \
> +        bool active;                        \
> +                                    \
> +        if (!test_bit(EV_##type, dev->evbit))            \
> +            break;                        \
> +                                    \
> +        for (i = 0; i < type##_MAX; i++) {            \
> +            if (!test_bit(i, dev->bits##bit))        \
> +                continue;                \
> +                                    \
> +            active = test_bit(i, dev->bits);        \
> +            if (!active && !on)                \
> +                continue;                \
> +                                    \
> +            dev->event(dev, EV_##type, i, on ? active : 0);    \
> +        }                            \
>     } while (0)
> 
> #ifdef CONFIG_PM



      
