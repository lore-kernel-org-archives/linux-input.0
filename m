From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Wed, 11 Jan 2012 09:18:49 -0800
Message-ID: <20120111171848.GA21047@core.coreip.homeip.net>
References: <20120110102211.GA7682@polaris.bitmath.org>
 <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
 <20120110114212.GA2142@polaris.bitmath.org>
 <20120111073812.GB18668@core.coreip.homeip.net>
 <4F0D5521.5030808@canonical.com>
 <20120111100444.GA5573@polaris.bitmath.org>
 <4F0D5FCE.6080809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45025 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab2AKRS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 12:18:57 -0500
Received: by iabz25 with SMTP id z25so1368906iab.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jan 2012 09:18:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F0D5FCE.6080809@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On Wed, Jan 11, 2012 at 11:09:18AM +0100, Chase Douglas wrote:
> On 01/11/2012 11:04 AM, Henrik Rydberg wrote:
> >>> Applied, however I removed stable notation as this change IMO does not
> >>> qualify for the stable since it does not address a regression.
> >>
> >> It's not a regression per-se, but we want to fix buttonpad support, and
> >> we can't do that without this patch. It's a clear bug that when the
> >> property was added we did not set the property in the devices that need it.
> > 
> > The current behavior depends on userspace and is not a kernel bug,
> > please stop the nonsense already.
> > 
> > For bcm5974 devices, extracting buttonpad properties has been possible
> > since early 2009 (158e9287). The mechanism, predating the input
> > properties interface by nearly two years, has been used in the
> > multitouch and mtrack X drivers ever since. To those users, the
> > present patch has no effect at all.
> 
> Just because an alternative interface has existed does not mean there
> isn't a bug. 

No, there isn't a bug. The driver simply does not support new interface
yet. In all our discussions, AFAIR, property bits were always supposed
to carry only advisory role, i.e. if a driver sets them up then
userspace has it easy and can act upon them. Absence of a property does
not guarantee anything.

Hmm, speaking of properties, shouldn't we set INPUT_PROP_POINTER on
bcm5974 while we are at it?

> A device that has a physical property, but does not set the
> property bit in the driver is a real bug that needs to be fixed.
> Userspace should not have to quirk around broken implementations.
> 
> It's true that userspace can quirk around things in a kernel that
> predates the property bits, but where the property bits are available
> the devices *must* set them or else things will break.

If you are already supporting older kernels that do not support property
bits then you should already be set.

Anyway, this is not a regression and not even new hardware enablement:

" - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,
   something critical.
 - New device IDs and quirks are also accepted."

Therefore I do not feel that stable nomination is warranted. You may
still send it to stable, I'll add similar comment to that request and
leave it up to Greg to decide if he still wants to put it into stable.

Thanks.

-- 
Dmitry
