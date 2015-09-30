From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 06:13:51 -0400
Message-ID: <20150930061351.06f06abd@gandalf.local.home>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
	<alpine.LNX.2.00.1509300918090.30132@pobox.suse.cz>
	<20150930045655.1c52eecd@gandalf.local.home>
	<CA+icZUUnoD8_=Wm+OM2pN0ZS-rwqjLHtTw5xCWe5epNqSTZSiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:37118 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754969AbbI3KNy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 06:13:54 -0400
In-Reply-To: <CA+icZUUnoD8_=Wm+OM2pN0ZS-rwqjLHtTw5xCWe5epNqSTZSiQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Wed, 30 Sep 2015 11:46:31 +0200
Sedat Dilek <sedat.dilek@gmail.com> wrote:

> On Wed, Sep 30, 2015 at 10:56 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 30 Sep 2015 09:35:23 +0200 (CEST)
> > Jiri Kosina <jikos@kernel.org> wrote:
> >
> >
> >> [ ... snip a lot of stuff ... ]
> >> > What shall I do... play with lockdep (print_irqtrace_events) in
> >> > del_timer_sync()?
> >
> > Also, do you have PARAVIRT enabled by chance?
> >
> 
> Yes.
> 
> CONFIG_PARAVIRT=y
> 
> Is that the corresponding indicator in dmesg-log?
> 
> [    0.000000] Booting paravirtualized kernel on bare hardware
> 
> What is your suspicion, Lt. Columbo?
> 

Heh, I loved that show.

Can you see if you still have the issue if you disable that. PARAVIRT
adds a bit of magic when run on baremetal. See
arch/x86/kernel/alterative.c. On boot up, things like disabling
interrupts, which are originally compiled to perform a function call,
that on a virtual machine would do hypervisor calls into the host, and
on baremetal does the real code. But that alterative.c file will do
live patching of the code to not do the function call but instead do
the real work in place (if it can).

Something tells me that with clang, things are not as they're expected,
and perhaps the modification isn't working.

-- Steve

