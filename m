From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] input: evdev: use multi-reader buffer to save space
Date: Fri, 28 May 2010 20:34:32 +0200
Message-ID: <4C000CB8.4020909@euromail.se>
References: <1275059434-2110-1-git-send-email-rydberg@euromail.se> <1275059434-2110-2-git-send-email-rydberg@euromail.se> <20100528181047.GB2905@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46918 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751Ab0E1SfB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 14:35:01 -0400
In-Reply-To: <20100528181047.GB2905@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

Hi Dmitry,

> On Fri, May 28, 2010 at 05:10:32PM +0200, Henrik Rydberg wrote:
>> In preparation of larger buffer needs, convert the current per-client
>> circular buffer to a single buffer with multiple clients. Since there
>> is only one writer but potentially many readers, use the somewhat
>> discouraged rwlock_t pattern.
> 
> rwlock is completely unsuitable here:
> 
> 1. You must absiolutely not starve writers since they are quite likely
> are interrupt handlers. If anything they should get priority.

Thanks, I overlooked the starvation argument here.

> 2. The amount of time the thing is locked is very miniscule, I'd say
> that regular spinlocks will still give better performance.

I still have a feeling it should be possible to do this lock-less, but I can see
all docs and your comments pointing towards using the spinlock, so consider it
changed.

> 
> Also, use of atomic is funky, I do not think it does whta you think it
> would... Could you explain more why you are using it?

The use of atomic here serves a declarative purpose, I imagine the assembly code
is more or less identical to the current evdev code. I personally think it is
good to be able to see which variables are involved in a thread-to-thread
exchange. Removing it is not a problem. Is it just me being an old fart, not
understanding that the atomic int has been assumed for the last half decade, or
why is it considered funky?

Cheers,
Henrik

