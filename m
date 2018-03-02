From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Thu, 1 Mar 2018 18:32:30 -0800
Message-ID: <20180302023229.GA164361@rodete-desktop-imager.corp.google.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-2-jeffy.chen@rock-chips.com>
 <20180212221309.GA66974@ban.mtv.corp.google.com>
 <5A8FE726.6080903@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5A8FE726.6080903@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com, dianders@google.com, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Fri, Feb 23, 2018 at 06:04:22PM +0800, Jeffy Chen wrote:
> On 02/13/2018 06:13 AM, Brian Norris wrote:
> > > >
> > > >  	if (bdata->gpiod) {
> > > >+		int active_low = gpiod_is_active_low(bdata->gpiod);
> > > >+
> > > >  		if (button->debounce_interval) {
> > > >  			error = gpiod_set_debounce(bdata->gpiod,
> > > >  					button->debounce_interval * 1000);
> > > >@@ -568,6 +572,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> > > >  		isr = gpio_keys_gpio_isr;
> > > >  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
> > > >
> > > >+		switch (button->wakeup_event_action) {
> > > >+		case EV_ACT_ASSERTED:
> > > >+			bdata->wakeup_trigger_type = active_low ?
> > > >+				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
> > > >+			break;
> > > >+		case EV_ACT_DEASSERTED:
> > > >+			bdata->wakeup_trigger_type = active_low ?
> > > >+				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> > > >+			break;
> > What about EV_ACT_ANY? And default case? I think for ANY, we're OK
> > letting suspend/resume not reconfigure the trigger type, but maybe a
> > comment here to note that?
> right, will add comment in the next version.
> > 
> > > >+		}
> > > >  	} else {
> > What about the 'else' case? Shouldn't we try to handle that?
> i think the else case is for irq key, which would generate down and up
> events in one irq, so it would use the same trigger type for all these 3
> cases.

Not necessarily. It uses whatever trigger was provided in
platform/DT/etc. data. You could retrieve that with
irq_get_trigger_type() and try to interpret that. Or you could just
outlaw using that combination (e.g., in the binding documentation).

Brian

> i'll add comment in the next version too.
> > 
> > Brian
> > 
> 
> 
