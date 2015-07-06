From: Matt Whitlock <linux@mattwhitlock.name>
Subject: Re: [PATCH 2/2] Input: bcm5974 - report ABS_MT_PRESSURE + remove redundant emulation code
Date: Mon, 06 Jul 2015 15:59:04 -0400
Message-ID: <3738527.8jxYCgVVW2@crushinator>
References: <556EF8AB.6090704@bitmath.org> <4086356.XLcl34THVt@crushinator> <559ADA98.8060002@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:48994 "EHLO
	resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754546AbbGFT7G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jul 2015 15:59:06 -0400
In-Reply-To: <559ADA98.8060002@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Monday, 6 July 2015, at 9:44 pm, Henrik Rydberg wrote:
> >> I think your patch is a good reduction, all in accord with what we talked about,
> >> but I have doubts that it will not create regressions. From what I have seen so
> >> far, patch-wise, the best solution is to leave the code as it is.
> > 
> > So you believe that the current (in-tree) behavior is superior to either of my attempts thus far to fix it?
> 
> That is not at all what I said. I like the result of your patch set. The
> question is how it works with linux in general.

I don't understand "works with Linux in general." Does my patch set incorrectly call the evdev MT API? With what else in Linux might it be incompatible? Or are you talking more generally about the X.org synaptics input driver and various client applications that consume touch data? No input axes are removed by this patch set, and it maintains the (arguably incorrect) status quo of synthesizing ABS_PRESSURE from the major tool width axis, so why do you anticipate regressions?

> The constraints so far are:
> 
> 1. Make the situation on the problematic devices better
> 2. Do not invent sensor data
> 3. Do not create regressions
> 
> Taken together, it suggests that the patch should be similar, but not equal to,
> the original patch.

I believe that I have achieved #1 and #3. I am not sure how best to achieve #2, given that the *existing* code invents ABS_PRESSURE. If I were to change the code so that it no longer invents sensor data (to comply with #2), then I would almost certainly create regressions (thus violating #3).

Perhaps I could eliminate reporting of ABS_PRESSURE and also write a patch for the synaptics driver so that it can alternatively utilize ABS_TOOL_WIDTH in the absence of ABS_PRESSURE. But such a cross-project patch set would be difficult to apply and deploy.
