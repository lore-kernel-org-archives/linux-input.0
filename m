From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Wed, 10 Feb 2010 13:52:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002101352220.30967@pobox.suse.cz>
References: <1263997077.1735.2942.camel@localhost.localdomain>  <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz>  <1265032341.32444.3105.camel@localhost.localdomain>  <alpine.LNX.2.00.1002031653320.15395@pobox.suse.cz>
 <1265646777.2383.4621.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57481 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256Ab0BJMw6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 07:52:58 -0500
In-Reply-To: <1265646777.2383.4621.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 8 Feb 2010, Bastien Nocera wrote:

> > > > > +With 0x05ac being the vendor ID (Apple, you shouldn't need to change this)
> > > > > +With 0x8242 being the product ID (check the output of lsusb for your hardware)
> > > > > +And 0x08 being "HID_CONNECT_HIDDEV"
> > > > 
> > > > I am afraid this is not true, 0x08 is HID_QUIRK_NOGET.
> > > > 
> > > > We currently don't have dynamic quirk for forcing HIDDEV creation from the 
> > > > module parameter.
> > > 
> > > Right. Any chance to change that?
> > 
> > This particular one might actually make enough sense to be added (although 
> > I am really trying to avoid quirk additions completely), for backwards 
> > compatibility reasons.
> 
> Should I remove the comments there altogether then? That kind of defeats
> my "but you can use lirc with some tweaks" argument, even though I still
> think that those people needing more keys would be in the minority...

I rather though that we could/should (re-)introduce the HID_QUIRK_HIDDEV 
quirks so that it could still be applied manually.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
