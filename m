From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 13:29:53 -0800
Message-ID: <20090302132953.27126b78.akpm@linux-foundation.org>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	<200903011454.22280.david-b@pacbell.net>
	<1235999772.5330.368.camel@laptop>
	<200903021304.56881.david-b@pacbell.net>
	<1236028617.18955.14.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51148 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753293AbZCBVax (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 16:30:53 -0500
In-Reply-To: <1236028617.18955.14.camel@twins>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: david-b@pacbell.net, tglx@linutronix.de, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

On Mon, 02 Mar 2009 22:16:57 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > > we should simply always disable interrupts for 
> > > interrupt handlers.
> > 
> > That would be why you have refused to fix the bug
> > in lockdep, whereby it forcibly enables that flag?
> > 
> > I've been wondering for some months now why you've
> > left that bug unfixed.
> 
> Because running irq handlers with irqs enabled it plain silly.

Do we get to revert irqstacks?
