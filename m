Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EE2D3733
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783279834; cv=none; b=ilgrf8MQIOzPDWcbDheAHPnADRjx4cu+5IJxjikcwX4IoiHJUASIoSq2bNoNrCQRYKdvHPZ9LcIQfS0WbkDHiu8W7nkVUuQB9HnL2mnx578KiH2l5u+raOCcTlFnFFMoVD3lStF9eeVrQEKnEuntHS11RjIJmw50Bw8x7+PTRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783279834; c=relaxed/simple;
	bh=uSIAwpK/+9XxHymQpXgFJB87PMqywG6NFybVM3NNlag=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DA5R93IfmnfwZN8FyUst4Gp6S28Dv7pSRDaOd9TopL7cpk8huZ1yHtCLM487y+s0dt1tgtoYVvCUgy/rnA8c6c4ZOrwBN3lx8oA67xxC4lUBRQpo+pCONiwGqvmwblCWhZQjbEuoBBcYPRauVwGy7GoO1YKN0xdP9bUf5XgNGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-489677a16bbso1484672b6e.0
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 12:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783279831; x=1783884631;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bip8J7nGH4EOQWWiUG/nfgdNAtMJIbhnVnhhcbv4l+A=;
        b=EEiaHPaiocKc1JEbDqQrv5wPIqe1vsdSEtku0K8JsAh342Csp66ez14RlinzaGCn+D
         FutTMTIp0wkDa5llv1usWdVgVImF+S4FOq1eFghwCvUUUIYVBmJyhwG5MCM8Ujfh0jXC
         OAsV1V8gf7bW0bx4O+TQNfAXWsLePbicsqvq26DXEg/OeMJ1jpBpMjBVbYx+Bz5E8Kg6
         oe9W5djrbSLzVMbUer1GPYBTOI2eoJtdMQJ/qzlPX1LtTM39zbcudO5FmNHAYjzRdRYp
         ncTxRkn9KEp7PMlIJ7J/uF3AcsD49G1v2wfzerOLEERgkpSNuhTQkVzxTpFs1dOda579
         2HcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9InLIip8So+J/TzsnKzncuYlV/g/HLDu//KnI9oikGKwRZF3vHLj/92+HTu34U8VP/RDQHcmT71cDxFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8T4Qpiaza7dQg7c6N79gwJ6SiSaKzQw1m1qm+z9A73mE5BYtQ
	RoeZM9aSBBi0TOaBtbR7kBvzAd3ml4wEZuMzm5wPIP81s/ajSx106UWa5pnaDf+dp9m37WGPY6u
	5FF0mMPM6ByWIHp3JiU9GiUyj2YQZ3D/zgt/IHvA/8Rt7SNTxp1/tWqH8uo0=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:159d:b0:48f:ba75:4d86 with SMTP id
 5614622812f47-499bbe34820mr6130476b6e.32.1783279830996; Sun, 05 Jul 2026
 12:30:30 -0700 (PDT)
Date: Sun, 05 Jul 2026 12:30:30 -0700
In-Reply-To: <69e31ea7.050a0220.24bfd3.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4ab0d6.b42ede87.8bd1.0012.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] INFO: task hung in devres_release_group (2)
From: syzbot <syzbot+d789904ff97c2f3dac88@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b763db0c276 Add linux-next specific files for 20260703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129e3b39580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c288f117a992ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=d789904ff97c2f3dac88
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169e3b39580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119e3b39580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8089f1fba297/disk-2b763db0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/97090b3387c9/vmlinux-2b763db0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e3e98867f8/bzImage-2b763db0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d789904ff97c2f3dac88@syzkaller.appspotmail.com

