From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: lockdep and threaded IRQs
Date: Sat, 28 Feb 2009 12:20:08 +0100
Message-ID: <49A91DE8.7000700@s5r6.in-berlin.de>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090227123344.33196e99.akpm@linux-foundation.org> <20090227203717.GL16801@frodo> <200902271350.32380.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:42003 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbZB1LVc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 06:21:32 -0500
In-Reply-To: <200902271350.32380.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>

David Brownell wrote:
> The other is that Linux needs real support for threaded
> interrupts.  Almost every I2C (or SPI) device that raises
> an IRQ needs its IRQ handler to run in a thread, and most
> of them have the same type of workqueue-based hack to
> get such a thread.  (Some others have bugs instead...)

Since when is having an IRQ handler scheduling a workqueue job a hack?
In kernels whose IRQ handlers don't sleep, we don't pretend that they
could; instead we defer sleeping work to a context which can sleep.

Or from another angle:  If a driver requires a kernel with sleeping IRQ
handlers, why submit it for inclusion into a kernel which does not
provide nonatomic context to IRQ handlers?
-- 
Stefan Richter
-=====-==--= --=- ===--
http://arcgraph.de/sr/
