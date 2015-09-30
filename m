From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 11:46:31 +0200
Message-ID: <CA+icZUUnoD8_=Wm+OM2pN0ZS-rwqjLHtTw5xCWe5epNqSTZSiQ@mail.gmail.com>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
	<alpine.LNX.2.00.1509300918090.30132@pobox.suse.cz>
	<20150930045655.1c52eecd@gandalf.local.home>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36711 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbI3Jqc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 05:46:32 -0400
Received: by vkfp126 with SMTP id p126so21926124vkf.3
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2015 02:46:31 -0700 (PDT)
In-Reply-To: <20150930045655.1c52eecd@gandalf.local.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Wed, Sep 30, 2015 at 10:56 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 30 Sep 2015 09:35:23 +0200 (CEST)
> Jiri Kosina <jikos@kernel.org> wrote:
>
>
>> [ ... snip a lot of stuff ... ]
>> > What shall I do... play with lockdep (print_irqtrace_events) in
>> > del_timer_sync()?
>
> Also, do you have PARAVIRT enabled by chance?
>

Yes.

CONFIG_PARAVIRT=y

Is that the corresponding indicator in dmesg-log?

[    0.000000] Booting paravirtualized kernel on bare hardware

What is your suspicion, Lt. Columbo?

- Sedat -

> -- Steve
>
>>
>> I'd suggest showing this to clang folks.
>>
>> Thanks,
>>
>
