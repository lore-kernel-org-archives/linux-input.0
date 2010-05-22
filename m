From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lost events in older kernels
Date: Sat, 22 May 2010 13:12:56 -0700
Message-ID: <20100522201256.GB30464@core.coreip.homeip.net>
References: <4BF7825F.2030405@seas.upenn.edu>
 <20100522074249.GA25143@core.coreip.homeip.net>
 <4BF7A247.5090307@seas.upenn.edu>
 <4BF7B183.2050801@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42351 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978Ab0EVUNE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 May 2010 16:13:04 -0400
Received: by pwi5 with SMTP id 5so905637pwi.19
        for <linux-input@vger.kernel.org>; Sat, 22 May 2010 13:13:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BF7B183.2050801@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>

On Sat, May 22, 2010 at 12:27:15PM +0200, Henrik Rydberg wrote:
> Rafi Rubin wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On 05/22/10 03:42, Dmitry Torokhov wrote:
> >> On Sat, May 22, 2010 at 03:06:07AM -0400, Rafi Rubin wrote:
> >>> I'm playing with a project with a 2.6.29 kernel, and the userspace application
> >>> seems to miss some events.  Is there a particular fix that improved the handling?
> >>>
> >>> Also tried catting the dev to a file while testing, and the dump also is missing
> >>> some events.
> >>>
> >> No "interesting" patches went into evdev for a few release now...
> >>
> >> Hm, could it be that event queue is overflowing before userspace gets a
> >> chance to empty it. What kind of event rate are we talking here?
> >>
> > 
> > Quite possibly.  It is a multitouch device and we know Henrik's been concerned
> > with the load for a while.
> > 
> > So to put some numbers behind his fears:
> > 
> > 146668 hid events processed
> > 24952 evdev events captured with a cat
> > 30 seconds (give or take).
> > 
> > This is for a mix of different numbers of fingers, but continuous use for those
> > 30 seconds.  And X was running and reading the dev node too.
> 
> Others have experienced this too. Mika has a patch for this, increasing the
> (kernel) evdev buffer quite a bit, from 64 to 256. I believe the reason it is
> not sent upstream is because it increases the footprint by 3 Kb. Perhaps a
> dynamic solution could work here.
> 

Yes, if input devices could hint handlers about their "packet size"
then evdev could size it's event queue accordingly. I'd say we need to
keep about 8 packets worth of data (number is pulled right out of my
behind ;) )...

-- 
Dmitry
