From: David Rientjes <rientjes@google.com>
Subject: Re: Linux 3.16-rc6
Date: Wed, 23 Jul 2014 18:53:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1407231849370.22577@chino.kir.corp.google.com>
References: <CA+55aFzJKxzw_as9iGgeM=MdQ6trUkQLDuoEr8nxj88sOqQnQA@mail.gmail.com> <20140723095327.GA23131@pd.tnic> <CA+55aFzPs4uF=eR7jCnpyBtgWNRkX-uDfXeo5u34VEvT8_yyzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33896 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbaGXBxU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 21:53:20 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so5947228igc.0
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 18:53:20 -0700 (PDT)
In-Reply-To: <CA+55aFzPs4uF=eR7jCnpyBtgWNRkX-uDfXeo5u34VEvT8_yyzw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Ming Lei <tom.leiming@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 23 Jul 2014, Linus Torvalds wrote:

> > Well, it looks like we f*cked up something after -rc5 since I'm starting
> > to see lockdep splats all over the place which I didn't see before. I'm
> > running rc6 + tip/master.
> >
> > There was one in r8169 yesterday:
> >
> > https://lkml.kernel.org/r/20140722081840.GA6462@pd.tnic
> >
> > and now I'm seeing the following in a kvm guest. I'm adding some more
> > lists to CC which look like might be related, judging from the stack
> > traces.
> 
> Hmm. I'm not seeing the reason for this.
> 
> > [   31.704282] [ INFO: possible irq lock inversion dependency detected ]
> > [   31.704282] 3.16.0-rc6+ #1 Not tainted
> > [   31.704282] ---------------------------------------------------------
> > [   31.704282] Xorg/3484 just changed the state of lock:
> > [   31.704282]  (tasklist_lock){.?.+..}, at: [<ffffffff81184b19>] send_sigio+0x59/0x1b0
> > [   31.704282] but this lock took another, HARDIRQ-unsafe lock in the past:
> > [   31.704282]  (&(&p->alloc_lock)->rlock){+.+...}
> 
> Ok, so the claim is that there's a 'p->alloc_lock' (ie "task_lock()")
> that is inside the tasklist_lock, which would indeed be wrong. But I'm
> not seeing it. The "shortest dependencies" thing seems to imply
> __set_task_comm(), but that only takes task_lock.
> 

It's the reverse, task_lock() inside tasklist_lock is fine but it's 
complaining about taking tasklist_lock inside task_lock().

I don't think it's anything that's sitting in tip/master nor is it 
something that was introduced during this merge window.  I think this has 
been the behavior dating back to commit 94dfd7edfd5c ("USB: HCD: support 
giveback of URB in tasklet context").
