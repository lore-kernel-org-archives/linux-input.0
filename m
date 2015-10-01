From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Thu, 1 Oct 2015 07:34:02 +0200
Message-ID: <CA+icZUXDd0qU274mk-ownmpo+C-3ztFBkuwXO6k_TvrVuOCz3g@mail.gmail.com>
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
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34900 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbJAFeE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 01:34:04 -0400
Received: by vkao3 with SMTP id o3so33114777vka.2
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2015 22:34:02 -0700 (PDT)
In-Reply-To: <20150930220153.7a75c4fc@grimm.local.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Thu, Oct 1, 2015 at 4:01 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 1 Oct 2015 00:37:52 +0200
> Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
>> No, that did not help.
>>
>> $ dmesg | grep BUG:
>> [   24.491708] BUG: sleeping function called from invalid context at
>> kernel/workqueue.c:2678
>>
>> $ grep -i parav /boot/config-$(uname -r)
>> # CONFIG_PARAVIRT is not set
>
> Hmm, is this SMP or UP?
>

Es Em Pee...

$ grep SMP /boot/config-4.3.0-rc3-11-llvmlinux-amd64 | grep ^CONFIG
CONFIG_X86_64_SMP=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_SMP=y
CONFIG_PM_SLEEP_SMP=y

$ grep -i smp dmesg_4.3.0-rc3-11-llvmlinux-amd64.txt
[    0.000000] Linux version 4.3.0-rc3-11-llvmlinux-amd64
(sedat.dilek@gmail.com@fambox) (clang version 3.7.0
(tags/RELEASE_370/final)) #1 SMP Thu Oct 1 00:09:12 CEST 2015
[    0.000000] found SMP MP-table at [mem 0x000f00e0-0x000f00ef]
mapped at [ffff8800000f00e0]
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.031211] Freeing SMP alternatives memory: 24K (ffffffff821e3000
- ffffffff821e9000)
[    0.184518] smpboot: CPU0: Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
(family: 0x6, model: 0x2a, stepping: 0x7)
[    0.186815] x86: Booting SMP configuration:
[    0.195749] smpboot: Total of 4 processors activated (12771.39 BogoMIPS)

- Sedat -
