From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 15:29:07 -0800
Message-ID: <200903021529.07894.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021440.58712.david-b@pacbell.net> <1236034289.5330.1745.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n15b.bullet.mail.mud.yahoo.com ([68.142.207.236]:35302 "HELO
	n15b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752368AbZCBX3M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 18:29:12 -0500
In-Reply-To: <1236034289.5330.1745.camel@laptop>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: dbrownell@users.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

On Monday 02 March 2009, Peter Zijlstra wrote:
> > But if that's what is keeping you from fixing the lockdep bug,
> > why haven't you submitted patches to remove IRQF_DISABLED from
> > the kernel, and update all the drivers relying on IRQs being
> > enabled when their handlers run?
> 
> I did so today. Just didn't realize things actually relied on it since
> lockdep turned them off and my system has been working fine.

That patch did no such thing.  It added a BUG_ON(),
which has nothing to do with removing IRQF_DISABLED.


> Your driver needs threaded interrupts, Thomas is working on that now,
> and I saw a conversion of your driver to use that.

Thomas hasn't yet touched the issue of how to chain such IRQs
though ... I consider his v2 patches a decent start, with some
limitations that could be attributed to an x86 focus.


> IDE PIO can hopefully also be converted to threaded interrupts.

I have worked with ARMs with IDE support.  That's become
rare in new chips though, even for CF cards; it needs too
many signal wires.

- Dave


