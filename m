From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v1 PATCH 3/6] led: pmic8058: Add PMIC8058 leds driver
Date: Wed, 10 Nov 2010 15:28:41 -0800
Message-ID: <20101110232840.GA2121@core.coreip.homeip.net>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org>
 <1289393281-4459-4-git-send-email-tsoni@codeaurora.org>
 <4CDB0451.3090303@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CDB0451.3090303@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 10, 2010 at 09:45:05PM +0100, Lars-Peter Clausen wrote:
> Trilok Soni wrote:
> > +
> > +static void led_kp_set(struct pmic8058_led_data *led, enum led_brightness value)
> > +{
> > +	int rc;
> > +	u8 level;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&led->value_lock, flags);
> This function is only ever called from within the workqueue so there is no need for
> locking.
> 

That is a common misconception, unfortunately. The same work may
be executing on several CPUs at the same time if it was scheduled on
multi-threaded work queue.

...

> > +	schedule_work(&led->work);

And sure enough, keventd is such workqueue.

Now, whether having the same work run simultaneously is OK or not is a
different question altogether...

-- 
Dmitry
