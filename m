From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] input: evdev: Dynamic buffers (rev4)
Date: Wed, 16 Jun 2010 13:34:19 -0700
Message-ID: <20100616203419.GB25729@core.coreip.homeip.net>
References: <1275735869-2185-1-git-send-email-rydberg@euromail.se>
 <201006101211.51395.dmitry.torokhov@gmail.com>
 <4C174B31.6040403@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35730 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab0FPUec (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 16:34:32 -0400
Content-Disposition: inline
In-Reply-To: <4C174B31.6040403@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On Tue, Jun 15, 2010 at 11:43:13AM +0200, Henrik Rydberg wrote:
> Dmitry Torokhov wrote:
> > On Saturday, June 05, 2010 04:04:26 am Henrik Rydberg wrote:
> >> Dmitry,
> >>
> >> Please find enclosed the fourth version of the evdev buffer patches.
> >>
> >> This version implements buffer locking using event_lock as you
> >> suggested, such that we can proceed with fixing the evdev buffer
> >> problem independently from providing a suitable one-to-many buffer.
> >>
> >> The first patch converts the per-client buffers to a common buffer,
> >> and adds a fixme since the code is expected to be further
> >> improved. The second and third patch includes your review comments.
> > 
> > Henrik,
> > 
> > Applied to .36 queue with minor adjustments, please take a peek in my
> > 'for-linus' branch and see if you spot anything wrong.
> 
> We are talking about your tree @kernel.org, right? Nothing appeared there...
> 

Right, haven't actually pushed yet, queued e-mail leakage ;)

> > The changes have
> > been made with an eye of implementing a per-client event filters which
> > would again require using private event queues (but only by clients that
> > request filtering).
> 
> Would not having the separate reader tails suffice? Implementing the filtering
> during client read?

No, because that would cause waking up the reader thread, which is the
whole goal of the change.

> 
> > The desire for allowing event filtering in kernel is to avoid waking up
> > HAL-ish processes (ones that only interested in certain special events, 
> > like KEY_SUSPEND, KEY_WIFI, KEY_MUTE, etc) needlessly. Not sure if I am
> > going to have time to actually implement it though, anyone wants to
> > take a stab?
> 
> I see. Something like a lovely new ioctl() command, setting the evbits on a per
> client basis?

Yep, exactly.

-- 
Dmitry
