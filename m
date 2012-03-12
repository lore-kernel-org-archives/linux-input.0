From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH 1/5] HID: multitouch: add support for eGalax 0x722a
Date: Mon, 12 Mar 2012 14:02:33 +0100
Message-ID: <20120312130233.GA7456@polaris.bitmath.org>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com>
 <1331053026-21272-2-git-send-email-benjamin.tissoires@gmail.com>
 <alpine.LNX.2.00.1203091329030.18356@pobox.suse.cz>
 <CAN+gG=F0w88T-iDxVJNEjgyud8FwC5vTGT8+2KTva8FXgFjTog@mail.gmail.com>
 <alpine.LNX.2.00.1203121339550.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:55709 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214Ab2CLNJT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 09:09:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1203121339550.18356@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > Thanks Jiri.
> > How about patches 2,3 and 5?
> 
> I just needed some more time to review those. They are now in my tree as 
> well.
> 
> Patch #4 is still under discussion, and thus on hold.

I am ok with the approach, given that a better one would require a
substantial amount of extra work. Also, since this is all internal
changes, the current patchset does not hinder an eventual improvement
later on. For patch 3, it would be good to at least put the test for
the hid-multitouch driver in a separate function. For patch 4, the
variable name "multitouch" is a bit too generic given the very
specific usage.

Thanks,
Henrik