INFO: task kworker/0:2:200 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:21496 pid:200   tgid:200   ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1709/0x5530 kernel/sched/core.c:7231
 __schedule_loop kernel/sched/core.c:7308 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7323
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 i2c_del_adapter+0x281/0x430 drivers/i2c/i2c-core-base.c:1840
 release_nodes drivers/base/devres.c:546 [inline]
 devres_release_group+0x264/0x360 drivers/base/devres.c:739
 hid_device_remove+0x11c/0x1d0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3961
 hid_remove_device drivers/hid/hid-core.c:3078 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3100
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3961
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5953
 process_one_work+0xaaf/0x1480 kernel/workqueue.c:3379
 process_scheduled_works kernel/workqueue.c:3462 [inline]
 worker_thread+0xb05/0x10d0 kernel/workqueue.c:3543
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.3.113:6124 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.113       state:D stack:24712 pid:6124  tgid:6124  ppid:5776   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1709/0x5530 kernel/sched/core.c:7231
 __schedule_loop kernel/sched/core.c:7308 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7604
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:947
 vfs_open+0x3b/0x350 fs/open.c:1052
 do_open fs/namei.c:4694 [inline]
 path_openat+0x2e64/0x3850 fs/namei.c:4857
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b1e81e68e
RSP: 002b:00007fff96046768 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055558f391500 RCX: 00007f6b1e81e68e
RDX: 000000000000a401 RSI: 00007fff96046840 RDI: ffffffffffffff9c
RBP: 00007fff96046840 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: cccccccccccccccd
R13: 00007f6b1eae5fac R14: 00007f6b1eae5fa0 R15: 00007f6b1eae5fa0
 </TASK>
INFO: task syz.4.114:6125 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.114       state:D stack:24712 pid:6125  tgid:6125  ppid:5777   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1709/0x5530 kernel/sched/core.c:7231
 __schedule_loop kernel/sched/core.c:7308 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7604
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:947
 vfs_open+0x3b/0x350 fs/open.c:1052
 do_open fs/namei.c:4694 [inline]
 path_openat+0x2e64/0x3850 fs/namei.c:4857
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23e29fe68e
RSP: 002b:00007ffd83e58858 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00005555860fe500 RCX: 00007f23e29fe68e
RDX: 000000000000a401 RSI: 00007ffd83e58930 RDI: ffffffffffffff9c
RBP: 00007ffd83e58930 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: cccccccccccccccd
R13: 00007f23e2cc5fac R14: 00007f23e2cc5fa0 R15: 00007f23e2cc5fa0
 </TASK>
INFO: task syz.2.115:6126 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.115       state:D stack:24712 pid:6126  tgid:6126  ppid:5770   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1709/0x5530 kernel/sched/core.c:7231
 __schedule_loop kernel/sched/core.c:7308 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7604
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:947
 vfs_open+0x3b/0x350 fs/open.c:1052
 do_open fs/namei.c:4694 [inline]
 path_openat+0x2e64/0x3850 fs/namei.c:4857
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f807aa2e68e
RSP: 002b:00007ffe18ae0728 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000555582e4d500 RCX: 00007f807aa2e68e
RDX: 000000000000a401 RSI: 00007ffe18ae0800 RDI: ffffffffffffff9c
RBP: 00007ffe18ae0800 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: cccccccccccccccd
R13: 00007f807acf5fac R14: 00007f807acf5fa0 R15: 00007f807acf5fa0
 </TASK>
INFO: task syz.1.116:6127 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.116       state:D stack:24712 pid:6127  tgid:6127  ppid:5774   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1709/0x5530 kernel/sched/core.c:7231
 __schedule_loop kernel/sched/core.c:7308 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7604
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:947
 vfs_open+0x3b/0x350 fs/open.c:1052
 do_open fs/namei.c:4694 [inline]
 path_openat+0x2e64/0x3850 fs/namei.c:4857
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c6723e68e
RSP: 002b:00007ffd2928b0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055555f817500 RCX: 00007f0c6723e68e
RDX: 000000000000a401 RSI: 00007ffd2928b1c0 RDI: ffffffffffffff9c
RBP: 00007ffd2928b1c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: cccccccccccccccd
R13: 00007f0c67505fac R14: 00007f0c67505fa0 R15: 00007f0c67505fa0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6821
7 locks held by kworker/u8:5/69:
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc9000154fc60 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc9000154fc60 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc9000154fc60 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #2: ffff88806d354310 (&devlink->lock_key#28){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xcb0 drivers/net/netdevsim/dev.c:909
 #3: ffff88807ff3f920 (&nsim_trap_data->trap_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff88807ff3f920 (&nsim_trap_data->trap_lock){+.+.}-{3:3}, at: nsim_dev_trap_report drivers/net/netdevsim/dev.c:862 [inline]
 #3: ffff88807ff3f920 (&nsim_trap_data->trap_lock){+.+.}-{3:3}, at: nsim_dev_trap_report_work+0x1e0/0xcb0 drivers/net/netdevsim/dev.c:922
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #5: ffffffff8e0592e0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #6: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
6 locks held by kworker/0:2/200:
 #0: ffff888021ee5538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff888021ee5538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff888021ee5538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc900039dfc60 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc900039dfc60 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc900039dfc60 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #2: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: hub_event+0x187/0x4cf0 drivers/usb/core/hub.c:5899
 #3: ffff88801f6b4210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88801f6b4210 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xe3/0x990 drivers/usb/core/hub.c:2336
 #4: ffff888021afb1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff888021afb1d8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff888021afb1d8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
 #5: ffff888043dcda90 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #5: ffff888043dcda90 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #5: ffff888043dcda90 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
