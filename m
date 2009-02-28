From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sat, 28 Feb 2009 04:16:26 -0800
Message-ID: <200902280416.26687.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902272046.50572.david-b@pacbell.net> <alpine.LFD.2.00.0902281208270.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n21.bullet.mail.mud.yahoo.com ([68.142.206.160]:47554 "HELO
	n21.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751236AbZB1MQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 07:16:31 -0500
In-Reply-To: <alpine.LFD.2.00.0902281208270.29264@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Saturday 28 February 2009, Thomas Gleixner wrote:
> On Fri, 27 Feb 2009, David Brownell wrote:
> >   drivers/mfd/twl4030-irq.c
> > 
> > Where you'll observe twl_init_irq() at line 688 setting
> > up the thread and the Primary IRQ Handler (PIH) dispatch.
> > That's pretty much bog-standard chained IRQ setup code,
> > except that it chains through a thread.
> 
> So this would be the perfect candidate to test the generic threaded
> code I posted a few days ago ?

Could be.  URL?


