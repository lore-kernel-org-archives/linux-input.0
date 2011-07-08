From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Fri, 8 Jul 2011 13:46:30 -0700
Message-ID: <20110708204630.GA28623@core.coreip.homeip.net>
References: <4E17504F.5070806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58928 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab1GHUqk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 16:46:40 -0400
Received: by pzk9 with SMTP id 9so1667124pzk.19
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 13:46:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E17504F.5070806@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

Hi Peter,

On Fri, Jul 08, 2011 at 11:45:35AM -0700, H. Peter Anvin wrote:
> Hello,
> 
> I'm trying to figure out what system calls can actually invoke code that
> depends on INPUT_COMPAT_TEST, and in particular which of those changes
> actually matter.
> 
> The input system and seccomp are the *only* arch-neutral subsystem in
> Linux which appear to trigger on if we are in compat mode, and this is
> causing some serious consternation in trying to freeze the proposed x32
> (32-bit x86-64) ABI.
> 
> I would really like to understand if that dependency can be eliminated
> or mitigated; as it currently sits we may need an entirely separate
> system call table *just to support the input system*.
> 
> The problem is that I am personally not familiar enough with the input
> subsystem to know what the dependencies are.  ioctls are not an issue;
> there is already an entire infrastructure to handle compatibility ioctls
> (and that infrastructure should be used!),

One such place is evdev read/write - unfortunately "struct input_event"
was not created 32/64 bit safe so we need to mangle it when running 32
bit userspace with 64-bit kernels. See drivers/input/input-compat.c.

We also have similar issues with uinput API and uploading force-freedack
effects.

> but it looks like input also
> does things like change the format(?!) of sysfs entries, all of which
> makes me very concerned.

Another historical unfortunate decision. /proc/bus/input (and later
added sysfs entries) export bitmaps in "compressed" form so that
userspace can not figure out the size of the segment (32 or 64 bit) on
its own so we have to convert to userspace size for longs.

> 
> Any help in creating an inventory for this would be appreciated.
> 

I believe the above are the only non-ioctl compat issues in input core.

-- 
Dmitry
