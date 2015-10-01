From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Thu, 1 Oct 2015 08:05:44 +0200
Message-ID: <CA+icZUV7pxXoApuLdc7Z=kMHiKG=diHNqsnR5-MHpER=XkjQVQ@mail.gmail.com>
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
	<20150930220153.7a75c4fc@grimm.local.home>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36382 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbJAGFp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 02:05:45 -0400
Received: by vkfp126 with SMTP id p126so33497513vkf.3
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2015 23:05:44 -0700 (PDT)
In-Reply-To: <20150930220153.7a75c4fc@grimm.local.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

I was thinking of disabling trace or ftrace and fell over some ftrace
patches in llvmlinux.
Comments?

- Sedat -

[1] http://git.linuxfoundation.org/?p=llvmlinux.git;a=blob;f=arch/x86_64/patches/ARCHIVE/0033-Various-fixes-in-arch-x86-include-asm.patch
[2] http://git.linuxfoundation.org/?p=llvmlinux.git;a=blob;f=arch/arm/patches/ftrace.patch
