From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 17 Aug 2011 00:03:51 -0700
Message-ID: <20110817070351.GE29361@core.coreip.homeip.net>
References: <20110802154916.624619D401C@zog.reactivated.net>
 <20110803065920.GC23399@core.coreip.homeip.net>
 <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
 <20110803184332.GA17880@core.coreip.homeip.net>
 <CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw@mail.gmail.com>
 <CAMLZHHTie_u40NZ40o+LCwffk=3LbY96YTwxQt5wcVtbTc53qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48525 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab1HQHD7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 03:03:59 -0400
Received: by gya6 with SMTP id 6so533344gya.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 00:03:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMLZHHTie_u40NZ40o+LCwffk=3LbY96YTwxQt5wcVtbTc53qg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

Hi Daniel,

On Thu, Aug 11, 2011 at 07:02:17PM +0100, Daniel Drake wrote:
> Hi Dmitry,
> 
> On Fri, Aug 5, 2011 at 4:24 PM, Daniel Drake <dsd@laptop.org> wrote:
> > I've started looking at this, but my first problem is that when the
> > input layer asks atkbd to turn off LEDs, atkbd schedules a workqueue
> > item to undertake this work. However, as there is no synchronization,
> > this work only seems to get executed during or after system resume.
> > This makes it hard to catch with such a scheme. Any ideas?
> 
> I've looked closer, and am keeping my eyes open for other options too.
> 
> During suspend of the input layer, input_dev_suspend() calls
> input_dev_toggle(dev, false) which turns off LEDs and sounds.
> 
> On the XO laptops, we don't have LEDs, nor sounds, and we don't have
> num lock, scroll lock or caps lock keys. So the suspend code does
> nothing - there are no lights to turn off. So far so good.
> 
> Moving to the resume case: input_dev_resume() calls
> input_reset_device(). This calls input_dev_toggle(dev, true), which
> asks atkbd to turn the non-existent keyboard LEDs off. I guess this is
> harmless and is unlikely to be the cause of the problems which led us
> to need to disable this code in light of the following:
> 
> After calling input_dev_toggle(), input_dev_resume() does this:
> 
> 		/*
> 		 * Keys that have been pressed at suspend time are unlikely
> 		 * to be still pressed when we resume.
> 		 */
> 		spin_lock_irq(&dev->event_lock);
> 		input_dev_release_keys(dev);
> 		spin_unlock_irq(&dev->event_lock);
> 
> We definitely don't want this to happen in our case, where we have
> maintained full control and power of the device during suspend/resume.
> 
> This particular important code snippet would not even have been
> disabled by your suggestion of blocking data transfer at the
> i8042-level.
> 
> So, I think we need a new approach at solving this, and I think it has
> to be one that interacts at the input_dev layer.

OK, so we have the following scenario:

- we do not need to worry about SND and LED on OLPC;

- we do not need to worry about releasing the key that was pressed
  when we went to sleep because they system would not go to sleep while
  there is a key pressed. So the code in input_dev_resume() won't
  actually release any keys unless a key was held pressed and we forced
  system to sleep somehow.

- we need to make sure we do not loose key press (and following events)
  when we are waking up.

Can atkbd driver stash away serio byte data (when not in command mode)
and replay it when pm notifier signals us that resume process is done?

Thanks.

-- 
Dmitry
