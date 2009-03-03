From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 03 Mar 2009 11:39:58 +0100
Message-ID: <1236076799.22914.31.camel@twins>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	 <200903021633.08736.david-b@pacbell.net> <20090303004427.GA8638@elte.hu>
	 <200903021837.08635.david-b@pacbell.net> <1236072446.18955.44.camel@twins>
	 <20090303094743.030b2507@lxorguk.ukuu.org.uk>
	 <20090303100329.GA5050@elte.hu>
	 <20090303103041.0ba4aebd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep15-int.chello.at ([62.179.121.35]:32292 "EHLO
	viefep15-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbZCCKkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 05:40:24 -0500
In-Reply-To: <20090303103041.0ba4aebd@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Tue, 2009-03-03 at 10:30 +0000, Alan Cox wrote:
> 
> > So there's no real technical problem here.
> 
> In the long term no - but forcing people to make sudden changes to
> critical I/O drivers isn't the right way to do it.

My plan is:
 1) find all drivers that do not use IRQF_DISABLED
 2) add IRQF_LEGACY_ENABLED to those
 3) make IRQF_DISABLED 0 and remove its functionality
    while adding IRQF_LEGACY_ENABLED
 4) make request_irq() print a warning for IRQF_LEGACY_ENABLED
 5) make an actual IRQF_LEGACY_ENABLED irq firing taint the kernel

After that its cleanup time, and I'll try to help out converting some of
these to threaded IRQs where appropriate.

This will not break any driver, nor force sudden change. Stuff will
continue working as expected, just a little more boot noise for those
with crappy drivers/hardware.

