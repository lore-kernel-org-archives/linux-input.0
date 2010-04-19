From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 19 Apr 2010 10:31:47 +0100
Message-ID: <1271669507.17421.39.camel@localhost.localdomain>
References: <1271434792.2045.5.camel@localhost.localdomain>
	 <20100417081212.GA19866@core.coreip.homeip.net>
	 <alpine.LNX.2.00.1004191121390.7579@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33880 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab0DSJbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 05:31:52 -0400
In-Reply-To: <alpine.LNX.2.00.1004191121390.7579@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, 2010-04-19 at 11:22 +0200, Jiri Kosina wrote:
> On Sat, 17 Apr 2010, Dmitry Torokhov wrote:
> 
> > > More recent versions of the IR receiver are also supported through
> > > a patch by Alex Karpenko.
> > > 
> > > Tested on a MacbookAir1,1
> > > 
> > 
> > A few comments...
> > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  Documentation/input/appleir.txt |   45 ++++
> > >  drivers/hid/hid-apple.c         |    4 -
> > >  drivers/hid/hid-core.c          |    5 +-
> > >  drivers/hid/hid-ids.h           |    1 +
> > 
> > HID pieces need to go through Jiri or he needs to ack them to go through
> > my tree...
> 
> Please feel free to put
> 
> 	Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> on the blakclist changes in drivers/hid once you merge the 
> standalone appleir driver from Bastien.

Any comments on the additional quirks necessary to get lirc working?

