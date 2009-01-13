From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Tue, 13 Jan 2009 01:42:56 -0800
Message-ID: <200901130142.57407.david-b@pacbell.net>
References: <200812071159.50267.david-b@pacbell.net> <20090112220448.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:43125 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752816AbZAMJnA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 04:43:00 -0500
In-Reply-To: <20090112220448.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-input@vger.kernel.org

On Monday 12 January 2009, Dmitry Torokhov wrote:
> ...
> > Depends on the patch for the parent MFD driver, and won't work
> > without the patch making GPIO IRQs work on dm355.
> > 
> > NOTE:  not suitable for mainline until the dm355evm board support
> > (and parent MFD driver) is in the merge queue.
> > 
> 
> It looks like the MFD driver was merged so we need to start wokring
> on this one :)

Much to my surprise!  :)


> > +		dev_dbg(&keys->pdev->dev,
> > +			"input event 0x%04x--> keycode %d\n",
> > +			event, keycode);
> > +
> > +		/* Report press + release ... we can't tell if
> > +		 * this is an autorepeat, and we need to guess
> > +		 * about the release.
> > +		 */
> > +		input_report_key(keys->input, keycode, 1);
> 
> input_sync() is also needed here.
> 
> > +		input_report_key(keys->input, keycode, 0);
> > +	}
> > +	input_sync(keys->input);

If so, then the existing input_sync() needs to move up
a few lines too ... I had thought that the "sync" was
like with a filesystem, where lots of events could be
batched, but evidently not.


> > +}
> > +
> > +static int dm355evm_setkeycode(struct input_dev *dev, int index, int keycode)
> > +{
> > +	if (index >= ARRAY_SIZE(dm355evm_keys))
> > +		return -EINVAL;
> > +
> > +	dm355evm_keys[index].keycode = keycode;
> 
> You also need to alter dev->keybit to indicate that device may generate
> new keycode, otherwise input core will drop event intead of passing it
> on.

Should something then be scrubbing out dev->keybit to
indicate the *old* key code is no longer reported?
(After verifying that no other button reports it.)


> Also I prefer devices that support remapping to keep their copy of 
> keymap so in unlikely case there are 2 devices in the system they can
> have separate keymaps.

That's physically impossible in this case.


> > +	input->evbit[0] = BIT(EV_KEY);
> > +	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++)
> > +		set_bit(dm355evm_keys[i].keycode, input->keybit);
> > +
> > +	input->keycodemax = ARRAY_SIZE(dm355evm_keys);
> > +	input->keycodesize = sizeof(dm355evm_keys[0]);
> 
> You don't need to setup keycodesize and keycodemax since you provide
> your own get and set keycode helpers.

... which I'm presuming is the right thing to do.  It's
a bit surprising to see that the input core will then
have no way to tell what keycodes are valid other than
querying all possible codes!

 
> > +	/* start reporting events */
> > +	status = request_irq(keys->irq, dm355evm_keys_irq,
> > +			IRQF_TRIGGER_FALLING,
> > +			dev_name(&pdev->dev), keys);
> > +	if (status < 0) {
> > +		input_unregister_device(input);
> > +		goto fail1;
> 
> You should not call input_free_device() after input_unregister_device().
> Either jump to "fail0" or do "input = NULL;".

"goto fail0" seems much simpler.  :)




