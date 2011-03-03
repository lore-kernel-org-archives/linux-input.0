From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] uinput: allow events per packet to be specified
Date: Thu, 3 Mar 2011 00:06:08 -0800
Message-ID: <20110303080608.GA29929@core.coreip.homeip.net>
References: <20110301154722.32433.45006.stgit@bob.linux.org.uk>
 <20110302141305.GA1708@polaris.bitmath.org>
 <20110302160621.41ca3da9@lxorguk.ukuu.org.uk>
 <20110302171357.GB1553@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44770 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab1CCIGP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Mar 2011 03:06:15 -0500
Received: by iyb26 with SMTP id 26so698013iyb.19
        for <linux-input@vger.kernel.org>; Thu, 03 Mar 2011 00:06:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110302171357.GB1553@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, aris@cathedrallabs.org, linux-input@vger.kernel.org

On Wed, Mar 02, 2011 at 06:13:57PM +0100, Henrik Rydberg wrote:
> > > I agree that adding this ioctl is symmetrical from the a device
> > > emulation standpoint, but I was imagining eventually replacing the eep
> > > with an automatic scheme, or at least with a more realtime-oriented
> > > parameter. Fixating the interface as you propose will make such a
> > > transition much harder.
> > 
> > This is something we actually need rather than are having future
> > visions about, so imaginings for the future don't really help here
> > unfortunately. I'd obviously rather have a standard API than get into the
> > situation where more and more devices and distros simply won't run an
> > upstream kernel.
> > 
> > If the long term theoretical transition is a concern then we could simply
> > make the "set" behaviour
> > 
> > Set:	value is used as a hint to the uinput driver and input layer
> > 	that a given amount of buffering may be required. It may be
> > 	ignored by the input layer.
> > 
> > and if the long term imagining ever happens the interface cannot be an
> > implediment. It won't cause any problems because if the automatic
> > interfaces work then the hint isn't needed, and if  they never get
> > implemented or it turns out they never to work for all cases (most
> > likely I suspect) then you'll still need the hint.
> 
> Sure, we may need a hint, but if the better hint turns out to be
> events_per_millisecond rather than events_per_packet, we are still in
> a bad situation. Let's see what Dmitry thinks about this. I don't mind
> making the accompanying changes right away, if that helps you.
> 

Umm, before we do that could we get an idea what kind of device is that
that our current hints are not sufficient? Is the rate is so high
because the device is too noisy?

Thanks.

-- 
Dmitry
