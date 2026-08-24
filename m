Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670432D0F5
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580938; cv=none; b=fn557/7EhtAk4bClUSC2qArDH1IwqndzfZUDogEJs36Wfuagdtohv1wYusdxQWElG+pq7PY2U+EYHWaPJ/mnboCwoGkHQRyfYg9f/pX820NEA3ELEUCdGdio7+fd2rDlI07cwLV4qzydvY0unuUuFJVE/hxK/nPn5IO3G3g2flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580938; c=relaxed/simple;
	bh=rLMheNznZJmNpnLmvy1g5vyO1AY4iNFH8Be1EMrypKg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZYfVd6N6j6dcDrYATXXficmoWdHAO79iUTEVJW096j3RaYeLitcpK/Z6Wu58kAnynQroxzylUFBYAAtaEpYwUHz23aEaG6E+BWItxbVgd+d4cuh/0Fe/jrPr+yhNSvXKIv1I3HmWFdYNFXCnCW5RrEAvdVQXCy+QdSdXU9vlNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso1708849b6e.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 07:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580936; x=1788185736;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjtSZ0Hk74hXFJV7KOTWyhOW5rok74z5TqFOPkrY64s=;
        b=MTOQf4owICeIQ2l6M1H6I77lmf7aLtvf19ySWc0kC5WsZxMpPUHb9jABjgGUKsA6bt
         lFe0WjHAGb//d+lKNc/I4wewIDyECnuiZwjK6JGdSTgn40owsGadXndLn8rpe9Ve2ncO
         +ikhgbUxAGMudtBSSK6gdPXmNmG/FlP/G7mPAIkXmtz5m5+DEIwwdLUYx1FMi9+pNWLg
         0CVs2gZbK47c+IS+lSB48Rhnw0CYeMdlM7QkAH9qhIXkM8lvnRCn69s83RNOy5RSMEOT
         GVv9KrdW9kcUUmSazujXKbcQIAEspdqAwBpolGjoQLGSBHcmZXmSq6yiTM8Q1y9c7UJZ
         2a1A==
X-Forwarded-Encrypted: i=1; AHgh+RrqdAOe7vjYgrVoLhVqjJ0Xu80utezGoot7MsurBh2RciBqnHwfLVx4PgYtpqmxZ8cUmLRX/3nP/aGnMg==@vger.kernel.org
X-Gm-Message-State: AFuF++nA5C2whli4EfD0bJ96Is96IXn/QopbZT+sJrY+MRA+EFiMnWjK
	6gd90DDOQTEOEFwoaRl2mrxBCPmepNjXTVS78AXUCcqPM+QlhlB/StWD9zYvGSoFSepA5iQ33XC
	mdF6BOLk1sbNT3PDwmr+jZnhMrcD4yZBF5oDTsMykmelznIQUxWdbKq9F/MA=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f69:b0:4a4:a930:1f76 with SMTP id
 5614622812f47-4b2ef3387cfmr26663246b6e.11.1787580936043; Mon, 24 Aug 2026
 07:15:36 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:15:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8c5208.dbb3a75c.7844.0005.GAE@google.com>
Subject: [syzbot] [usb?] [input?] INFO: task hung in usb_set_configuration
From: syzbot <syzbot+c22bb42560ec86726aba@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e1e6e541c5c9 Merge tag 'thunderbolt-for-v7.3-rc1' of ssh:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=143df815580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bdeea7ee6735f91
dashboard link: https://syzkaller.appspot.com/bug?extid=c22bb42560ec86726aba
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1783ba25580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b0a1f8e6a1f/disk-e1e6e541.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f98d855e85e8/vmlinux-e1e6e541.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db2c3a41df6d/bzImage-e1e6e541.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c22bb42560ec86726aba@syzkaller.appspotmail.com

INFO: task kworker/0:2:733 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D
 stack:26352 pid:733   tgid:733   ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1325/0x47d0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0xccc/0x1bd0 kernel/locking/mutex.c:821
 uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xba8/0x18b0 lib/kobject_uevent.c:611
 device_add+0x1173/0x1970 drivers/base/core.c:3738
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2708
 usb_new_device drivers/usb/core/hub.c:5833 [inline]
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5966
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:1/11:
 #0: 
ffff8881062b0540
 (
(wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x12b1/0x1940 kernel/workqueue.c:3297
 #1: 
ffffc900000bfd18
 (
(work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work+0x988/0x1940 kernel/workqueue.c:3298
 #2: 
ffff88810b3051d8


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
