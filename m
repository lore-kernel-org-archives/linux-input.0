From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] HID: Add support for pressure sensitive buttons
Date: Tue, 22 Nov 2011 09:55:44 -0800
Message-ID: <20111122175543.GA27773@core.coreip.homeip.net>
References: <1321393219-19394-1-git-send-email-sean@mess.org>
 <20111121095818.GA3568@pip.mess.org>
 <20111121133428.99064g5drrymryww@www.81.fi>
 <20111122114725.GA13107@pip.mess.org>
 <alpine.LNX.2.00.1111221817070.28728@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36400 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1KVRz4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 12:55:56 -0500
Received: by iage36 with SMTP id e36so467175iag.19
        for <linux-input@vger.kernel.org>; Tue, 22 Nov 2011 09:55:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1111221817070.28728@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sean Young <sean@mess.org>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org, simon@mungewell.org

On Tue, Nov 22, 2011 at 06:17:49PM +0100, Jiri Kosina wrote:
> On Tue, 22 Nov 2011, Sean Young wrote:
> 
> > > >I sent this almost a week ago. Any review comments please or is it
> > > >good for merging?
> > > >
> > > >Sean
> > > 
> > > Sorry for not replying earlier. To me patch looks ok. But I don't
> > > have working PS2 controller atm (well I have DDR-pad in storage, but
> > > I'm too lazy to move that monster around), so I can't really test
> > > this.
> > > 
> > > So I'd like to ask that would you like to take over maintaining of
> > > this driver? You seem to have access to more hardware anyway.
> > 
> > I do have four of the five usb controllers which the driver supports. I'd
> > be more than happy to maintain this driver, but I'm not sure I can do 
> > this while I'm not getting any other response on my patches.
> > 
> > Jiri, Dmitry: any review comments?
> 
> I'd like to at least get Dmitry's ack for the ff-memless change.

Actually I do not like it since it comingles unrelated parts: it is my
understanding that pressure-sensitive buttons should be able to work
ebven if user choses to disable force feedback support.

I also do not believe that the new attributes should reside with input
devices instead of HID device itself since they conrol aspects of the
work of real hardware, not input core abstraction.

Thanks.

-- 
Dmitry