2 locks held by kworker/u8:11/1173:
 #0: ffff888032b53938 ((wq_completion)bat_events){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff888032b53938 ((wq_completion)bat_events){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff888032b53938 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc9000630fc60 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc9000630fc60 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc9000630fc60 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
6 locks held by kworker/u8:16/4350:
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc9000e78fc60 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc9000e78fc60 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc9000e78fc60 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #2: ffff88802f5da310 (&devlink->lock_key#23){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xcb0 drivers/net/netdevsim/dev.c:909
 #3: ffff888079055520 (&nsim_trap_data->trap_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff888079055520 (&nsim_trap_data->trap_lock){+.+.}-{3:3}, at: nsim_dev_trap_report drivers/net/netdevsim/dev.c:862 [inline]
 #3: ffff888079055520 (&nsim_trap_data->trap_lock){+.+.}-{3:3}, at: nsim_dev_trap_report_work+0x1e0/0xcb0 drivers/net/netdevsim/dev.c:922
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
2 locks held by kworker/u8:19/4406:
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff88813fe5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc9000e3cfc60 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc9000e3cfc60 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc9000e3cfc60 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
2 locks held by getty/5359:
 #0: ffff8880327e20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cc62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x460/0x1360 drivers/tty/n_tty.c:2211
1 lock held by kworker/0:3/5747:
 #0: ffff88808326f938 ((wq_completion)wg-crypt-wg0#28){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff88808326f938 ((wq_completion)wg-crypt-wg0#28){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff88808326f938 ((wq_completion)wg-crypt-wg0#28){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
2 locks held by kworker/1:10/6020:
 #0: ffff888079480d38 ((wq_completion)wg-crypt-wg2#28){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff888079480d38 ((wq_completion)wg-crypt-wg2#28){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff888079480d38 ((wq_completion)wg-crypt-wg2#28){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc900015afc60 ((work_completion)(&peer->transmit_packet_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc900015afc60 ((work_completion)(&peer->transmit_packet_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc900015afc60 ((work_completion)(&peer->transmit_packet_work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
9 locks held by kworker/0:8/6023:
 #0: ffff888079480d38 ((wq_completion)wg-crypt-wg2#28){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff888079480d38 ((wq_completion)wg-crypt-wg2#28){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff888079480d38 ((wq_completion)wg-crypt-wg2#28){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc9000157fc60 ((work_completion)(&peer->transmit_packet_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc9000157fc60 ((work_completion)(&peer->transmit_packet_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc9000157fc60 ((work_completion)(&peer->transmit_packet_work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #2: ffffffff8e0592e0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #3: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #4: ffff88806681b790 (&peer->endpoint_lock){++..}-{3:3}, at: read_lock_bh include/linux/rwlock_rt.h:45 [inline]
 #4: ffff88806681b790 (&peer->endpoint_lock){++..}-{3:3}, at: wg_socket_send_skb_to_peer+0x6e/0x200 drivers/net/wireguard/socket.c:172
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rt_read_lock+0x277/0x4b0 kernel/locking/spinlock_rt.c:251
 #6: ffffffff8e0592e0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #7: ffffffff8e1c3820 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #7: ffffffff8e1c3820 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:893 [inline]
 #7: ffffffff8e1c3820 (rcu_read_lock_bh){....}-{1:3}, at: send4+0x217/0xec0 drivers/net/wireguard/socket.c:38
 #8: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #8: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #8: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #8: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
3 locks held by kworker/0:10/6027:
 #0: ffff88813fe1b938 ((wq_completion)events){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff88813fe1b938 ((wq_completion)events){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff88813fe1b938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc900042bfc60 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc900042bfc60 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc900042bfc60 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #2: ffff88802b13a280 (&data->fib_lock){+.+.}-{4:4}, at: nsim_fib_event_work+0x222/0x3e0 drivers/net/netdevsim/fib.c:1490
