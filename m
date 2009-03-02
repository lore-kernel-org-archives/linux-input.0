From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 13:04:56 -0800
Message-ID: <200903021304.56881.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903011454.22280.david-b@pacbell.net> <1235999772.5330.368.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n25.bullet.mail.mud.yahoo.com ([68.142.206.220]:36178 "HELO
	n25.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752490AbZCBVFB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 16:05:01 -0500
In-Reply-To: <1235999772.5330.368.camel@laptop>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

On Monday 02 March 2009, Peter Zijlstra wrote:
> IRQF_DISABLED is bonkers,

Hmm, after all the work that's been done to get Linux
to the point where *most* drivers run without IRQs
enabled ... that sentiment surprises me.

And I suspect it would surprise most driver developers.


> we should simply always disable interrupts for 
> interrupt handlers.

That would be why you have refused to fix the bug
in lockdep, whereby it forcibly enables that flag?

I've been wondering for some months now why you've
left that bug unfixed.


