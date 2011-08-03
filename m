From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 3 Aug 2011 20:24:46 +0100
Message-ID: <CAMLZHHQAjarobktUFiZF7aEVvLuaaAFSBuzrMj4pT_67BFssjA@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50377 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1HCTYr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 15:24:47 -0400
Received: by gxk21 with SMTP id 21so664539gxk.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 12:24:47 -0700 (PDT)
In-Reply-To: <20110803184332.GA17880@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

On Wed, Aug 3, 2011 at 7:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> No, I do not believe we can do what you are doing in input core. You are
> changing behavior for one platform and one (or 2 drivers) that will not
> be matched (at least I don't think so) by anything else out there. What
> will happen if you plug a random USB keyboard into OLPC box? Will it keep
> leds powered?

In all other cases, behaviour is unchanged. The input device is not
marked as wakeup capable, therefore the user cannot mark it as
wakeup-enabled, therefore this code does not execute.

So a USB keyboard on an OLPC laptop would behave exactly as it does
before this patch, as would devices on other systems.

The only way this functionality gets enabled is at the code level (as
it does in patch 2/2), and then once the user has requested wakeups on
all devices in the chain.

>> > Does the controller wakes up the system on key release or only press? My
>> > concern is with cases when we suspend with a key pressed and wake up
>> > with it already released.
>>
>> It wakes up on key press, but our EC buffers communication, so both
>> the key press and key release event would be delivered in the above
>> scenario.
>
> Just to confirm, we 3 events will be delivered in this case:

Sorry, I misunderstood the question and answered "what happens if the
system is sleeping and you press and quickly release a key before the
system is fully running" - in which case the system wakes up and
delivers both events.

For the question you asked, regarding a key being pressed as the
system goes into suspend, the system wakes up from suspend
immediately.
I just tested this by holding the 'i' key down while going into suspend.
While the key is being held down, the system receives repeated
interrupts with data 0x17 ('i' key pressed). The system suspends, but
then immediately wakes up, and continues the flood of 0x17 interrupts.
When I release the key a few seconds later, a 0x97 ('i' released)
interrupt arrives.

I guess the more accurate way to describe the wakeup condition is that
it wakes up on any i8042 interrupt.

> I also wonder what will happen with non-PS2 devices...

Again - other devices are not affected.

> Instead of wiring it all through input core could we contain this in
> atkbd and hgpk by registering pm_notifiers and ignoring certain requests
> from input/serio cores during system state transition on OLPC only?

I'll look into this, thanks for the suggestion.

Daniel
