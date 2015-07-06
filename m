From: Matt Whitlock <linux@mattwhitlock.name>
Subject: Re: [PATCH 2/2] Input: bcm5974 - report ABS_MT_PRESSURE + remove redundant emulation code
Date: Mon, 06 Jul 2015 15:35:16 -0400
Message-ID: <4086356.XLcl34THVt@crushinator>
References: <556EF8AB.6090704@bitmath.org> <7271343.oGOpcDThz2@crushinator> <559AD2CA.7000804@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:45321 "EHLO
	resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755062AbbGFTnb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jul 2015 15:43:31 -0400
In-Reply-To: <559AD2CA.7000804@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Monday, 6 July 2015, at 9:11 pm, Henrik Rydberg wrote:
> > It's been four weeks, and I haven't heard back on this patch. I believe I've
> > implemented what was requested. Is there a problem with it?
> 
> I thought you did get response on this patch set, concerning the fabrication of
> force data? I seem to remember a mail from Dmitry about this, although I cannot
> find it now.

I don't have anything from Dmitry at all, even in my spam box. Maybe he discussed it with you only?

> I think your patch is a good reduction, all in accord with what we talked about,
> but I have doubts that it will not create regressions. From what I have seen so
> far, patch-wise, the best solution is to leave the code as it is.

So you believe that the current (in-tree) behavior is superior to either of my attempts thus far to fix it?

> I understand that the constraints now seem to depict the empty set, but maybe
> there is a third solution.

Can you characterize what an acceptable solution would look like? The behavior of the code as it stands is really not acceptable; the MacBook Pro touchpad's buggy behavior in Linux is extremely frustrating, relative to its flawless behavior in OS X. My patchset has not introduced any regressions that I can observe, and in fact it has nearly eliminated the spurious drags. (I still get one occasionally, but maybe at a rate of ~1% as often as I was seeing them before.)