1 lock held by syz.3.113/6124:
 #0: ffff88823bf64210 (&dev->mutex
){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.4.114/6125:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.2.115/6126:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.1.116/6127:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.6.123/6301:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.5.122/6302:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.7.125/6306:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.8.126/6307:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.9.135/6427:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.3.136/6442:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.4.138/6470:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.1.139/6472:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.2.147/6530:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.5.149/6598:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.6.151/6636:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.7.153/6640:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.8.159/6689:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.9.162/6754:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.3.164/6825:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.4.165/6832:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.1.169/6851:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.2.173/6887:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.5.177/6981:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.6.178/7018:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.7.181/7044:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
1 lock held by syz.8.183/7061:
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88823bf64210 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x790 drivers/usb/core/devio.c:1054
5 locks held by syz-executor/7068:
 #0: ffffffff8f61d3a0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8f61d1b8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f61d1b8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f61d1b8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 #2: ffffffff8f5ac2f8 (rtnl_mutex){+.+.}-{4:4}, at: wiphy_register+0x1faf/0x2ff0 net/wireless/core.c:1154
 #3: ffff8880868c08d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: wiphy_lock include/net/cfg80211.h:6868 [inline]
 #3: ffff8880868c08d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: wiphy_register+0x1fb9/0x2ff0 net/wireless/core.c:1155
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 #4: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
2 locks held by modprobe/7113:
 #0: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e1c37c0 (rcu_read_lock){....}-{1:3}, at: fast_dput+0x1e/0x670 fs/dcache.c:938
 #1: ffff8880339095b0 (&lockref->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffff8880339095b0 (&lockref->lock){+.+.}-{3:3}, at: fast_dput+0x29c/0x670 fs/dcache.c:947

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 39 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4958 Comm: klogd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:__list_del include/linux/list.h:227 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:249 [inline]
RIP: 0010:list_move include/linux/list.h:329 [inline]
RIP: 0010:set_next_task_fair+0xce9/0x10b0 kernel/sched/fair.c:15171
Code: c1 e8 03 80 3c 28 00 74 08 4c 89 e7 e8 b0 ff 99 00 4d 89 34 24 4c 89 f0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 f7 e8 97 ff 99 00 <4d> 89 2e 4c 8b 64 24 08 4d 89 fd 49 c1 ed 03 41 80 7c 2d 00 00 74
RSP: 0018:ffffc90003a6f5b0 EFLAGS: 00000046
RAX: 1ffff110170e78a6 RBX: ffff888036f51fd8 RCX: dffffc0000000000
RDX: ffff888036f51fe8 RSI: ffff888036f51f80 RDI: ffff888036f51fe0
RBP: dffffc0000000000 R08: ffffffff8faf37f7 R09: 1ffffffff1f5e6fe
R10: dffffc0000000000 R11: fffffbfff1f5e6ff R12: ffff888034e8bee0
R13: ffff888034e8bed8 R14: ffff8880b873c530 R15: ffff8880b873c530
FS:  00007f76e13e8c80(0000) GS:ffff888125d49000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007effe5be7e9c CR3: 00000000374a8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 put_prev_set_next_task kernel/sched/sched.h:2787 [inline]
 __pick_next_task+0x215/0x3c0 kernel/sched/core.c:6149
 pick_next_task kernel/sched/core.c:-1 [inline]
 __schedule+0x861/0x5530 kernel/sched/core.c:7146
 __schedule_loop kernel/sched/core.c:7308 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7323
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 unix_wait_for_peer+0x1f5/0x2f0 net/unix/af_unix.c:1615
 unix_dgram_sendmsg+0xaf4/0x17b0 net/unix/af_unix.c:2251
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:810
 __sock_sendmsg net/socket.c:825 [inline]
 __sys_sendto+0x41e/0x5d0 net/socket.c:2292
 __do_sys_sendto net/socket.c:2299 [inline]
 __se_sys_sendto net/socket.c:2295 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2295
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76e1538407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffe12658f20 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f76e13e8c80 RCX: 00007f76e1538407
RDX: 0000000000000048 RSI: 00007ffe12659060 RDI: 0000000000000003
RBP: 00007ffe12659490 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000202 R12: 00007ffe126594a8
R13: 00007ffe12659060 R14: 000000000000002d R15: 00007ffe12659060
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
