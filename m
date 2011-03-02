From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] uinput: allow events per packet to be specified
Date: Wed, 2 Mar 2011 18:13:57 +0100
Message-ID: <20110302171357.GB1553@polaris.bitmath.org>
References: <20110301154722.32433.45006.stgit@bob.linux.org.uk>
 <20110302141305.GA1708@polaris.bitmath.org>
 <20110302160621.41ca3da9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:59734 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab1CBRMH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Mar 2011 12:12:07 -0500
Content-Disposition: inline
In-Reply-To: <20110302160621.41ca3da9@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: aris@cathedrallabs.org, linux-input@vger.kernel.org

> > I agree that adding this ioctl is symmetrical from the a device
> > emulation standpoint, but I was imagining eventually replacing the eep
> > with an automatic scheme, or at least with a more realtime-oriented
> > parameter. Fixating the interface as you propose will make such a
> > transition much harder.
> 
> This is something we actually need rather than are having future
> visions about, so imaginings for the future don't really help here
> unfortunately. I'd obviously rather have a standard API than get into the
> situation where more and more devices and distros simply won't run an
> upstream kernel.
> 
> If the long term theoretical transition is a concern then we could simply
> make the "set" behaviour
> 
> Set:	value is used as a hint to the uinput driver and input layer
> 	that a given amount of buffering may be required. It may be
> 	ignored by the input layer.
> 
> and if the long term imagining ever happens the interface cannot be an
> implediment. It won't cause any problems because if the automatic
> interfaces work then the hint isn't needed, and if  they never get
> implemented or it turns out they never to work for all cases (most
> likely I suspect) then you'll still need the hint.

Sure, we may need a hint, but if the better hint turns out to be
events_per_millisecond rather than events_per_packet, we are still in
a bad situation. Let's see what Dmitry thinks about this. I don't mind
making the accompanying changes right away, if that helps you.

Thanks,
Henrik
