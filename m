From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 04:56:55 -0400
Message-ID: <20150930045655.1c52eecd@gandalf.local.home>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
	<alpine.LNX.2.00.1509300918090.30132@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:36552 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754550AbbI3I47 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 04:56:59 -0400
In-Reply-To: <alpine.LNX.2.00.1509300918090.30132@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Wed, 30 Sep 2015 09:35:23 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:


> [ ... snip a lot of stuff ... ]
> > What shall I do... play with lockdep (print_irqtrace_events) in
> > del_timer_sync()?

Also, do you have PARAVIRT enabled by chance?

-- Steve

> 
> I'd suggest showing this to clang folks.
> 
> Thanks,
> 

