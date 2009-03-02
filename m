From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 15:42:24 -0800
Message-ID: <200903021542.25153.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021520.30826.david-b@pacbell.net> <20090302232650.GA14515@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n23b.bullet.mail.mud.yahoo.com ([68.142.206.142]:32727 "HELO
	n23b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752796AbZCBXm3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 18:42:29 -0500
In-Reply-To: <20090302232650.GA14515@elte.hu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Monday 02 March 2009, Ingo Molnar wrote:
> If you want to work on genirq threaded IRQ handlers them please 
> check out and test the threaded IRQ handlers patches that are 
> being worked on at lkml. See:
> 
> [patch 0/4] genirq: add infrastructure for threaded interrupt handlers V2

I did check them out, as noted earlier in this thread.

The significant omission is lack of support for chaining
such threads.  Example, an I2C device that exposes
several dozen IRQs with mask/ack/... operations that
require I2C access.

I'm not sure what Thomas intends to do with that issue,
if anything.  It does touch on messy bits of genirq.

Those V2 patches do look to handle simple cases well,
of the flavor that's often handled today by creating
a singlethreaded workqueue in the driver.  I think
it's good to have such support, but that's not enough
to handle the hardware I've come across.

- Dave

