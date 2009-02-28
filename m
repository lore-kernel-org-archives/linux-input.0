From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs
Date: Sat, 28 Feb 2009 12:10:46 -0800
Message-ID: <200902281210.46672.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902271350.32380.david-b@pacbell.net> <49A91DE8.7000700@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n20.bullet.mail.mud.yahoo.com ([68.142.206.147]:37190 "HELO
	n20.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753110AbZB1UKv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 15:10:51 -0500
In-Reply-To: <49A91DE8.7000700@s5r6.in-berlin.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: me@felipebalbi.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>

On Saturday 28 February 2009, Stefan Richter wrote:
> David Brownell wrote:
> > The other is that Linux needs real support for threaded
> > interrupts.  Almost every I2C (or SPI) device that raises
> > an IRQ needs its IRQ handler to run in a thread, and most
> > of them have the same type of workqueue-based hack to
> > get such a thread.  (Some others have bugs instead...)
> 
> Since when is having an IRQ handler scheduling a workqueue job a hack?

The only "hack" I recall mentioning was the need to
forcibly re-enable IRQs that lockdep wrongly disabled.


> In kernels whose IRQ handlers don't sleep, we don't pretend that they
> could; instead we defer sleeping work to a context which can sleep.
> 
> Or from another angle:  If a driver requires a kernel with sleeping IRQ
> handlers, why submit it for inclusion into a kernel which does not

(yet)

> provide nonatomic context to IRQ handlers?

Or from yet another angle:  how will progress ever happen
if nobody pushes the boundaries?  :)

We've known for ages that threaded IRQs will eventually
show up in mainline.  Better IMO to plan for that, and
expect minor changes to the drivers which have needed them
all along.

- Dave

