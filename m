From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 3 Aug 2011 12:38:14 -0700
Message-ID: <20110803193814.GA17944@core.coreip.homeip.net>
References: <20110802154916.624619D401C@zog.reactivated.net>
 <20110803065920.GC23399@core.coreip.homeip.net>
 <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
 <20110803184332.GA17880@core.coreip.homeip.net>
 <CAMLZHHQAjarobktUFiZF7aEVvLuaaAFSBuzrMj4pT_67BFssjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57558 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1HCTiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 15:38:21 -0400
Received: by ywn13 with SMTP id 13so669688ywn.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 12:38:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMLZHHQAjarobktUFiZF7aEVvLuaaAFSBuzrMj4pT_67BFssjA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

On Wed, Aug 03, 2011 at 08:24:46PM +0100, Daniel Drake wrote:
> On Wed, Aug 3, 2011 at 7:43 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > No, I do not believe we can do what you are doing in input core. You are
> > changing behavior for one platform and one (or 2 drivers) that will not
> > be matched (at least I don't think so) by anything else out there. What
> > will happen if you plug a random USB keyboard into OLPC box? Will it keep
> > leds powered?
> 
> In all other cases, behaviour is unchanged. The input device is not
> marked as wakeup capable, therefore the user cannot mark it as
> wakeup-enabled, therefore this code does not execute.
> 
> So a USB keyboard on an OLPC laptop would behave exactly as it does
> before this patch, as would devices on other systems.
> 
> The only way this functionality gets enabled is at the code level (as
> it does in patch 2/2), and then once the user has requested wakeups on
> all devices in the chain.

I believe we can and do mark devices such as USB as wakeup capable on
other arches, you do not have control here. That is why I am uneasy with
doing this in input core.

> 
> >> > Does the controller wakes up the system on key release or only press? My
> >> > concern is with cases when we suspend with a key pressed and wake up
> >> > with it already released.
> >>
> >> It wakes up on key press, but our EC buffers communication, so both
> >> the key press and key release event would be delivered in the above
> >> scenario.
> >
> > Just to confirm, we 3 events will be delivered in this case:
> 
> Sorry, I misunderstood the question and answered "what happens if the
> system is sleeping and you press and quickly release a key before the
> system is fully running" - in which case the system wakes up and
> delivers both events.
> 
> For the question you asked, regarding a key being pressed as the
> system goes into suspend, the system wakes up from suspend
> immediately.
> I just tested this by holding the 'i' key down while going into suspend.
> While the key is being held down, the system receives repeated
> interrupts with data 0x17 ('i' key pressed). The system suspends, but
> then immediately wakes up, and continues the flood of 0x17 interrupts.
> When I release the key a few seconds later, a 0x97 ('i' released)
> interrupt arrives.

Is there any keys that are not autorepeating. For example regular
(non-OLPC) laptops usually do not repeat suspend and other special keys.
In fact, they quite often forget to send release events for them ;)

> 
> I guess the more accurate way to describe the wakeup condition is that
> it wakes up on any i8042 interrupt.
> 
> > I also wonder what will happen with non-PS2 devices...
> 
> Again - other devices are not affected.
> 
> > Instead of wiring it all through input core could we contain this in
> > atkbd and hgpk by registering pm_notifiers and ignoring certain requests
> > from input/serio cores during system state transition on OLPC only?
> 
> I'll look into this, thanks for the suggestion.

Much appreciated, sorry for being a pain.

-- 
Dmitry
