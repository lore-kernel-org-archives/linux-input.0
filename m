From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: Add support for pressure sensitive buttons
Date: Tue, 22 Nov 2011 18:17:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111221817070.28728@pobox.suse.cz>
References: <1321393219-19394-1-git-send-email-sean@mess.org> <20111121095818.GA3568@pip.mess.org> <20111121133428.99064g5drrymryww@www.81.fi> <20111122114725.GA13107@pip.mess.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35114 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab1KVRRv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 12:17:51 -0500
In-Reply-To: <20111122114725.GA13107@pip.mess.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, simon@mungewell.org

On Tue, 22 Nov 2011, Sean Young wrote:

> > >I sent this almost a week ago. Any review comments please or is it
> > >good for merging?
> > >
> > >Sean
> > 
> > Sorry for not replying earlier. To me patch looks ok. But I don't
> > have working PS2 controller atm (well I have DDR-pad in storage, but
> > I'm too lazy to move that monster around), so I can't really test
> > this.
> > 
> > So I'd like to ask that would you like to take over maintaining of
> > this driver? You seem to have access to more hardware anyway.
> 
> I do have four of the five usb controllers which the driver supports. I'd
> be more than happy to maintain this driver, but I'm not sure I can do 
> this while I'm not getting any other response on my patches.
> 
> Jiri, Dmitry: any review comments?

I'd like to at least get Dmitry's ack for the ff-memless change.

Also, is there please any userspace application making use of the newly 
added sysfs atributes already?

Thanks,

-- 
Jiri Kosina
SUSE Labs
