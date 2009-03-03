From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 3 Mar 2009 09:47:43 +0000
Message-ID: <20090303094743.030b2507@lxorguk.ukuu.org.uk>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	<200903021633.08736.david-b@pacbell.net>
	<20090303004427.GA8638@elte.hu>
	<200903021837.08635.david-b@pacbell.net>
	<1236072446.18955.44.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56145 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753555AbZCCJrg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 04:47:36 -0500
In-Reply-To: <1236072446.18955.44.camel@twins>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Brownell <david-b@pacbell.net>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

> Therefore IRQF_DISABLED _will_ be forced on everybody some day soon, and
> I'll provide an IRQF_ENABLED for use by broken hardware only (and make a
> TAINT flag for that too).

I don't think you understand how the kernel project works. If everyone
thinks your change is inappropriate it won't get in. You can talk about
forcing things all you like but "force" used that way generally means "new
maintainer required"
