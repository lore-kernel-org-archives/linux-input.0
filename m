From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Fri, 8 Jul 2011 15:37:09 -0700
Message-ID: <20110708223709.GB28623@core.coreip.homeip.net>
References: <4E17504F.5070806@zytor.com>
 <20110708204630.GA28623@core.coreip.homeip.net>
 <4E178320.7050401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57616 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab1GHWhP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 18:37:15 -0400
Received: by pwj7 with SMTP id 7so1409278pwj.19
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 15:37:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E178320.7050401@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On Fri, Jul 08, 2011 at 03:22:24PM -0700, H. Peter Anvin wrote:
> On 07/08/2011 01:46 PM, Dmitry Torokhov wrote:
> > 
> > One such place is evdev read/write - unfortunately "struct input_event"
> > was not created 32/64 bit safe so we need to mangle it when running 32
> > bit userspace with 64-bit kernels. See drivers/input/input-compat.c.
> > 
> 
> So these are actually present on all the read/write path system calls.
> That is truly awful.
> 
> Do you happen to know if there is any kind of passing around of file
> descriptors, or if this could perhaps be tied to file descriptor state.

Not sure.

> 
> > We also have similar issues with uinput API and uploading force-freedack
> > effects.
> 
> Those are ioctl, though, if I read the code right, or did I miss
> something obvious?

Ah, yes, indeed.

> 
> >> but it looks like input also
> >> does things like change the format(?!) of sysfs entries, all of which
> >> makes me very concerned.
> > 
> > Another historical unfortunate decision. /proc/bus/input (and later
> > added sysfs entries) export bitmaps in "compressed" form so that
> > userspace can not figure out the size of the segment (32 or 64 bit) on
> > its own so we have to convert to userspace size for longs.
> 
> "Compressed form"?  Could you give a concrete example?  They look like
> they are emitted in text form.

We drop leading zeroes so if you get "1 0 0 1ffff" you do not know
the bit position of the most significant '1' unless we keep segments of
known size. Unfortunately we started with 32 bit segments on 32 bit
kernels and 64 bit segments on 64 bit kernels so we coudl not simply say
that we always split on 32 bit boundary when we discovered compat
problem a few years later.

> 
> Do you have a program that someone could run to see the differences
> between compat and non-compat paths?

Hmm, cat for /proc/bus/input/devices and sysfs nodes and evtest would
either work or give garbage if compat code woudl not work.

-- 
Dmitry
