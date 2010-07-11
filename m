From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: magicmouse: report last touch up
Date: Sun, 11 Jul 2010 23:03:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007112302580.4741@pobox.suse.cz>
References: <1278338272-5588-1-git-send-email-chase.douglas@canonical.com> <87fwzyauj6.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41713 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab0GKVDV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jul 2010 17:03:21 -0400
In-Reply-To: <87fwzyauj6.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org

On Mon, 5 Jul 2010, Michael Poole wrote:

> Chase Douglas writes:
> 
> > The evdev multitouch protocol requires that a last MT sync event must be
> > sent after all touches are up. This change adds the last MT sync event
> > to the hid-magicmouse driver.
> >
> > Also, don't send events when a touch leaves.
> >
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> Acked-by: Michael Poole <mdpoole@troilus.org>
> 
> Thanks for fixing these up!

Thanks guys, it's now in the magicmouse branch.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
