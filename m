From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 3 Mar 2009 11:13:53 +0000
Message-ID: <20090303111353.5d9e4a8d@lxorguk.ukuu.org.uk>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	<200903021633.08736.david-b@pacbell.net>
	<20090303004427.GA8638@elte.hu>
	<200903021837.08635.david-b@pacbell.net>
	<1236072446.18955.44.camel@twins>
	<20090303094743.030b2507@lxorguk.ukuu.org.uk>
	<20090303100329.GA5050@elte.hu>
	<20090303103041.0ba4aebd@lxorguk.ukuu.org.uk>
	<20090303104836.GA11532@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58152 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbZCCLOQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 06:14:16 -0500
In-Reply-To: <20090303104836.GA11532@elte.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

> Hm, that reads like the boot IRQ erratas of certain chipsets - 
> the APIC could throw a fit essentially locking up the system. 
> FYI, we have fixes for that upstream already.

Good - certainly it used to be the case that masking APIC IRQs and
leaving them masked from the IRQ handled used to do funny things
sometimes.

> i think you severely over-estimate the importance and ratio of 
> drivers that enable irqs within irq handlers. (Nor does anyone 
> want to break them really - we want to have a sane default and 
> we want to flag the broken cases as broken.)

IDE. A lot less people use the IDE stack nowdays but its a big item and
getting it wrong tends to eat your files.


I do object to the attitude shown about "forcing" people. It's a
community project built by a large number of people on a mix of
pragmatic and elegant design balances. Maybe it's just unfortunate choice
of wording but it is the wrong sentiment.
