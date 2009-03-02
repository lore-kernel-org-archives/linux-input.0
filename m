From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 14:40:58 -0800
Message-ID: <200903021440.58712.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021409.21344.david-b@pacbell.net> <1236032371.5330.1654.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n19.bullet.mail.mud.yahoo.com ([68.142.206.146]:48658 "HELO
	n19.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752999AbZCBWlE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 17:41:04 -0500
In-Reply-To: <1236032371.5330.1654.camel@laptop>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: dbrownell@users.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

On Monday 02 March 2009, Peter Zijlstra wrote:
> I state that every !IRQF_DISABLED usage is a bug, either
> due to broken hardware or broken drivers.

That's a novel position.  You do realize that removing that
capability breaks drivers?

But if that's what is keeping you from fixing the lockdep bug,
why haven't you submitted patches to remove IRQF_DISABLED from
the kernel, and update all the drivers relying on IRQs being
enabled when their handlers run?

At least that would get the appropriate level of discussion.

- Dave


