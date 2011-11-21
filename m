From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Tue, 22 Nov 2011 00:29:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57370 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab1KUXaE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 18:30:04 -0500
In-Reply-To: <4ECA7E7D.80207@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On Mon, 21 Nov 2011, Jeremy Fitzhardinge wrote:

> > such devices. I'd prefer to have this in generic code (we are handling
> > gazillions of devices just by hid-core/hid-input without any need for
> > additional hidbus driver) if possible. I haven't personally came
> > across many devices that would present bogus Battery status in their
> > report descriptor, but it'll probably require some more investigation.
> 
> I have no problem just doing it for all devices unconditionally (well,
> conditional on Battery Strength) if you don't think it would be a problem.

It definitely is something we should at least try. It might turn out that 
there are way too many devices out there which break horribly with this, 
but hey, it's defined by spec, so it'd be strange not to even try to 
support it properly :)

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

I agree.

So I take it that you are now working on that, is my understanding 
correct?

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
