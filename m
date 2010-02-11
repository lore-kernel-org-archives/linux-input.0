From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 11 Feb 2010 18:18:53 +0000
Message-ID: <1265912333.2383.12172.camel@localhost.localdomain>
References: <1263997077.1735.2942.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz>
	 <1265032341.32444.3105.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1002031653320.15395@pobox.suse.cz>
	 <1265646777.2383.4621.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1002101352220.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756463Ab0BKSTB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 13:19:01 -0500
In-Reply-To: <alpine.LNX.2.00.1002101352220.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 2010-02-10 at 13:52 +0100, Jiri Kosina wrote:
> On Mon, 8 Feb 2010, Bastien Nocera wrote:
> 
> > > > > > +With 0x05ac being the vendor ID (Apple, you shouldn't need to change this)
> > > > > > +With 0x8242 being the product ID (check the output of lsusb for your hardware)
> > > > > > +And 0x08 being "HID_CONNECT_HIDDEV"
> > > > > 
> > > > > I am afraid this is not true, 0x08 is HID_QUIRK_NOGET.
> > > > > 
> > > > > We currently don't have dynamic quirk for forcing HIDDEV creation from the 
> > > > > module parameter.
> > > > 
> > > > Right. Any chance to change that?
> > > 
> > > This particular one might actually make enough sense to be added (although 
> > > I am really trying to avoid quirk additions completely), for backwards 
> > > compatibility reasons.
> > 
> > Should I remove the comments there altogether then? That kind of defeats
> > my "but you can use lirc with some tweaks" argument, even though I still
> > think that those people needing more keys would be in the minority...
> 
> I rather though that we could/should (re-)introduce the HID_QUIRK_HIDDEV 
> quirks so that it could still be applied manually.

The interaction between the HID and the input layer isn't really my
forte (well, the kernel's not my forte :).

Wouldn't we have some trouble getting the HID layer provide a hiddev
device for the receiver, whilst being serviced by an input driver?

I wouldn't mind trying to port the driver to be a full HID driver, and
enable hiddev all the time on it. We just wouldn't do anything in the
input part if the hiddev device was claimed, and parse the raw_report
from the device otherwise.

Opinions? If it's a good idea, I'd be interested in some examples in
devices that do their own raw_report event parsing, instead of letting
the hid layer handle it.

