From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] intel_mid: Keypad Driver
Date: Tue, 8 Feb 2011 09:07:51 -0800
Message-ID: <20110208170751.GA4476@core.coreip.homeip.net>
References: <20110201113513.24707.6283.stgit@bob.linux.org.uk>
 <20110208081941.GD865@core.coreip.homeip.net>
 <20110208125902.1beabf11@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44676 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab1BHRID (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Feb 2011 12:08:03 -0500
Received: by pva4 with SMTP id 4so1160810pva.19
        for <linux-input@vger.kernel.org>; Tue, 08 Feb 2011 09:08:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208125902.1beabf11@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On Tue, Feb 08, 2011 at 12:59:02PM +0000, Alan Cox wrote:
> > There should be only one keymap per device. You can:
> > 
> > 1. Add "direct" keys as an additional row to the main keymap
> > 2. Set up a separate input device for direct keys.
> 
> Ok thats already fixed - the direct keys now use gpio_keys.

Ah, great.

BTW, what about also using matrix_keypad and rotary_encoder (which may
need a bit of adjustments).

> 
> > > +config KEYBOARD_INTEL_MID
> > > +	tristate "Intel MID keypad support"
> > > +	depends on GPIO_LANGWELL
> > > +	help
> > > +	  Say Y if you want support for Intel MID keypad devices
> > > +	  depends on GPIO_LANGWELL
> > > +
> > 
> > To compile this driver as a module...
> 
> Added and put into alpha order (although one or two other entries are
> not ?)

I am trying to keep them arranged but sometimes stuff slips in ;)

> 
> > >  obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
> > > +obj-$(CONFIG_KEYBOARD_INTEL_MID)	+= intel_mid_keypad.o
> > 
> > Alphabetic order please.
> 
> Fixed
> 
> 

[ ...regarding device tructure and it's 'enabled' fields... ]

BTW, I forgot to mention, using of 'bool' for boolean data is
encouraged.

> > > +int __init mrst_keypad_set_pdata(const struct mrst_keypad_platform_data *data)
> > > +{
> > > +	if (mrst_keypad_pdata)
> > > +		return -EBUSY;
> > > +	if (!data)
> > > +		return -EINVAL;
> > > +
> > > +	mrst_keypad_pdata = kmemdup(data, sizeof(*data), GFP_KERNEL);
> > > +	if (!mrst_keypad_pdata)
> > > +		return -ENOMEM;
> > > +
> > 
> > Surely there is a better way...
> 
> The only thing that knows the keypad data for the platform is the
> firmware it's not in the PCI configuration.

Your platform code could still set pci_dev->platform_data, like most of
other drivers that need to pass configuration bits to drivers. I do not
think PCI core touches platform_data...

> 
> > > +			code = MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
> > 
> > Please add reporting of MSC_SCAN as well.
> 
> Already done in the updates by Kristen - I'll send you the 'latest and
> greatest' with the fixes from this after I've got feedback on the
> firmware interface question further down.

OK.


> 
> > > +	err = mrst_keypad_gpio_init(keypad);
> > 
> > Setting up gpios should be part of probe, not open. Just rename
> > mrst_keypad_config() to mrst_keypad_open.
> 
> Done, I'm not aware of anyone muxing those GPIO pins so it should be no
> problem.
> 
> > Should be done in remove(). close() should only shut off the device.
> 
> Done
> 
> > 
> > > +}
> > > +
> > > +static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
> > > +			const struct pci_device_id *ent)
> > > +{
> > > +	struct mrst_keypad *keypad;
> > > +	struct input_dev *input_dev;
> > > +	int error;
> > > +
> > > +	/* Disable flag will turn off keypad support */
> > > +	if (mrst_keypad_pdata && mrst_keypad_pdata->disable)
> > 
> > Why would you have a flag in platform data? If you do not want to use
> > the driver do not compile/load it.
> 
> We need to compile it in for such devices normally, distributions
> require they can build a single image, and only the platform firmware
> knows if it should be enabled (the information isn't in the PCI space)
> 
> I could turn the logic around a bit which might be cleaner - have the
> firmware code export
> 
> 	mrst_keypad_enabled();
> 
> and
> 	mrst_keypad_map();
> 
> ?

If you tie it to platform data then I do not think you even need to have
mrst_keypad_enabled() - platforms that do not want to have driver
enabled won't be using it.

The question is - why would distributions not want to enable the driver
if device is there? Is there other intended users for teh underlying
device? And if so maybe implementing "naked" keypad driver is not the
proper solution and you should have this device as generic GPIO provider
and have board code create platfrom devices to which approprite consumer
drivers (such as matrix_keypad) would bind.

Thanks.

-- 
Dmitry
