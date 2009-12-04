From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
 =?iso-8859-1?q?MSI=A0Windtop?= AE1900-WT
Date: Fri, 4 Dec 2009 16:20:47 +0100
Message-ID: <200912041620.48791.trenn@suse.de>
References: <20091202192603.3e1de98a@destiny.ordissimo> <200912041155.54752.trenn@suse.de> <20091204145102.3c6f1669@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51780 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbZLDPUn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Dec 2009 10:20:43 -0500
In-Reply-To: <20091204145102.3c6f1669@destiny.ordissimo>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Friday 04 December 2009 14:51:02 Anisse Astier wrote:
> On Fri, 4 Dec 2009 11:55:53 +0100, Thomas Renninger <trenn@suse.de> wrote :
> 
> > > 
> > > > +#define dprintk(msg...)	do {			\
> > > Isn't reimplementing some kind of dprintk a little outdated with
> > > DYNAMIC_PRINTK now in kernel?
> > Eh, DYNAMIC_PRINTK?
> > grep DYNAMIC_PRINTK include/linux/ -r
> > is empty...
> 
> My mistake, the option name is actually DYNAMIC_DEBUG, and is named "Enable
> dynamic printk() support" in Kernel Hacking config.
> cf Documentation/dynamic-debug-howto.txt
Good catch.

> > > > +			cur = ktime_get_real();
> > > > +			/* Ignore event if the same event happened in a 50 ms
> > > > +			   timeframe -> Key press may result in 10-20 GPEs */
> > > > +			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
> > > > +			    < 1000 * 50) {
> > > 
...
> I see no problem with the above. It just works fine, whether you use
> get_jiffies or a ktime.
> 
> The thing Dmitry was proposing to do in his review to my patch, is to use a 
> kernel timer (struct timer_list, mod_timer, etc.), and change the algorithm.
> Instead  of having as a reference the first interrupt of (or bounce), you use
> the last one:
> Every time an interrupt is fired, you call mod_timer() to the kick the timer
> further in time(say 20ms). Once you didn't have any interrupt for this given
> period of time, it means your button is stabilized, and the timer will fire 
> your report_input function.

I see these disadvantages:
  - It would be more complicated code
  - You have one extra irq (the one fired by your aimed timer which finally
    does the work)
  - You react after the timeout (+50ms delay).
The latter two are not sever.

The advantage is:
  - If you get constant irqs over the 30ms/50ms timeout, you would still
    only switch once.

But in this HW case, it really should be save with a 50ms timeout and I'd vote
to take the ktime or get_jiffies approach.

> You can see how it's done in drivers/input/keybourd/gpio_keys.c
> 
> > 
> > Beside that (backlight) switching takes some time, but this should not
> > be due to above "debouncing".
> Yep, I noticed that as well.
> I verified, backlight behave the same in Windows. Slow switch, and just 6
> levels.
Thanks!

I'd prefer if Len could take on top patches, I don't want to touch this
again any time soon if not necessary.

    Thomas
