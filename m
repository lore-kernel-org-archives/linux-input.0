From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 03 Mar 2009 10:27:26 +0100
Message-ID: <1236072446.18955.44.camel@twins>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	 <200903021633.08736.david-b@pacbell.net> <20090303004427.GA8638@elte.hu>
	 <200903021837.08635.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep13-int.chello.at ([62.179.121.33]:64496 "EHLO
	viefep13-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZCCJ14 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 04:27:56 -0500
In-Reply-To: <200903021837.08635.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Mon, 2009-03-02 at 18:37 -0800, David Brownell wrote:
> No.  But I did get a non-response that didn't include any
> explanation, and relied totally on unfounded assertions
> combined with the presumption that someday IRQF_DISABLED
> will be forced on in all drivers.

Enabling IRQs in hardirq context is BAD because:

 - IRQ handler nesting leads to stack overflow
 - It gives the false impression its OK for IRQ handlers to be slow,
   it is _NOT_, as you still generate horrible preemption latency.

Therefore IRQF_DISABLED _will_ be forced on everybody some day soon, and
I'll provide an IRQF_ENABLED for use by broken hardware only (and make a
TAINT flag for that too).



