From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Tue, 13 Jan 2009 21:42:25 -0800
Message-ID: <20090113213534.ZZRA012@mailhub.coreip.homeip.net>
References: <200812071159.50267.david-b@pacbell.net> <20090112220448.ZZRA012@mailhub.coreip.homeip.net> <200901130142.57407.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:41298 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbZANFnJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 00:43:09 -0500
Received: by qyk4 with SMTP id 4so552031qyk.13
        for <linux-input@vger.kernel.org>; Tue, 13 Jan 2009 21:43:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200901130142.57407.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-input@vger.kernel.org

On Tue, Jan 13, 2009 at 01:42:56AM -0800, David Brownell wrote:
> On Monday 12 January 2009, Dmitry Torokhov wrote:
> > ...
> > > Depends on the patch for the parent MFD driver, and won't work
> > > without the patch making GPIO IRQs work on dm355.
> > > 
> > > NOTE:  not suitable for mainline until the dm355evm board support
> > > (and parent MFD driver) is in the merge queue.
> > > 
> > 
> > It looks like the MFD driver was merged so we need to start wokring
> > on this one :)
> 
> Much to my surprise!  :)
> 
> 
> > > +		dev_dbg(&keys->pdev->dev,
> > > +			"input event 0x%04x--> keycode %d\n",
> > > +			event, keycode);
> > > +
> > > +		/* Report press + release ... we can't tell if
> > > +		 * this is an autorepeat, and we need to guess
> > > +		 * about the release.
> > > +		 */
> > > +		input_report_key(keys->input, keycode, 1);
> > 
> > input_sync() is also needed here.
> > 
> > > +		input_report_key(keys->input, keycode, 0);
> > > +	}
> > > +	input_sync(keys->input);
> 
> If so, then the existing input_sync() needs to move up
> a few lines too ... I had thought that the "sync" was
> like with a filesystem, where lots of events could be
> batched, but evidently not.
> 

It is and they can. The idea is that userspace accumulates input events
until it gets the sync event which signals that as full as possible
hardware state was transmitted. The problem with keys is that if
userspace really does accumulate events the 2 down/up in succession will
cancel each other. There are really 2 separate states - button pressed
and button released which should be accompanied with its own sync. But
if you were reposting several buttons at once they could all "share" the
same sync event. Does it make any sense to you?

> 
> > > +}
> > > +
> > > +static int dm355evm_setkeycode(struct input_dev *dev, int index, int keycode)
> > > +{
> > > +	if (index >= ARRAY_SIZE(dm355evm_keys))
> > > +		return -EINVAL;
> > > +
> > > +	dm355evm_keys[index].keycode = keycode;
> > 
> > You also need to alter dev->keybit to indicate that device may generate
> > new keycode, otherwise input core will drop event intead of passing it
> > on.
> 
> Should something then be scrubbing out dev->keybit to
> indicate the *old* key code is no longer reported?
> (After verifying that no other button reports it.)
> 

Yes, that is responsibility of the setkeycode method as well.

> 
> > Also I prefer devices that support remapping to keep their copy of 
> > keymap so in unlikely case there are 2 devices in the system they can
> > have separate keymaps.
> 
> That's physically impossible in this case.
> 

Ah, OK.

> 
> > > +	input->evbit[0] = BIT(EV_KEY);
> > > +	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++)
> > > +		set_bit(dm355evm_keys[i].keycode, input->keybit);
> > > +
> > > +	input->keycodemax = ARRAY_SIZE(dm355evm_keys);
> > > +	input->keycodesize = sizeof(dm355evm_keys[0]);
> > 
> > You don't need to setup keycodesize and keycodemax since you provide
> > your own get and set keycode helpers.
> 
> ... which I'm presuming is the right thing to do.  It's
> a bit surprising to see that the input core will then
> have no way to tell what keycodes are valid other than
> querying all possible codes!
> 

It knows keycodes but not scancodes (or their equivalent). Given that
many (most?) keympas are sparse input core does not really know whether
a value is a valid scancode or not even if it is within the range of
input->keycodemax. COnsider HID - its 'scancodes' are 64 bits ;) 

>  
> > > +	/* start reporting events */
> > > +	status = request_irq(keys->irq, dm355evm_keys_irq,
> > > +			IRQF_TRIGGER_FALLING,
> > > +			dev_name(&pdev->dev), keys);
> > > +	if (status < 0) {
> > > +		input_unregister_device(input);
> > > +		goto fail1;
> > 
> > You should not call input_free_device() after input_unregister_device().
> > Either jump to "fail0" or do "input = NULL;".
> 
> "goto fail0" seems much simpler.  :)
> 

So you will be sending an update, right?

Thanks!

-- 
Dmitry
