From: Anisse Astier <anisse@astier.eu>
Subject: Re: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
  =?UTF-8?B?TVNJwqBXaW5kdG9w?= AE1900-WT
Date: Fri, 4 Dec 2009 14:51:02 +0100
Message-ID: <20091204145102.3c6f1669@destiny.ordissimo>
References: <20091202192603.3e1de98a@destiny.ordissimo>
	<200912031749.08734.trenn@suse.de>
	<20091204111506.254dccef@destiny.ordissimo>
	<200912041155.54752.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:28683 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbZLDNwk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 08:52:40 -0500
In-Reply-To: <200912041155.54752.trenn@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, 4 Dec 2009 11:55:53 +0100, Thomas Renninger <trenn@suse.de> wrote :

> > 
> > > +#define dprintk(msg...)	do {			\
> > Isn't reimplementing some kind of dprintk a little outdated with
> > DYNAMIC_PRINTK now in kernel?
> Eh, DYNAMIC_PRINTK?
> grep DYNAMIC_PRINTK include/linux/ -r
> is empty...

My mistake, the option name is actually DYNAMIC_DEBUG, and is named "Enable
dynamic printk() support" in Kernel Hacking config.
cf Documentation/dynamic-debug-howto.txt

> > > +			cur = ktime_get_real();
> > > +			/* Ignore event if the same event happened in a 50 ms
> > > +			   timeframe -> Key press may result in 10-20 GPEs */
> > > +			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
> > > +			    < 1000 * 50) {
> > 
> > You're debouncing by computing the time difference instead of using
> > a kernel timer.
> Do you see a problem with above?
> You mean ktime_get_real() reads our the time via get getnstimeofday and
> accessing IO, while your get_jiffies_64() solution reads out a kernel variable
> incremented via timer irq which is a better solution?
> While gettimeofday should be a fast TSC read on modern HW, I still have
> to agree.
> 
> Testing this I saw ~5-25 IRQs per key hit, showing up in about a ~30ms
> time frame, therefore I took 50ms ignoring the same IRQ and it worked out
> fine. Your last_time_pressed timeout of 10ms might be a bit too short...
I see no problem with the above. It just works fine, whether you use
get_jiffies or a ktime. 

The thing Dmitry was proposing to do in his review to my patch, is to use a 
kernel timer (struct timer_list, mod_timer, etc.), and change the algorithm.
Instead  of having as a reference the first interrupt of (or bounce), you use
the last one:
Every time an interrupt is fired, you call mod_timer() to the kick the timer
further in time(say 20ms). Once you didn't have any interrupt for this given
period of time, it means your button is stabilized, and the timer will fire 
your report_input function.

You can see how it's done in drivers/input/keybourd/gpio_keys.c

> 
> Beside that (backlight) switching takes some time, but this should not
> be due to above "debouncing".
Yep, I noticed that as well.
I verified, backlight behave the same in Windows. Slow switch, and just 6
levels.


Anisse

