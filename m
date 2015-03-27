From: Oliver Neukum <oneukum@suse.de>
Subject: Re: quirk ALWAYS_POLL needed with an unexpectedly high number of
 mice
Date: Fri, 27 Mar 2015 14:41:06 +0100
Message-ID: <1427463666.5783.55.camel@suse.de>
References: <1427448571.5783.41.camel@suse.de>
	 <CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59103 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbbC0Nlm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 09:41:42 -0400
In-Reply-To: <CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, jdelvare@suse.com

On Fri, 2015-03-27 at 09:18 -0400, Benjamin Tissoires wrote:
> On Fri, Mar 27, 2015 at 5:29 AM, Oliver Neukum <oneukum@suse.de> wrote:
> > Hi,
> >
> > I am getting reports from a customer running an unintentional
> > stress test for this quirk. I would have to add a dozen mice
> > in the medium term. Is that desirable?
> > Should we make the quirk the default? Or add a module parameter
> > to let the pessimistic users with multiple desktop rodents
> > select the quirk as default? Or just carry on?
> > Comments?
> >
> 
> usbhid/hid-core.c already sets HID_QUIRK_NOGET for regular mice/keyboards [1].
> Maybe adding ALLWAYS_POLL to those would make sense and solve your problem?

It would solve my problem, but it would do so at the expense of hurting
devices that operate correctly, but only by a small amount. 

> BTW I am against having this quirk as the general default because we
> rely on the usb autosuspend to shut off the touchscreens when no one
> listen to them, and the touchscreens are draining a lot of power.

I see. As long as they support remote wakeup, autosuspend will
still work. A source of remote wakeup, however, is allowed to
draw more power while suspended.

Keeping things as is is fine by me but then I will need to add a lot of
quirky devices.

	Regards
		Oliver


