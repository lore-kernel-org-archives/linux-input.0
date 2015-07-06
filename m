From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 2/2] Input: bcm5974 - report ABS_MT_PRESSURE + remove
 redundant emulation code
Date: Mon, 6 Jul 2015 21:44:24 +0200
Message-ID: <559ADA98.8060002@bitmath.org>
References: <556EF8AB.6090704@bitmath.org> <7271343.oGOpcDThz2@crushinator>
 <559AD2CA.7000804@bitmath.org> <4086356.XLcl34THVt@crushinator>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay1.public.one.com ([91.198.169.124]:11295 "EHLO
	mailrelay1.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbbGFTpr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 15:45:47 -0400
In-Reply-To: <4086356.XLcl34THVt@crushinator>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Whitlock <linux@mattwhitlock.name>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

>> I think your patch is a good reduction, all in accord with what we talked about,
>> but I have doubts that it will not create regressions. From what I have seen so
>> far, patch-wise, the best solution is to leave the code as it is.
> 
> So you believe that the current (in-tree) behavior is superior to either of my attempts thus far to fix it?

That is not at all what I said. I like the result of your patch set. The
question is how it works with linux in general.

>> I understand that the constraints now seem to depict the empty set, but maybe
>> there is a third solution.
> 
> Can you characterize what an acceptable solution would look like? The behavior of the code as it stands is really not acceptable; the MacBook Pro touchpad's buggy behavior in Linux is extremely frustrating, relative to its flawless behavior in OS X. My patchset has not introduced any regressions that I can observe, and in fact it has nearly eliminated the spurious drags. (I still get one occasionally, but maybe at a rate of ~1% as often as I was seeing them before.)

The constraints so far are:

1. Make the situation on the problematic devices better
2. Do not invent sensor data
3. Do not create regressions

Taken together, it suggests that the patch should be similar, but not equal to,
the original patch.

Thanks,
Henrik

