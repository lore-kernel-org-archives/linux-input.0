From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs
Date: Sat, 28 Feb 2009 12:19:53 -0800
Message-ID: <200902281219.54200.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902272046.50572.david-b@pacbell.net> <49A92487.3020108@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:22198 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753229AbZB1UT5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 15:19:57 -0500
In-Reply-To: <49A92487.3020108@s5r6.in-berlin.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl, tglx@linutronix.de

On Saturday 28 February 2009, Stefan Richter wrote:
> Ah, so there /is/ a threaded IRQ handler implementation in
> the mainline, down in some driver framework...

One that's a bit more powerful than the recent patch
proposal, I'd say, since it chains.

 
> Why don't these drivers simply use <linux/workqueue.h>?

Most do.  In fact, that one *does* ... what's your point?

If I hadn't know that more generic threaded IRQ support
was already on the way, I might have done more with that
particular driver than just massive cleanup.  I stopped
short of some changes that it seemed genirq should obviate
before too long.  As always, more cleanup *could* be done.

- Dave

