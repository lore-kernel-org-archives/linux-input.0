From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: quirk ALWAYS_POLL needed with an unexpectedly high number of
 mice
Date: Fri, 27 Mar 2015 16:10:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503271609120.6781@pobox.suse.cz>
References: <1427448571.5783.41.camel@suse.de>  <CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com> <1427463666.5783.55.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbC0PKU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 11:10:20 -0400
In-Reply-To: <1427463666.5783.55.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Johan Hovold <johan@kernel.org>, linux-input <linux-input@vger.kernel.org>, jdelvare@suse.com

On Fri, 27 Mar 2015, Oliver Neukum wrote:

> > usbhid/hid-core.c already sets HID_QUIRK_NOGET for regular mice/keyboards [1].
> > Maybe adding ALLWAYS_POLL to those would make sense and solve your problem?
> 
> It would solve my problem, but it would do so at the expense of hurting 
> devices that operate correctly, but only by a small amount.
> 
> > BTW I am against having this quirk as the general default because we
> > rely on the usb autosuspend to shut off the touchscreens when no one
> > listen to them, and the touchscreens are draining a lot of power.
> 
> I see. As long as they support remote wakeup, autosuspend will
> still work. A source of remote wakeup, however, is allowed to
> draw more power while suspended.
> 
> Keeping things as is is fine by me but then I will need to add a lot of 
> quirky devices.

I am still surprised that all of a sudden there is such a large flow of 
new devices that need it, and we didn't have a single one a few months 
ago.

Given the fact that this all is being reported by single entitty, is it a 
possibility that they have some other faulty HW instead? Such as the HUB 
suspending at random incorrect points in time?

-- 
Jiri Kosina
SUSE Labs
