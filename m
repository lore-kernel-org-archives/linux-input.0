From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms: Implement KDB debug hooks for
 nouveau KMS.
Date: Fri, 24 Sep 2010 21:08:24 -0700
Message-ID: <20100925040824.GB25773@core.coreip.homeip.net>
References: <1283335002.2741.5.camel@maxim-laptop>
 <4C7E3A73.5070503@windriver.com>
 <1283424363.2736.1.camel@maxim-laptop>
 <1285119735.5949.5.camel@maxim-laptop>
 <1285164198.3159.8.camel@maxim-laptop>
 <1285164387.3159.10.camel@maxim-laptop>
 <1285175225.2960.10.camel@maxim-laptop>
 <1285361406.4509.0.camel@maxim-laptop>
 <4C9D10F3.10105@windriver.com>
 <1285373672.26629.8.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39884 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab0IYEIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Sep 2010 00:08:30 -0400
Received: by pzk34 with SMTP id 34so794065pzk.19
        for <linux-input@vger.kernel.org>; Fri, 24 Sep 2010 21:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285373672.26629.8.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, Chris Ball <cjb@laptop.org>, David Airlie <airlied@linux.ie>, kgdb-bugreport@lists.sourceforge.net, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-input <linux-input@vger.kernel.org>

On Sat, Sep 25, 2010 at 02:14:32AM +0200, Maxim Levitsky wrote:
> On Fri, 2010-09-24 at 15:58 -0500, Jason Wessel wrote:
> > On 09/24/2010 03:50 PM, Maxim Levitsky wrote:
> > >   
> > >> [Dropped nouveau list, because this is offtopic there]
> > >>
> > >> I pretty much got to the bottom of this.
> > >> There are 2 separate issues:
> > >>
> > >>
> > >> 1. SysRq handler is now a input 'filter', which means that it can 'eat'
> > >> input events, so they don't show up on input bus.
> > >> It does so while sysrq key is down.
> > >> So sysrq and 'g' events never reach the kernel kbd driver and therefore
> > >> the hack to release them doesn't work.
> > >>
> > >> 2. The kbd_clear_keys_helper injects the keyup events alright, but it
> > >> doesn't inject SYN events, and therefore X evdev driver doesn't pick
> > >> these injected events untill next SYN event. 
> > >>
> > >> This patch makes key release work in expense of showing sysrq key to userspace, which isn't that good,
> > >> because now Alt+SysRQ causes a screen capture by default.
> > >> In my opinion the sysrq filter should stay.
> > >> We should just make kdb hook into atkbd and do the key release there.
> > >> This should both result in cleaner/more robust code, and make this issue disappear.
> > >> I'll look at doing that.
> > >>
> > >>
> > >> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> > >> index 0c6c641..7df6af5 100644
> > >> --- a/drivers/char/keyboard.c
> > >> +++ b/drivers/char/keyboard.c
> > >> @@ -368,6 +368,7 @@ static int kbd_clear_keys_helper(struct input_handle *handle, void *data)
> > >>  {
> > >>  	unsigned int *keycode = data;
> > >>  	input_inject_event(handle, EV_KEY, *keycode, 0);
> > >> +	input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
> > >>  	return 0;
> > >>  }
> > >>  
> > >> diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
> > >> index ef31bb8..db1eb12 100644
> > >> --- a/drivers/char/sysrq.c
> > >> +++ b/drivers/char/sysrq.c
> > >> @@ -601,7 +601,7 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
> > >>  	}
> > >>  
> > >>  out:
> > >> -	return sysrq_down;
> > >> +	return 0;
> > >>  }
> > >>  
> > >>  static int sysrq_connect(struct input_handler *handler,
> > >>
> > >>
> > >> Best regards,
> > >> 	Maxim Levitsky
> > >>
> > >>     
> > 
> > Hi Maxim,
> > 
> > Is it the case that this patch takes care of masking the sysrq event
> > from user space?
> > 
> > Originally before it became an input filter I had a patch to the
> > keyboard.c to completely consume the keypress of the sysrq-g.
> > 
> > I have been less than successful at getting the keyboard changes
> > upstreamed, and I was probably going to ping AKPM, because on that front
> > I had not received any kind of response either (linux-input that is).
> > 
> > Certainly I can carry your patch in my branch until we can determine a
> > final upstream design.
> 
> Its an option, but bear in the mind that my 'patch' causes very
> unpleasant regression.
> The regression is that now Alt+SysRQ is reported to userspace and
> treated as a PrintScreen which in gnome is treated as a launcher for
> screenshot application.
> So after you pressed it, you will end up with an army of
> gnome-screenshots poping up.
> So I think that tty kbd driver is wrong place for key release.
> 

Agree.

> The right solution in my opinion is to make atkbd register with kgdb and
> provide to it, the polling keyboard IO services, and also take care of
> releasing the keys as soon as debug mode is entered or exited.

Disagree. We may support different keyboard devices with kdb or use one
keyboard (USB) to drop into debugger and then switch to atkbd...

I think we need to move Jason's code from drivers/char/keyboard.c to
drivers/char/sysrq.c and have it track keys that have been kept pressed
before entering sysrq mode and release them when leaving the mode.

We also need to teach sysrq that some handlers need resetting of the
keyboard state.

> 
> Btw, can a driver register a hook into kgdb to be executed on
> enter/leave of the debug mode?
> If so the atkbd driver should just do that.
> 
> I am also aware of the fact that atkbd doesn't talk to hardware
> directly.
> Thus 'the' proper fix is also to add a polled serio handlers, make atkbd
> use them
> if available and if so, register with the kgdb.

The issue is not that interrupts are not available but that we are
holding too many locks...

-- 
Dmitry
