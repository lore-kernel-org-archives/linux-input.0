From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] input: evdev: Dynamic buffers (rev4)
Date: Wed, 16 Jun 2010 13:31:56 -0700
Message-ID: <20100616203156.GA25729@core.coreip.homeip.net>
References: <1275735869-2185-1-git-send-email-rydberg@euromail.se>
 <201006101211.51395.dmitry.torokhov@gmail.com>
 <alpine.LRH.2.00.1006161645380.2497@twin.jikos.cz>
 <4C18F906.5060805@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53967 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab0FPUjR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 16:39:17 -0400
Content-Disposition: inline
In-Reply-To: <4C18F906.5060805@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On Wed, Jun 16, 2010 at 06:17:10PM +0200, Henrik Rydberg wrote:
> Jiri Kosina wrote:
> > On Thu, 10 Jun 2010, Dmitry Torokhov wrote:
> > 
> >>> This version implements buffer locking using event_lock as you
> >>> suggested, such that we can proceed with fixing the evdev buffer
> >>> problem independently from providing a suitable one-to-many buffer.
> >>>
> >>> The first patch converts the per-client buffers to a common buffer,
> >>> and adds a fixme since the code is expected to be further
> >>> improved. The second and third patch includes your review comments.
> >> Henrik,
> >>
> >> Applied to .36 queue with minor adjustments, please take a peek in my
> >> 'for-linus' branch and see if you spot anything wrong. 
> > 
> > Hi Dmitry,
> > 
> > I guess you forgot to push it to kernel.org? Last change I see in your 
> > tree is 6 days old.
> > 
> > Thanks,
> > 
> 
> ... which seems like a lucky strike; the patch has a blatant security hole,
> leaking grabbed events to listening clients after ungrab. I sent an updated
> patch to Dmitry earlier today, in a brown paper bag. Not knowing if the original
> patch was actually applied or not, I thought I had better hold on to the change
> just a little bit.
> 

Sorry, just getting back from vacation, the mails escaped when I synced
the mailbox at an airport but I indeed did not push the patcehs out yet.

I should be operable in a day or so and sort everything out.

Thanks.

-- 
Dmitry
