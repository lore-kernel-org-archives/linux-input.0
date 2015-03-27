From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: quirk ALWAYS_POLL needed with an unexpectedly high number of
 mice
Date: Fri, 27 Mar 2015 17:11:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503271710360.6781@pobox.suse.cz>
References: <1427448571.5783.41.camel@suse.de> <CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com> <1427463666.5783.55.camel@suse.de> <alpine.LNX.2.00.1503271609120.6781@pobox.suse.cz> <1427471969.26270.7.camel@chaos.site>
 <CAN+gG=GNL2HiQFDrHs_SUSL+iyOtv92SRpqJMBYHOXDaaE5uSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42971 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbbC0QLs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 12:11:48 -0400
In-Reply-To: <CAN+gG=GNL2HiQFDrHs_SUSL+iyOtv92SRpqJMBYHOXDaaE5uSg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Oliver Neukum <oneukum@suse.de>, Johan Hovold <johan@kernel.org>, linux-input <linux-input@vger.kernel.org>

On Fri, 27 Mar 2015, Benjamin Tissoires wrote:

> Hmm... it looks like it's not host dependent unfortunately. We have a
> (private) bug report for RHEL 6 where a customer wants to use the
> following mouse:
> http://www.compsource.com/pn/2MOUSEU1L/Keytronics-228/
> 
> I bought one and was able to reproduce the need for the quirk on
> various systems.
> 
> Plus I noticed that if the mouse is raised over the surface (so the
> sensor does not report anything), the bug does not appear.
> 
> So, to me, the USB output queue is full given that it is not polled by
> the host and the chip within the USB mouse decides to
> disconnect/reconnect to empty the queue. So nothing host specific.

I am not questioning at all that it's needed for some devices.

But I am surprised by all-of-a-sudden flow for quirk addition for many 
distinct devices, all coming from the same source. I am afraid this might 
be false positive, and root-cause being somewhere else, causing us adding 
a lot of potentially unnecessary quirk entries.

-- 
Jiri Kosina
SUSE Labs
