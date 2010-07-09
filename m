From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] cy8ctmg110: capacitive touchscreen support
Date: Fri, 9 Jul 2010 09:28:46 -0700
Message-ID: <20100709162846.GC19827@core.coreip.homeip.net>
References: <20100709153546.31399.14995.stgit@localhost.localdomain>
 <20100709162704.GB19827@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33265 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757757Ab0GIQ2x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jul 2010 12:28:53 -0400
Received: by pvc7 with SMTP id 7so905740pvc.19
        for <linux-input@vger.kernel.org>; Fri, 09 Jul 2010 09:28:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100709162704.GB19827@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 09, 2010 at 09:27:05AM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 09, 2010 at 04:36:32PM +0100, Alan Cox wrote:
> > From: Samuli Konttila <samuli.konttila@aavamobile.com>
> > 
> > Add support for the cy8ctmg110 capacitive touchscreen used on some embedded
> > devices.
> > 
> > (Some clean up by Alan Cox)
> > 
> > - Moved the hardcoded GPIO lines into platform data
> > 
> 
> I still see GPIO lines hardcoded. Wrong changeset description?
> 
> > +
> > +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	ts->timer.function = cy8ctmg110_timer;
> > +
> 
> I doubt it compiles since you seem to have removed cy8ctmg110_timer().
> 

Ah, see you sent the next version, ignore me then.

-- 
Dmitry
