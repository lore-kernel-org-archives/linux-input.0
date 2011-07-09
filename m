From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Fri, 8 Jul 2011 17:35:08 -0700
Message-ID: <20110709003508.GC28623@core.coreip.homeip.net>
References: <4E17504F.5070806@zytor.com>
 <20110708204630.GA28623@core.coreip.homeip.net>
 <4E178320.7050401@zytor.com>
 <20110708223709.GB28623@core.coreip.homeip.net>
 <4E179033.9050806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61797 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab1GIAfP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 20:35:15 -0400
Received: by pvg12 with SMTP id 12so1447731pvg.19
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 17:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E179033.9050806@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On Fri, Jul 08, 2011 at 04:18:11PM -0700, H. Peter Anvin wrote:
> On 07/08/2011 03:37 PM, Dmitry Torokhov wrote:
> >>
> >>> We also have similar issues with uinput API and uploading force-freedack
> >>> effects.
> >>
> >> Those are ioctl, though, if I read the code right, or did I miss
> >> something obvious?
> > 
> > Ah, yes, indeed.
> > 
> 
> So the point still holds... you're right now using INPUT_COMPAT_TEST for
> those, but what you *should* use is whether or not you were entered via
> the compat ioctl entry point.

Since we still do need (at least for now) INPUT_COMPAT_TEST in non-ioctl
paths it does not matter much.

> 
> >>
> >>>> but it looks like input also
> >>>> does things like change the format(?!) of sysfs entries, all of which
> >>>> makes me very concerned.
> >>>
> >>> Another historical unfortunate decision. /proc/bus/input (and later
> >>> added sysfs entries) export bitmaps in "compressed" form so that
> >>> userspace can not figure out the size of the segment (32 or 64 bit) on
> >>> its own so we have to convert to userspace size for longs.
> >>
> >> "Compressed form"?  Could you give a concrete example?  They look like
> >> they are emitted in text form.
> > 
> > We drop leading zeroes so if you get "1 0 0 1ffff" you do not know
> > the bit position of the most significant '1' unless we keep segments of
> > known size. Unfortunately we started with 32 bit segments on 32 bit
> > kernels and 64 bit segments on 64 bit kernels so we coudl not simply say
> > that we always split on 32 bit boundary when we discovered compat
> > problem a few years later.
> 
> Ah yes, it is the "binary output masquerading as text, so we end up with
> something that is worse a mess than either" problem.
> 
> >>
> >> Do you have a program that someone could run to see the differences
> >> between compat and non-compat paths?
> > 
> > Hmm, cat for /proc/bus/input/devices and sysfs nodes and evtest would
> > either work or give garbage if compat code woudl not work.
> > 
> 
> I'm desperately trying to come up with a solution which doesn't require
> us to replicate every single system call (which is what relying on
> is_compat_task() does -- it remembers the entry point used) in order
> support one single misdesigned subsystem.  Do you have any kind of ideas
> for what we might be able to do?

Input only need to do this compat stuff on read/write paths so maybe if
you add plumbing similar to compat_ioctl we could switch owver to it.

Thanks.

-- 
Dmitry
