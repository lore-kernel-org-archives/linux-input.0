From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] [ARM] pxa: lx: add keyboard driver
Date: Mon, 20 Apr 2009 12:06:40 +0100
Message-ID: <20090420110640.GC3653@n2100.arm.linux.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42733 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbZDTLGt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 07:06:49 -0400
Content-Disposition: inline
In-Reply-To: <20090418231018.GA32346@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

On Sat, Apr 18, 2009 at 04:10:28PM -0700, Dmitry Torokhov wrote:
> > +config KEYBOARD_LX
> > +	tristate "LX Keyboard support"
> > +	depends on MACH_NETBOOKPRO && INPUT && INPUT_KEYBOARD
> 
> Dependancy on INPUT_KEYBOARD is not needed, strictly speaking.
> INPUT_KEYBOARD is only [menu]config syntactic sugar, there is no meat
> behind the option.

Gone.

> > +
> > +	/*
> > +	 * Some keys have additional operations after we have
> > +	 * decoded them.  We don't report these "special" keys
> > +	 * to the input layer.
> > +	 */
> > +	switch (key) {
> > +	case KEY_BRIGHTNESSUP:
> > +	case KEY_BRIGHTNESSDOWN:
> > +		input_event(kbd, EV_PWR, key, !up);
> 
> Umm... some userspace apps might still want to get these. Strictly
> speaking KEY_* codes belong to EV_KEY namespace.

Maybe, if someone wants it I guess they can modify the driver.

> > +static void lx_keyb_reset(struct input_dev *kbd)
> > +{
> > +	unsigned char *map;
> > +	int key;
> > +
> > +	for (key = 0; key < LX_NUMKEYCODES; key++)
> > +		if (keystate[key] & KP_DOWN) {
> > +			map = normal_map;
> > +			if (keystate[key] & KP_FN)
> > +				map = fn_map;
> > +			else if (keystate[key] & KP_NUMLCK)
> > +				map = numlck_map;
> > +			keystate[key] = KP_NONE;
> > +			input_report_key(kbd, map[key], 0);
> > +		}
> 
> Why don't you just send 'up' event for all known keys? Input core will
> filter out the ones that have not been 'down'ed... Better yet, don't do
> anything here, I should finish adding forced release at suspend/resume
> to the input core shortly.

I'll leave it as is until you've decided what to do with the input core.

> > +static void lx_keyb_write(void *data, unsigned int addr, unsigned char val)
> > +{
> > +	struct input_dev *kbd = data;
> 
> Blank line between variables and the code is always appreciated ;)

Added.

> > +	kbd->name        = "LX Keyboard";
> > +	kbd->phys        = "pcon/input0";
> > +	kbd->dev.parent  = &dev->dev;
> > +	kbd->evbit[0]    = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> > +			   BIT_MASK(EV_PWR);
> > +	kbd->keycode     = normal_map;
> > +	kbd->keycodesize = sizeof(unsigned char);
> > +	kbd->keycodemax  = ARRAY_SIZE(normal_map);
> > +
> 
> So we have 3 keymaps but only one can be changed form userspace... I
> suppose it is OK given how special the other 2 keymaps are. Or we could
> provide an alternative {get,set}keycode methods.

Yes, not sure what to do about those.  It is a rather specialised
keyboard in itself, so the standard maps wouldn't work with it.

The other issue here is that changing what's published may break the
existing userspace (and since I didn't take a copy of the userspace
build for this platform before the server was taken down, that could
present something of a problem resulting in my use of the device being
crippled.)  Let's leave it as is and if someone does want to change it
later...

> > +static int __init lx_keyb_init(void)
> > +{
> > +	printk(KERN_INFO "LX Keyboard Driver, (c) 2004 Simtec Electronics\n");
> 
> Is this needed? Input core will already add printk when input device is
> added and our boot is already chatty enough...

As mentioned in the other mail, now removed.
