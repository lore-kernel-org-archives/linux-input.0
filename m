From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 02 Mar 2009 22:16:57 +0100
Message-ID: <1236028617.18955.14.camel@twins>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	 <200903011454.22280.david-b@pacbell.net> <1235999772.5330.368.camel@laptop>
	 <200903021304.56881.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754913AbZCBVRi@vger.kernel.org>
In-Reply-To: <200903021304.56881.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com
List-Id: linux-input@vger.kernel.org

On Mon, 2009-03-02 at 13:04 -0800, David Brownell wrote:
> On Monday 02 March 2009, Peter Zijlstra wrote:
> > IRQF_DISABLED is bonkers,
> 
> Hmm, after all the work that's been done to get Linux
> to the point where *most* drivers run without IRQs
> enabled ... that sentiment surprises me.
> 
> And I suspect it would surprise most driver developers.

How so?, its the natural extension of that work.

> > we should simply always disable interrupts for 
> > interrupt handlers.
> 
> That would be why you have refused to fix the bug
> in lockdep, whereby it forcibly enables that flag?
> 
> I've been wondering for some months now why you've
> left that bug unfixed.

Because running irq handlers with irqs enabled it plain silly.

Except it turns out there is some really broken ass hardware out there.
But supposedly IDE PIO could be done from a threaded handler.
