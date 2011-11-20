From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Sun, 20 Nov 2011 11:26:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52480 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700Ab1KTK03 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Nov 2011 05:26:29 -0500
In-Reply-To: <4EC820F8.4070900@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On Sat, 19 Nov 2011, Jeremy Fitzhardinge wrote:

> >> My real question is how to get this out to somewhere useful, where 
> >> (ultimately) some GUI could show the battery information if its 
> >> available?
> > Actually the proper way to do this is using power_supply class.
> >
> > There alreasy is a HID driver that does this properly, and it's rather 
> > easy. Check drivers/hid/hid-wacom.c, especially all the code which is 
> > #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
> 
> Hm, OK.  I wonder what the descriptor for that device looks like; I
> wonder if it already uses Battery Strength, but just hard-coded?

Let's ask Przemo -- does the device present the battery status in its 
report descriptor at all (and if so, could you please share this part of 
report descriptor with us), or has its representation in the reports been 
pure guesswork?

> Given that this is a generic HID thing, where should it go?  Should 
> hid-core.c go around trying to create new power supplies?

If devices which present the battery status in a standard way start to 
appear, we definitely should make it more generic compared to the add-hoc 
handling we currently have in Wacom and Wiimote drivers.

> Seems to me that there's a good chance that random devices will claim to 
> supply Battery Strength info even if they don't have batteries because 
> they happen to share firmware with a device that does (similarly, its 
> amazing how many keys my keyboard is missing according to the 
> descriptor).  I guess the best way to handle it is have a hid-core 
> helper function which will register a power_supply if the driver asks it 
> to (and the descriptor contains Battery Strength).  

This would however force us to have a separate driver on HID bus for such 
devices. I'd prefer to have this in generic code (we are handling 
gazillions of devices just by hid-core/hid-input without any need for 
additional hidbus driver) if possible.

I haven't personally came across many devices that would present bogus 
Battery status in their report descriptor, but it'll probably require some 
more investigation.

> Bluetooth, for example, has a separate descriptor entry about whether 
> the device is battery powered which is much more likely to be accurate 
> than the generic HID descriptor, and it can call the power supply helper 
> as part of the HID setup.
> 
> Does that sound reasonable?

Making the battery / power_supply initialization part of low-level HID 
transport initialization (usb/bluetooth) makes probably the most sense, 
yes.

> > But as long as it contains proper entry in report descriptor, I'd 
> > expect it to send the report on its own.
> 
> My reading of the evdev documentation is that it would suppress
> duplicate reports to usermode, so my little program wouldn't see any
> events from /dev/input/eventX unless there were a change anyway, is that
> right?

That depends a bit on the type of the event (EV_KEY has to handle 
auto-repeat for example, etc). See the switch in input_handle_event() 
which contains the logic behind what is happening when 'duplicate' event 
is coming through input core.

Thanks,

-- 
Jiri Kosina
SUSE Labs
