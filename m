From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev3)
Date: Fri, 21 May 2010 09:52:18 -0700
Message-ID: <20100521165218.GA26439@core.coreip.homeip.net>
References: <1274457354-5570-1-git-send-email-rydberg@euromail.se>
 <AANLkTikBWzgRmso0oQNXcTxeExdKZORXYbIwK9CcMl85@mail.gmail.com>
 <4BF6B673.1080507@euromail.se>
Mime-Version: 1.0
Content-Type: text/Plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55973 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934180Ab0EUQwa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 12:52:30 -0400
Content-Disposition: inline
In-Reply-To: <4BF6B673.1080507@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

On Friday 21 May 2010 09:36:03 am Henrik Rydberg wrote:
> Ping Cheng wrote:
> > Hi Henrik,
> > 
> > Thank you for your quick turnaround. Two minor comments in line.
> > 
> > Ping
> 
> Thanks for those, yes, both mistakes. Dmitry, in case you find these last
> versions acceptable, perhaps one could change them manually:
> 
> 1. Patch description: s/SYN_MT_SLOT/ABS_SLOT/

Not ABS_MT_SLOT?

> 2. Test: s/hardware of computed/hardware or computed/
> 
> Thanks,
> Henrik

-- 
Dmitry
