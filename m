From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 19 Apr 2010 11:22:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004191121390.7579@pobox.suse.cz>
References: <1271434792.2045.5.camel@localhost.localdomain> <20100417081212.GA19866@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41530 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab0DSJWf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 05:22:35 -0400
In-Reply-To: <20100417081212.GA19866@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

On Sat, 17 Apr 2010, Dmitry Torokhov wrote:

> > More recent versions of the IR receiver are also supported through
> > a patch by Alex Karpenko.
> > 
> > Tested on a MacbookAir1,1
> > 
> 
> A few comments...
> 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  Documentation/input/appleir.txt |   45 ++++
> >  drivers/hid/hid-apple.c         |    4 -
> >  drivers/hid/hid-core.c          |    5 +-
> >  drivers/hid/hid-ids.h           |    1 +
> 
> HID pieces need to go through Jiri or he needs to ack them to go through
> my tree...

Please feel free to put

	Signed-off-by: Jiri Kosina <jkosina@suse.cz>

on the blakclist changes in drivers/hid once you merge the 
standalone appleir driver from Bastien.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
