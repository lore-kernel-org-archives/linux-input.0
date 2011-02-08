From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] intel_mid: Keypad Driver
Date: Tue, 8 Feb 2011 12:59:02 +0000
Message-ID: <20110208125902.1beabf11@lxorguk.ukuu.org.uk>
References: <20110201113513.24707.6283.stgit@bob.linux.org.uk>
	<20110208081941.GD865@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57474 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753516Ab1BHMz2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Feb 2011 07:55:28 -0500
In-Reply-To: <20110208081941.GD865@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> There should be only one keymap per device. You can:
> 
> 1. Add "direct" keys as an additional row to the main keymap
> 2. Set up a separate input device for direct keys.

Ok thats already fixed - the direct keys now use gpio_keys.

> > +config KEYBOARD_INTEL_MID
> > +	tristate "Intel MID keypad support"
> > +	depends on GPIO_LANGWELL
> > +	help
> > +	  Say Y if you want support for Intel MID keypad devices
> > +	  depends on GPIO_LANGWELL
> > +
> 
> To compile this driver as a module...

Added and put into alpha order (although one or two other entries are
not ?)

> >  obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
> > +obj-$(CONFIG_KEYBOARD_INTEL_MID)	+= intel_mid_keypad.o
> 
> Alphabetic order please.

Fixed


> > +int __init mrst_keypad_set_pdata(const struct mrst_keypad_platform_data *data)
> > +{
> > +	if (mrst_keypad_pdata)
> > +		return -EBUSY;
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	mrst_keypad_pdata = kmemdup(data, sizeof(*data), GFP_KERNEL);
> > +	if (!mrst_keypad_pdata)
> > +		return -ENOMEM;
> > +
> 
> Surely there is a better way...

The only thing that knows the keypad data for the platform is the
firmware it's not in the PCI configuration.

> > +			code = MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
> 
> Please add reporting of MSC_SCAN as well.

Already done in the updates by Kristen - I'll send you the 'latest and
greatest' with the fixes from this after I've got feedback on the
firmware interface question further down.

> > +	err = mrst_keypad_gpio_init(keypad);
> 
> Setting up gpios should be part of probe, not open. Just rename
> mrst_keypad_config() to mrst_keypad_open.

Done, I'm not aware of anyone muxing those GPIO pins so it should be no
problem.

> Should be done in remove(). close() should only shut off the device.

Done

> 
> > +}
> > +
> > +static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
> > +			const struct pci_device_id *ent)
> > +{
> > +	struct mrst_keypad *keypad;
> > +	struct input_dev *input_dev;
> > +	int error;
> > +
> > +	/* Disable flag will turn off keypad support */
> > +	if (mrst_keypad_pdata && mrst_keypad_pdata->disable)
> 
> Why would you have a flag in platform data? If you do not want to use
> the driver do not compile/load it.

We need to compile it in for such devices normally, distributions
require they can build a single image, and only the platform firmware
knows if it should be enabled (the information isn't in the PCI space)

I could turn the logic around a bit which might be cleaner - have the
firmware code export

	mrst_keypad_enabled();

and
	mrst_keypad_map();

?

> > +		return 0;
> > +
> > +	error = pci_enable_device(pdev);
> > +	if (error || (pdev->irq < 0)) {
> 
> Extra parenthesis.

Already fixed - along with the fact 0 isn't valid.


> If you move pci_set_drvdata() here you won't need to clear it in error
> path.

Fixed

> > +	if (input_dev)
> 
> No need to check.
> 
> > +		input_free_device(input_dev);
> > +	kfree(keypad);

Ok didn't realise input_free_device(NULL) was guaranteed valid

> Begs for a function as is called in several places.

Fixed

> > +	.remove		= __devexit_p(mrst_keypad_remove),
> > +#ifdef CONFIG_PM
> > +	.suspend	= NULL,
> > +	.resume	= NULL,
> 
> Why?

PM is added in the newest version so that goes sane

