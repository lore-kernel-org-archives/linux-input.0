From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Thu, 11 Aug 2011 19:02:17 +0100
Message-ID: <CAMLZHHTie_u40NZ40o+LCwffk=3LbY96YTwxQt5wcVtbTc53qg@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
	<CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56658 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1HKSCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2011 14:02:18 -0400
Received: by yie30 with SMTP id 30so1488885yie.19
        for <linux-input@vger.kernel.org>; Thu, 11 Aug 2011 11:02:17 -0700 (PDT)
In-Reply-To: <CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

Hi Dmitry,

On Fri, Aug 5, 2011 at 4:24 PM, Daniel Drake <dsd@laptop.org> wrote:
> I've started looking at this, but my first problem is that when the
> input layer asks atkbd to turn off LEDs, atkbd schedules a workqueue
> item to undertake this work. However, as there is no synchronization,
> this work only seems to get executed during or after system resume.
> This makes it hard to catch with such a scheme. Any ideas?

I've looked closer, and am keeping my eyes open for other options too.

During suspend of the input layer, input_dev_suspend() calls
input_dev_toggle(dev, false) which turns off LEDs and sounds.

On the XO laptops, we don't have LEDs, nor sounds, and we don't have
num lock, scroll lock or caps lock keys. So the suspend code does
nothing - there are no lights to turn off. So far so good.

Moving to the resume case: input_dev_resume() calls
input_reset_device(). This calls input_dev_toggle(dev, true), which
asks atkbd to turn the non-existent keyboard LEDs off. I guess this is
harmless and is unlikely to be the cause of the problems which led us
to need to disable this code in light of the following:

After calling input_dev_toggle(), input_dev_resume() does this:

		/*
		 * Keys that have been pressed at suspend time are unlikely
		 * to be still pressed when we resume.
		 */
		spin_lock_irq(&dev->event_lock);
		input_dev_release_keys(dev);
		spin_unlock_irq(&dev->event_lock);

We definitely don't want this to happen in our case, where we have
maintained full control and power of the device during suspend/resume.

This particular important code snippet would not even have been
disabled by your suggestion of blocking data transfer at the
i8042-level.

So, I think we need a new approach at solving this, and I think it has
to be one that interacts at the input_dev layer.

Thoughts?

Thanks,
Daniel
