From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/26] Consolidate patches and add support for new devices
Date: Mon, 9 Nov 2015 15:03:51 -0800
Message-ID: <20151109230351.GB9155@dtor-ws>
References: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
 <CACRpkdb2KNJ7qJ_UZYnW_0gb2ExJNOEdwvYakhbngztckWTBsg@mail.gmail.com>
 <5641240C.5040603@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33171 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbKIXDy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 18:03:54 -0500
Content-Disposition: inline
In-Reply-To: <5641240C.5040603@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Mon, Nov 09, 2015 at 02:54:04PM -0800, Andrew Duggan wrote:
> Hi Linus,
> 
> Thanks for reviewing!
> 
> On 11/09/2015 04:49 AM, Linus Walleij wrote:
> >On Fri, Nov 6, 2015 at 12:34 AM, Andrew Duggan <aduggan@synaptics.com> wrote:
> >
> >>NOTE: This patch set applies to synaptics-rmi4 branch in
> >>Dmitry Torokhov's input tree.
> >(...)
> >>This patchset applies cleanly to the synaptics-rmi4 branch, but does not
> >>successfully build because the synaptics-rmi4 branch is based on the 3.14
> >(...)
> >>I would suggest updating the synaptics-rmi4 branch to something
> >>more resent.
> >I suggest we stop seeing Dmitry's branch as "master" for RMI4 development.
> >Instead work on the v4.3-rc6-based branch you have at
> >https://github.com/aduggan/linux.git, and then (after the merge window)
> >rebase it to v4.4-rc1 and ask Dmitry to *drop* this old branch and pull in
> >your stuff instead, and then look at the end result of that.
> >
> >Who knows, maybe he thinks it's clean enough to go into v4.5.
> >Or for parts of it to go into v4.5.
> >
> >In any case, surely he's more helped by an up-to-date rebased branch
> >than having to rebase it himself too.
> >
> >>This patch set consolidates some outstanding patches and then builds on
> >>that to add support for new devices.
> >Unless Dmitry is extremely interested in the development history,
> >I suggest to squash the whole thing down to a few patches that
> >begins by adding the bus and infrastructure and then one function per
> >patch.
> 
> Ok, I'll rebase things. I realized when I was creating that patch
> set that at some point everything would have to be rebased. But, for
> the time being I was trying to maintain the history to avoid having
> to re-review the existing code. But, at this point it is probably
> better to review the driver as a whole. We will have my current
> branch and Dmitry's branch around if we end up needing the history.

OK, if you are rebasing/respoinning patches let's start with 4.3 - there
is nothing significantly new in input core in 4.4 and I'd rather start
at a stable point.

Thanks.

-- 
Dmitry
