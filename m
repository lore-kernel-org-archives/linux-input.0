From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Sun, 18 Apr 2010 20:49:37 +0100
Message-ID: <1271620177.19833.3471.camel@localhost.localdomain>
References: <1271434792.2045.5.camel@localhost.localdomain>
	 <20100417081212.GA19866@core.coreip.homeip.net>
	 <1271540695.1970.3.camel@localhost.localdomain>
	 <20100418194328.GA17565@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:45297 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0DRTtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Apr 2010 15:49:47 -0400
In-Reply-To: <20100418194328.GA17565@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sun, 2010-04-18 at 12:43 -0700, Dmitry Torokhov wrote:
> On Sat, Apr 17, 2010 at 10:44:55PM +0100, Bastien Nocera wrote:
> > On Sat, 2010-04-17 at 01:12 -0700, Dmitry Torokhov wrote: 
> > > HI Bastien,
> > > 
> > > On Fri, Apr 16, 2010 at 05:19:52PM +0100, Bastien Nocera wrote:
> > > > This driver was originally written by James McKenzie, updated by
> > > > Greg Kroah-Hartman, further updated by myself, with suspend support
> > > > added.
> > > > 
> > > > More recent versions of the IR receiver are also supported through
> > > > a patch by Alex Karpenko.
> > > > 
> > > > Tested on a MacbookAir1,1
> > > > 
> > > 
> > > A few comments...
> > 
> > All fixed. I removed the suspend/resume code as it worked fine without
> > it (I was working of an old patch).
> > 
> > Sent the new patch separately.
> 
> Hmm, I am curious why suspend and resume is not necessary for this
> device... Are you relying on the USB core to tear down and re-create the
> device? Then you may lose user-applied settings (like changed keymap).

How could I test that?

> But if suspend and resume are really not needed then you need to
> complete cleanup and get rid of APPLIEIR_OPENED and APPLEIR_SUSPENDED
> and their handling in applieir_open() and appleir_close().

My mistake. I'll clean that up now.

> Right. I was just saying that Jiri needs to either take HID parts
> through his tree or give OK for me to take through mine.

OK.


