From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] input: mt updates for 2.6.38
Date: Thu, 9 Dec 2010 10:49:41 -0800
Message-ID: <20101209184940.GB23781@core.coreip.homeip.net>
References: <4CFF49BC.8030202@euromail.se>
 <20101209085814.GA8821@core.coreip.homeip.net>
 <4D011EA3.2000905@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f194.google.com ([209.85.213.194]:41385 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab0LISts (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 13:49:48 -0500
Content-Disposition: inline
In-Reply-To: <4D011EA3.2000905@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Dec 09, 2010 at 07:23:31PM +0100, Henrik Rydberg wrote:
> On 12/09/2010 09:58 AM, Dmitry Torokhov wrote:
> 
> > On Wed, Dec 08, 2010 at 10:02:52AM +0100, Henrik Rydberg wrote:
> >> Dmitry,
> >>
> >> Please pull from
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next
> >>
> >> to receive input-mt updates for 2.6.38.
> >>
> >> The tree contains core changes as well as dependent changes to hid drivers. You
> >> also find the new hid-egalax driver in there, signed off by Jiri.
> > 
> > Pulled, thank you Henrik.
> > 
> > I wonder if we should move input-mt.h into input/mt.h (and if someone
> > would bother to input-polldev.h there that would be great too).
> 
> 
> Sure, I have been wondering about that too. Right away, or later?

Better sooner than later as you'll have less places to patch ;)

> 
> > Also I try to sync with mainline once per release, at -rc1, unless I
> > know that my changes will conflict with some other work. I'd recommend
> > you do the same so that when I pull from you I am getting just your
> > changes and not the rest of stuff from mainline.
> 
> 
> No problem - I will see what sync point you end up using, and I will rebase to
> the same point.

No, not rebase, pull please. Public branches should not be rebased, at
least not when they have been pulled from.

> 
> > BTW, we need to document dev->trkid to avoid complaints from 'make
> > htmldocs' and friends. I wonder if the patch below will do.
> 
> 
> Looks good, thanks.

OK. I take it as an acked-by then.

-- 
Dmitry
