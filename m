From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: lockdep and threaded IRQs
Date: Sat, 28 Feb 2009 12:48:23 +0100
Message-ID: <49A92487.3020108@s5r6.in-berlin.de>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902271830.37207.david-b@pacbell.net> <20090227183949.90f231e6.akpm@linux-foundation.org> <200902272046.50572.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:42142 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZB1LtV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 06:49:21 -0500
In-Reply-To: <200902272046.50572.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl, tglx@linutronix.de

David Brownell wrote:
> Now, where is that being set up as being threaded?  I
> referenced that a message or two earlier:
> 
>   drivers/mfd/twl4030-irq.c
> 
> Where you'll observe twl_init_irq() at line 688 setting
> up the thread and the Primary IRQ Handler (PIH) dispatch.
> That's pretty much bog-standard chained IRQ setup code,
> except that it chains through a thread.
> 
> When an IRQ comes in, handle_twl4030_pih() acks and masks
> that top level IRQ.  Then it wakes twl4030_irq_thread(),
> which issues I2C operations to read the IRQ status from
> the chip ... first PIH to find out which SIH modules are
> raising an IRQ, then SIH to dispatch that status.  Then
> handle_irq() from that thread to invoke the handler in
> that thread context; it will issue more I2C ops.
> 
> And the lockdep thing kicks in through handle_irq(),
> where the IRQ handler wrongly gets invoked with the
> IRQs disabled -- iff lockdep is enabled.  Otherwise,
> that IRQ thread is just like any other thread.

Ah, so there /is/ a threaded IRQ handler implementation in the mainline,
down in some driver framework...

Why don't these drivers simply use <linux/workqueue.h>?
-- 
Stefan Richter
-=====-==--= --=- ===--
http://arcgraph.de/sr/
