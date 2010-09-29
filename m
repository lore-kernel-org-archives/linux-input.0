From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Wed, 29 Sep 2010 15:12:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009291512300.26813@pobox.suse.cz>
References: <20100928093949.26553.55566.stgit@localhost.localdomain>  <4CA232DD.7070803@euromail.se>  <44799AC9-6D24-4F01-BE00-A1519498E88D@enac.fr> <4CA23D8A.8040807@euromail.se> <296EC52A-446B-4BE2-B5D6-567B83C7DDBC@enac.fr>
 <4CA2455A.9070109@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55167 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab0I2NMz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 09:12:55 -0400
In-Reply-To: <4CA2455A.9070109@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Rudy Huang <rudy_huang@sitronix.com.tw>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org

On Tue, 28 Sep 2010, Henrik Rydberg wrote:

> >>> I'm working on a slot-based version of the Stantum driver, and have had a look
> >>> into this. The Stantum firmware actually cycles over 8-bit values for its
> >>> ContactID. In this, it conforms more to the definition you gave for
> >>> ABS_MT_TRACKING_ID ("The slot protocol requires the use of the
> >>> ABS_MT_TRACKING_ID, either provided by the hardware or computed from the raw
> >>> data [5]") than to a slot number, doesn't it? Nevertheless, given our recent
> >>> exchanges about the 3M driver, I planned to use the driver's own tracking ID.
> >>>
> >>> Your thoughts?
> >>
> >>
> >> Excellent. :-) Speaking of drivers and multiplication, I think many of the
> >> current drivers could in fact be merged. It seems we have two or three different
> >> types so far, and different manufacturers may well be served by the same driver.
> > 
> > Yes, I have started reviewing all devices and making a summary of their
> > differences in that very purpose. Among the things we'll need is some standard
> > way for calling the filtering function at the end of a set of fingers.
> > CONTACTCOUNT is a good candidate, but I need to check some devices. One thing
> > bothers me though. It is that hid-core has the whole information, then is splits
> > it and calls us repeatedly, then we more or less undo that by storing the
> > information and trying to determine the last time it calls us.
> 
> 
> Right. A hid-mt device based on the raw protocol could be a good idea - after we
> reduced the current set a bit. :-)

Guys, that would be great, thanks in advance for the effort :)

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
