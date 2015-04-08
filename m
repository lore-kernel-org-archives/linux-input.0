From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 1/2] usbhid: more mice with ALWAYS_POLL
Date: Wed, 08 Apr 2015 09:33:11 +0200
Message-ID: <1428478391.6579.3.camel@suse.de>
References: <1427711796-28834-1-git-send-email-oneukum@suse.de>
	  <alpine.LNX.2.00.1503301609200.713@pobox.suse.cz>
	 <1427870396.30440.7.camel@suse.de>
	 <alpine.LNX.2.00.1504021425550.843@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39313 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbbDHHds (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 03:33:48 -0400
In-Reply-To: <alpine.LNX.2.00.1504021425550.843@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 2015-04-02 at 14:26 +0200, Jiri Kosina wrote:
> On Wed, 1 Apr 2015, Oliver Neukum wrote:
> 
> > > I am postponing all these before it is clarified that this is indeed a 
> > > case reporter is able to reproduce on different system as well to rule out 
> > > the possibility of hub being the actual root cause.
> > 
> > The test has been redone on a different system with a mouse reported to 
> > be affected and the problem does show up. I have to conclude that the we 
> > are really a victim of bias here. We thought the issue was rare because 
> > we never looked for it.
> 
> Ok, this is sad.
> 
> I am now applying these two on the previous ones, and we'll see. If this 
> becomes a frequently re-appearing topic, we'll have to come up with more 
> generic aproach.

I think it is unacceptable to punish owners of good mice for quirky
stuff, yet the current approach of manually setting quirks from a module
option or adding them to the blacklist has drawbacks.

1. It is slow and cumbersome (especially the blacklist)
2. adding the quirk requires root rights, foreknowledge and is limited
to 4 devices

So at this point. I'd say the best option would be to have a module
parameter to tell HID that it should assume all devices to be quirky.

	Regards
		Oliver



