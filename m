From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 23:35:26 +0000
Message-ID: <20090302233526.3c694e22@lxorguk.ukuu.org.uk>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	<200903011454.22280.david-b@pacbell.net>
	<1235999772.5330.368.camel@laptop>
	<200903021304.56881.david-b@pacbell.net>
	<1236028617.18955.14.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57518 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754706AbZCBXfK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 18:35:10 -0500
In-Reply-To: <1236028617.18955.14.camel@twins>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Brownell <david-b@pacbell.net>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

> Because running irq handlers with irqs enabled it plain silly.

It makes enormous sense to run with the ability to mask *just* the IRQ
that occurred and not others so that long lasting interrupts. 

There is another reason not to do this of course - the real time work
makes it essentially irrelevant by doing the job right and reducing the
entire problem space to software priority management.
 
> Except it turns out there is some really broken ass hardware out there.
> But supposedly IDE PIO could be done from a threaded handler.

Only if you support reliable masking of a single IRQ *after* the IRQ
handler returns. The real time patches can do that for some chipsets but
on the PC at least you are into the realms of deepest darkest APIC
weirdness and that requires Ingo's pointy hat and wand..

Alan
