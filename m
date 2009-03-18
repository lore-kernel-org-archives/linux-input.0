From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 17 Mar 2009 18:04:39 -0700
Message-ID: <200903171804.39557.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090303103041.0ba4aebd@lxorguk.ukuu.org.uk> <20090303104836.GA11532@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n21.bullet.mail.mud.yahoo.com ([68.142.206.160]:29497 "HELO
	n21.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753029AbZCRDGI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Mar 2009 23:06:08 -0400
In-Reply-To: <20090303104836.GA11532@elte.hu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Tuesday 03 March 2009, Ingo Molnar wrote:
> i think you severely over-estimate the importance and ratio of 
> drivers that enable irqs within irq handlers. (Nor does anyone 
> want to break them really - we want to have a sane default and 
> we want to flag the broken cases as broken.)

For the record, I've been running for some time now
with a patch that issues a warning for each IRQ that
lockdep forces to use IRQF_DISABLED.

On my x86 systems, pretty much every driver triggers
that warning.  Which makes me think maybe that shoe
is being placed on the wrong foot:  use of IRQF_DISABLED
is the *EXCEPTION* not the rule.  At least on one major
Linux platform...


