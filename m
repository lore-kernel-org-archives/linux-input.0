From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sat, 28 Feb 2009 17:42:10 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0902281741560.29264@localhost.localdomain>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902272046.50572.david-b@pacbell.net> <alpine.LFD.2.00.0902281208270.29264@localhost.localdomain> <200902280416.26687.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:60916 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbZB1Qmo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 11:42:44 -0500
In-Reply-To: <200902280416.26687.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Sat, 28 Feb 2009, David Brownell wrote:
> On Saturday 28 February 2009, Thomas Gleixner wrote:
> > On Fri, 27 Feb 2009, David Brownell wrote:
> > >   drivers/mfd/twl4030-irq.c
> > > 
> > > Where you'll observe twl_init_irq() at line 688 setting
> > > up the thread and the Primary IRQ Handler (PIH) dispatch.
> > > That's pretty much bog-standard chained IRQ setup code,
> > > except that it chains through a thread.
> > 
> > So this would be the perfect candidate to test the generic threaded
> > code I posted a few days ago ?
> 
> Could be.  URL?

http://lkml.org/lkml/2009/2/26/146

	tglx
 
