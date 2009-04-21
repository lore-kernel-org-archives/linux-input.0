From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] [ARM] pxa: lx: add keyboard driver
Date: Mon, 20 Apr 2009 19:15:24 -0700
Message-ID: <20090421021524.GA13617@dtor-d630.eng.vmware.com>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com> <20090420110640.GC3653@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:9375 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZDUCPd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 22:15:33 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1214630wah.21
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2009 19:15:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090420110640.GC3653@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

On Mon, Apr 20, 2009 at 12:06:40PM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 18, 2009 at 04:10:28PM -0700, Dmitry Torokhov wrote:
> > > +config KEYBOARD_LX
> > > +	tristate "LX Keyboard support"
> > > +	depends on MACH_NETBOOKPRO && INPUT && INPUT_KEYBOARD
> > 
> > Dependancy on INPUT_KEYBOARD is not needed, strictly speaking.
> > INPUT_KEYBOARD is only [menu]config syntactic sugar, there is no meat
> > behind the option.
> 
> Gone.
> 
> > > +
> > > +	/*
> > > +	 * Some keys have additional operations after we have
> > > +	 * decoded them.  We don't report these "special" keys
> > > +	 * to the input layer.
> > > +	 */
> > > +	switch (key) {
> > > +	case KEY_BRIGHTNESSUP:
> > > +	case KEY_BRIGHTNESSDOWN:
> > > +		input_event(kbd, EV_PWR, key, !up);
> > 
> > Umm... some userspace apps might still want to get these. Strictly
> > speaking KEY_* codes belong to EV_KEY namespace.
> 
> Maybe, if someone wants it I guess they can modify the driver.
> 

OK.

> > > +static void lx_keyb_reset(struct input_dev *kbd)
> > > +{
> > > +	unsigned char *map;
> > > +	int key;
> > > +
> > > +	for (key = 0; key < LX_NUMKEYCODES; key++)
> > > +		if (keystate[key] & KP_DOWN) {
> > > +			map = normal_map;
> > > +			if (keystate[key] & KP_FN)
> > > +				map = fn_map;
> > > +			else if (keystate[key] & KP_NUMLCK)
> > > +				map = numlck_map;
> > > +			keystate[key] = KP_NONE;
> > > +			input_report_key(kbd, map[key], 0);
> > > +		}
> > 
> > Why don't you just send 'up' event for all known keys? Input core will
> > filter out the ones that have not been 'down'ed... Better yet, don't do
> > anything here, I should finish adding forced release at suspend/resume
> > to the input core shortly.
> 
> I'll leave it as is until you've decided what to do with the input core.
>

Fair enough.

> > > +static void lx_keyb_write(void *data, unsigned int addr, unsigned char val)
> > > +{
> > > +	struct input_dev *kbd = data;
> > 
> > Blank line between variables and the code is always appreciated ;)
> 
> Added.
> 
> > > +	kbd->name        = "LX Keyboard";
> > > +	kbd->phys        = "pcon/input0";
> > > +	kbd->dev.parent  = &dev->dev;
> > > +	kbd->evbit[0]    = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> > > +			   BIT_MASK(EV_PWR);
> > > +	kbd->keycode     = normal_map;
> > > +	kbd->keycodesize = sizeof(unsigned char);
> > > +	kbd->keycodemax  = ARRAY_SIZE(normal_map);
> > > +
> > 
> > So we have 3 keymaps but only one can be changed form userspace... I
> > suppose it is OK given how special the other 2 keymaps are. Or we could
> > provide an alternative {get,set}keycode methods.
> 
> Yes, not sure what to do about those.  It is a rather specialised
> keyboard in itself, so the standard maps wouldn't work with it.
> 
> The other issue here is that changing what's published may break the
> existing userspace (and since I didn't take a copy of the userspace
> build for this platform before the server was taken down, that could
> present something of a problem resulting in my use of the device being
> crippled.)  Let's leave it as is and if someone does want to change it
> later...
> 

I did not mean we would change anything as far as default setup is
concerned and is visible from userspace; it would be all internal
adjustment that would also allow changing numlck_map and fn_map mapping
in addition to changing normal_map. I will just put it on my TODO
list...

> > > +static int __init lx_keyb_init(void)
> > > +{
> > > +	printk(KERN_INFO "LX Keyboard Driver, (c) 2004 Simtec Electronics\n");
> > 
> > Is this needed? Input core will already add printk when input device is
> > added and our boot is already chatty enough...
> 
> As mentioned in the other mail, now removed.

Thanks.

-- 
Dmitry
