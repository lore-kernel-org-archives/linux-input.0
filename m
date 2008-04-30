From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: USB mouse protocol,
Date: Wed, 30 Apr 2008 16:12:31 +0200
Message-ID: <20080430141231.GA18693@suse.cz>
References: <WorldClient-F200804301128.AA28590066@butn.net> <20080430111816.GA9876@suse.cz> <WorldClient-F200804301607.AA07060136@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:33655 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755922AbYD3OMc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Apr 2008 10:12:32 -0400
Content-Disposition: inline
In-Reply-To: <WorldClient-F200804301607.AA07060136@butn.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Apr 30, 2008 at 04:07:06PM +0200, xerces8 wrote:
> Vojtech Pavlik wrote:
> 
> > On Wed, Apr 30, 2008 at 11:28:59AM +0200, xerces8 wrote:
> > > Hi!
> > > 
> > > I'm curious about some details in the protocol used by USB mice.
> > > A cursory look at the "Device Class Definition for HID 1.11" documents
> > > tells me (note this is the first USB technical document I ever read)
> > > that a mouse can tell the host the format (the protocol) used to report
> > > data (movement, button state etc.).
> > > 
> > > Also a quick look into linuxv2.6.25/drivers/hid/usbhid/usbmouse.c suggests
> > > that 8 bits are used for position.
> > > 
> > > So my questions are:
> > >  - is the position data always 8 bits wide ?
> > 
> > No. The driver you need to look at is usbhid.ko, not usbmouse - that
> > only works for the static "HID Boot Protocol", and is only useful in
> > embedded devices.
> 
> Pretty hard to read there... Can I activate some debug output, to see what
> my mouse is sending ?

Yes, #define DEBUG and possibly also DEBUG_DATA will do the trick.

> 
> > >  - when are reports sent ? Are they polled by host ? Or sent by the device
> > > on its own ?
> > 
> > That depends on how you look at it. The host controller polls the device
> > at a specified rate - typically 100Hz, but the device decides whether it
> > will or won't send a report when polled.
> 
> 100Hz is the linux default ? Is there an USB standard value ?

100Hz is what mice normally ask for. The frequency is in the endpoint
descriptor provided by the mouse.

-- 
Vojtech Pavlik
Director SuSE Labs
