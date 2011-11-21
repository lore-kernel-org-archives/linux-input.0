From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Mon, 21 Nov 2011 09:36:50 -0800
Message-ID: <20111121173650.GC2362@core.coreip.homeip.net>
References: <4EC75224.7070207@goop.org>
 <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
 <4EC820F8.4070900@goop.org>
 <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
 <4ECA7E7D.80207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63243 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab1KURg5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 12:36:57 -0500
Received: by iage36 with SMTP id e36so7567860iag.19
        for <linux-input@vger.kernel.org>; Mon, 21 Nov 2011 09:36:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4ECA7E7D.80207@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On Mon, Nov 21, 2011 at 08:38:21AM -0800, Jeremy Fitzhardinge wrote:
> On 11/20/2011 02:26 AM, Jiri Kosina wrote:
> >> Given that this is a generic HID thing, where should it go?  Should 
> >> hid-core.c go around trying to create new power supplies?
> > If devices which present the battery status in a standard way start to 
> > appear, we definitely should make it more generic compared to the add-hoc 
> > handling we currently have in Wacom and Wiimote drivers.
> 
> OK.
> 
> > This would however force us to have a separate driver on HID bus for
> > such devices. I'd prefer to have this in generic code (we are handling
> > gazillions of devices just by hid-core/hid-input without any need for
> > additional hidbus driver) if possible. I haven't personally came
> > across many devices that would present bogus Battery status in their
> > report descriptor, but it'll probably require some more investigation.
> 
> I have no problem just doing it for all devices unconditionally (well,
> conditional on Battery Strength) if you don't think it would be a problem.
> 
> >> Bluetooth, for example, has a separate descriptor entry about whether 
> >> the device is battery powered which is much more likely to be accurate 
> >> than the generic HID descriptor, and it can call the power supply helper 
> >> as part of the HID setup.
> >>
> >> Does that sound reasonable?
> > Making the battery / power_supply initialization part of low-level HID 
> > transport initialization (usb/bluetooth) makes probably the most sense, 
> > yes.
> 
> Though unfortunately it looks like the SDP data that contains that
> information is only parsed by usermode, and so isn't available to the
> kernel.  That makes a generic HID-wide approach look more appealing.
> 
> > That depends a bit on the type of the event (EV_KEY has to handle 
> > auto-repeat for example, etc). See the switch in input_handle_event() 
> > which contains the logic behind what is happening when 'duplicate' event 
> > is coming through input core.
> 
> In this case, it will be EV_ABS/ABS_MISC which does have duplicates
> suppressed.

No, please do not try to route battery info through input subsystem;
power_supply seems to be the proper interface for it.

Thanks.

-- 
Dmitry
