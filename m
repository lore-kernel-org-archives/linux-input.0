From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Fri, 03 Sep 2010 17:58:13 +0100
Message-ID: <1283533093.2361.99.camel@localhost.localdomain>
References: <1271434792.2045.5.camel@localhost.localdomain>
	 <20100417081212.GA19866@core.coreip.homeip.net>
	 <alpine.LNX.2.00.1004191121390.7579@pobox.suse.cz>
	 <1271669507.17421.39.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1004191159130.7579@pobox.suse.cz>
	 <1271672080.17421.91.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1004191307360.7579@pobox.suse.cz>
	 <20100421200941.GA10671@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:47629 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab0ICQ6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 12:58:18 -0400
In-Reply-To: <20100421200941.GA10671@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Wed, 2010-04-21 at 13:09 -0700, Dmitry Torokhov wrote:
> On Mon, Apr 19, 2010 at 01:08:57PM +0200, Jiri Kosina wrote:
> > On Mon, 19 Apr 2010, Bastien Nocera wrote:
> > 
> > > > > > > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > > > > > > ---
> > > > > > > >  Documentation/input/appleir.txt |   45 ++++
> > > > > > > >  drivers/hid/hid-apple.c         |    4 -
> > > > > > > >  drivers/hid/hid-core.c          |    5 +-
> > > > > > > >  drivers/hid/hid-ids.h           |    1 +
> > > > > > > 
> > > > > > > HID pieces need to go through Jiri or he needs to ack them to go through
> > > > > > > my tree...
> > > > > > 
> > > > > > Please feel free to put
> > > > > > 
> > > > > > 	Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > > > > > 
> > > > > > on the blakclist changes in drivers/hid once you merge the 
> > > > > > standalone appleir driver from Bastien.
> > > > > 
> > > > > Any comments on the additional quirks necessary to get lirc working?
> > > > 
> > > > Ouch, I thought that we have discussed previously that I am basically fine 
> > > > with adding those two quirks, but I haven't seen any patch doing that 
> > > > since then ... ?
> > > > 
> > > > So I'd suggest you either remove that part from the appleir documentation 
> > > > until this is implemented, or send me a patch adding those two flags.
> > > 
> > > I sent it Friday with the subject:
> > > [PATCH] Add HID_QUIRK_HIDDEV_FORCE and HID_QUIRK_NO_IGNORE
> > > 
> > > The patch was also sent to the input list:
> > > http://thread.gmane.org/gmane.linux.kernel.input/12176
> > 
> > Ah, now I see it. It somehow didn't reach my inbox, though your other 
> > mails do, odd.
> > 
> > Thanks, I will take it through my tree and queue it for next merge window 
> > (if Dmitry is not going to push the driver even for current -rcs ... ?).
> > 
> 
> No, even though it is a new driver it is gettign kind of late. I am
> going to put it in my 'next' branch.

Could I please have this patch upstream somewhere?

The blocking patch has been merged for a long while now.

Cheers

