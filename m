Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA12DB794
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297440; cv=none; b=MvJQ2u4qdCJ2zhn/oPfKz3LXAV4nx13PTBuXBgdUDhSPHuw5XV/SAQ2nkoQXIZ/oGyg6HMvbbZLsymjxvDFdOxTVdjeugjMaFMOtJ7KOSgny5jjtXFRxjlaBiFlgikXhlZJnbNjfWDtJ2JlEvdNzjuYBnRq1vGMNB9hEyx7TeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297440; c=relaxed/simple;
	bh=M57OoBe+Dhn0GS86hcFw2/N3eUkClcMgX1c7fw+FKjU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hjt98NdZFztdSVbiIuilKbOu0AnqKrDOnYBhyCxOyuvEf/yYHvrNahTI0sQsFCGWaCbmDNvq4/jkJ8G/V+Jd4caKZfS4rL1Jz9KTwIhpAn1rMV+7K81I209ZMTxL7lKsFEWvHA0R9IMwSjPvi0h5GEnYHfbiUHrw3oQqajrj3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso324151b6e.1
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 00:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787297437; x=1787902237;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnkKnQeG68lJgWeheU0YaL4Zu2tHzFxH1bbP3Rgab7c=;
        b=IsIJxS+VJG9dFlPIX2ixoIYrCzKsnd02KYEeTutdGVTtRa6zPjzkaWLvz9var7uSel
         D7eA3IQd0MaNZEVBgEsOu1A0GzEn6EmCkuBr1jOwhy1hLdYMokJrxDP/zCj+CWGyxf4a
         Y8qJvEZ1YcgeVGpNHmHIXLDwEmwxcGSoWfcsesBYWZE4HG83AXc9AQL+j2DfDy+jkXDO
         2gJvSXMtp8OkWgs3Z+KfzrL12IqILMn5tKzPQSPcUOKaHn6oql7LBKtCAnkmHcDGN4nE
         NeH/8fFam9yJXQsdRvjJoEeM/32lwkCSvEyCYDfwIvG0wpLCpaaLh/FP+3XeCL1S1amS
         x9nQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9wFPAcewYppUk8ODCvaoZXlf9tE3vIOtN6oG29A7nlJhuByvub+kId9UFzVaa3cD3AYH2cruEHIEf6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgRB5TD8xIOYH63YraWFI17xBEkRm5GmtD+W6r3yV8qeiz/bJ
	vtigRWy3ASUunmhjkEGLyEsPfp9P1hWzJf6pVkRyYtnIC2zJo5sTkuh8BqCK1SL9yazUXifHbwc
	hI/yPdI3W6F9JbXTz8XvgouoNihYLFG+b+evv/RTbeCFde419IdZzaCRcUfE=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5087:b0:4b2:8e21:622e with SMTP id
 5614622812f47-4b2ef1bc216mr4465947b6e.1.1787297437306; Fri, 21 Aug 2026
 00:30:37 -0700 (PDT)
Date: Fri, 21 Aug 2026 00:30:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a87fe9d.ae6ddae5.3da009.002a.GAE@google.com>
Subject: [syzbot] [input?] BUG: sleeping function called from invalid context
 in __hid_request
From: syzbot <syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb68831eac7 Merge tag 'block-7.2-20260815' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118bfa79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca5f2f2c4197664
dashboard link: https://syzkaller.appspot.com/bug?extid=912222e4cb82423535fa
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dad6c6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14762679580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f9d6a54222e/disk-dcb68831.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b52c510b447/vmlinux-dcb68831.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8d408f8474e/bzImage-dcb68831.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com

rc_core: IR keymap rc-rc6-mce not found
Registered IR keymap rc-empty
rc rc0: syz0 as /devices/virtual/misc/uhid/0003:04D8:C002.0001/rc/rc0
input: syz0 as /devices/virtual/misc/uhid/0003:04D8:C002.0001/rc/rc0/input6
BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kworker/0:0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by kworker/0:0/9:
 #0: ffff88801b02b140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801b02b140 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc900000e7c40 ((work_completion)(&uhid->worker)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&uhid->worker)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffff88807116da58 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88807116da58 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #3: ffff888012576970 (&data->lock){....}-{3:3}, at: picolcd_set_contrast+0x135/0x300 drivers/hid/hid-picolcd_lcd.c:36
irq event stamp: 884670
hardirqs last  enabled at (884669): [<ffffffff8234ac1b>] kasan_quarantine_put+0xbb/0x1f0 mm/kasan/quarantine.c:234
hardirqs last disabled at (884670): [<ffffffff8bd51daa>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:130 [inline]
hardirqs last disabled at (884670): [<ffffffff8bd51daa>] _raw_spin_lock_irqsave+0x1a/0x60 kernel/locking/spinlock.c:166
softirqs last  enabled at (884626): [<ffffffff89988079>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last  enabled at (884626): [<ffffffff89988079>] __alloc_skb+0x189/0x7a0 net/core/skbuff.c:697
softirqs last disabled at (884622): [<ffffffff89988079>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (884622): [<ffffffff89988079>] __alloc_skb+0x189/0x7a0 net/core/skbuff.c:697
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events uhid_device_add_worker
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x378/0x4d0 kernel/sched/core.c:9197
 might_alloc include/linux/sched/mm.h:323 [inline]
 slab_pre_alloc_hook mm/slub.c:4537 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0xef/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 hid_alloc_report_buf drivers/hid/hid-core.c:1917 [inline]
 __hid_request+0xb2/0x490 drivers/hid/hid-core.c:2007
 picolcd_set_contrast+0x208/0x300 drivers/hid/hid-picolcd_lcd.c:39
 picolcd_init_lcd+0x1f9/0x2f0 drivers/hid/hid-picolcd_lcd.c:70
 picolcd_probe_lcd drivers/hid/hid-picolcd_core.c:477 [inline]
 picolcd_probe+0xbb1/0x16c0 drivers/hid/hid-picolcd_core.c:580
 __hid_device_probe drivers/hid/hid-core.c:2829 [inline]
 hid_device_probe+0x42c/0x7c0 drivers/hid/hid-core.c:2866
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3010
 uhid_device_add_worker+0x43/0xf0 drivers/hid/uhid.c:73
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
hid-picolcd 0003:04D8:C002.0001: No report with id 0x94 found
hid-picolcd 0003:04D8:C002.0001: failed to configure display


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
