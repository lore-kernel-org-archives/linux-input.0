From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 22:01:53 -0400
Message-ID: <20150930220153.7a75c4fc@grimm.local.home>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
	<alpine.LNX.2.00.1509300918090.30132@pobox.suse.cz>
	<20150930045655.1c52eecd@gandalf.local.home>
	<CA+icZUUnoD8_=Wm+OM2pN0ZS-rwqjLHtTw5xCWe5epNqSTZSiQ@mail.gmail.com>
	<20150930061351.06f06abd@gandalf.local.home>
	<CA+icZUXSzScTmMgLZwPQq9RMH9cUsD5_iDxKTVuG0rrGqH-8Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:29688 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751931AbbJACJH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 22:09:07 -0400
In-Reply-To: <CA+icZUXSzScTmMgLZwPQq9RMH9cUsD5_iDxKTVuG0rrGqH-8Cw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Thu, 1 Oct 2015 00:37:52 +0200
Sedat Dilek <sedat.dilek@gmail.com> wrote:

> No, that did not help.
> 
> $ dmesg | grep BUG:
> [   24.491708] BUG: sleeping function called from invalid context at
> kernel/workqueue.c:2678
> 
> $ grep -i parav /boot/config-$(uname -r)
> # CONFIG_PARAVIRT is not set

Hmm, is this SMP or UP?

-- Steve

