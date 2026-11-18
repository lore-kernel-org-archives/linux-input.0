Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022627;
	b=0V2tyVcsqHqW6ldyGEVABiS1hmK40d2lzatvXaa3ZoV+okIOO3bGgrjBZMArkMxZKFPE
	 Dv0sT9ZjqGCt1FSGvwsOFOLYfqCRadRGu+b7yfP2kDGQu2M1S0jP2EdwuS3V1AbsDqqrt
	 QXT0qM+w5f2ObfgYuP0ERwHHZgf21qkUYL99i4K11+AQNR/4y5LURT841Vy2xEUw5pXwu
	 ga/JWgn3TIAX5P5h/9j11WSX2NDVUSQ6Wyv+zpglF3v6nbGmg/UyfM2jygZi/TH1ZsT7Z
	 TlKpxc0p0E5Rsx6Y0iHhuu5nPdu4YUHNZWJ+UcPN8FN39t2yD4aBCuQAR+ghlLF0YjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022627;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=0WVHmYGkgwACuyPT41zz46ARoB/OgpyaQBkCGhDyddQ=;
	b=JEowJzKRh8+SoIiUQG66udOqwQam+c/Q6Qm9LztQ/ElRFr7045KGNWsJISe1ezJ2ATHS
	 xh+yVT7NnRZptS8+onY7CSACtbjz+g7hRm6Zs58RM31pZXr1VbtLhR5ZQPRp1/UqIodYu
	 Ea2blrse/wh/RpCK27Wk4RaHqjuubKVSZnKMsiDcHp5vRkWxhxVDESYApK87x6aytYhlQ
	 Whq7S8574ID2kfqf9iVp9V5jGvErPd6tgrTdk0gcQnE0zq5hSz1WfzUZ2baiSGIXdqjqQ
	 jm4eEMG6ZNTDIlX4QtHASNbTQv2tRcS4zYZUSmBqPsxC7ZGNanyqKW0jQ33CemXfkvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52C606A332
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 17:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD52C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cc89e86e9eso1249680b6e.3
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 09:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795022625; x=1795627425;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WVHmYGkgwACuyPT41zz46ARoB/OgpyaQBkCGhDyddQ=;
        b=c+M+Vst6EQ076VYhN979SiZvK/hz4i6o4O6+cRlAyX8hts0Tr3vq0gxV/Y89XLoqRD
         WhMiPqkjeO57EKe9zHUeOBYFjh4zYeXLxNpJrR7zKd8gc5o2m4fd1Zb/s6MdfTsHZNGA
         uSgELSd0SXbKGy8fc0iUfealuHyX7KzMjf+5mRmsEAnVMMA2HvMIw9jKvPnhf1aRXq0Q
         mEu+IIRuCnVgou/5TKPs0nt+KDBR5JYbRqWOG9gJC47n9hNdnZvavMzQy8txFV9ccx2v
         0D74jrVmlma0CEG0cn5R34FmyVBLTPlCMUgIY6Ku1AT/umTbKhvhWtglvQ8nnZZGyGbC
         zgrw==
X-Gm-Message-State: APuU4Z+ceOpRTGV6KzKX1Np+2GVwkhLdrzqYz4dUHCfLY+wU1IvFEqc2
	TcF/0PCRmPv2QM19stqD7PnBSXe2NQJsOPOfhb82OPUsKkqoHG7PR3wATvCXqJG3Ap8YbGclHN3
	KO8ZwEOPWSkVoe7PsDS0ub/Eygt7UxJkBV9IKLc/J1ud+7yD2zsLGJH7Mvi8=
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:250c:b0:4ea:14ab:142d with SMTP id
 5614622812f47-57741131c55mr3283044b6e.40.1795022625426; Wed, 18 Nov 2026
 09:23:45 -0800 (PST)
Date: Wed, 18 Nov 2026 09:23:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afddf21.a11fe2ad.1b4426.0003.GAE@google.com>
Subject: [syzbot] [input?] [usb?] possible deadlock in sensor_hub_raw_event
From: syzbot <syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6628e7d4c6b2 Linux 7.4-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12f94d3d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bf69220d319004
dashboard link: https://syzkaller.appspot.com/bug?extid=fb951970a334aaff00ba
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b1ef35580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175834d9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d415be35d54e/disk-6628e7d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69e49385122b/vmlinux-6628e7d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51be81fff25f/bzImage-6628e7d4.xz

AI-generated root cause summary:
In sensor_hub_remove() (drivers/hid/hid-sensor-hub.c),
spin_lock_irqsave(&data->lock, flags) is held while calling
device_for_each_child(&hdev->dev, NULL, sensor_hub_finalize_pending_fn).
device_for_each_child() traverses child devices via klist_next(), which acquires
the driver core's &k->k_lock. Because &data->lock is also acquired in softirq
context by sensor_hub_raw_event() on incoming HID reports, while &k->k_lock is
acquired elsewhere with softirqs enabled, taking &k->k_lock while holding
&data->lock creates a classic irq lock inversion dependency that can trigger an
ABBA deadlock between process context and softirq context.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=fb951970a334aaff00ba

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com

usb 4-1: USB disconnect, device number 2
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
syzkaller #0 Not tainted
-----------------------------------------------------
kworker/1:0/23 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888122166c18 (&k->k_lock){+.+.}-{3:3}, at: klist_next+0x86/0x510 lib/klist.c:390

and this task is already holding:
ffff888121fa2cd8 (&sd->lock){..-.}-{3:3}, at: sensor_hub_remove+0x69/0xf0 drivers/hid/hid-sensor-hub.c:823
which would create a new lock dependency:
 (&sd->lock){..-.}-{3:3} -> (&k->k_lock){+.+.}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&sd->lock){..-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5942 [inline]
  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
  sensor_hub_raw_event+0x124/0x1340 drivers/hid/hid-sensor-hub.c:550
  __hid_input_report.constprop.0+0x319/0x470 drivers/hid/hid-core.c:2175
  hid_ctrl+0x4a4/0x560 drivers/hid/usbhid/hid-core.c:486
  __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
  usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
  dummy_timer+0xdb5/0x3840 drivers/usb/gadget/udc/dummy_hcd.c:2051
  __run_hrtimer kernel/time/hrtimer.c:2079 [inline]
  __hrtimer_run_queues+0x448/0x9a0 kernel/time/hrtimer.c:2136
  hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2153
  handle_softirqs+0x209/0xa00 kernel/softirq.c:669
  __do_softirq kernel/softirq.c:703 [inline]
  invoke_softirq kernel/softirq.c:542 [inline]
  __irq_exit_rcu+0x17a/0x220 kernel/softirq.c:786
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
  sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
  finish_task_switch.isra.0+0x214/0xad0 kernel/sched/core.c:5434
  context_switch kernel/sched/core.c:5586 [inline]
  __schedule+0x132d/0x4900 kernel/sched/core.c:7382
  schedule_idle+0x54/0x80 kernel/sched/core.c:7500
  do_idle+0x365/0x5b0 kernel/sched/idle.c:384
  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:458
  start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
  common_startup_64+0x13e/0x158

to a SOFTIRQ-irq-unsafe lock:
 (&k->k_lock){+.+.}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5942 [inline]
  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
  __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
  spin_lock include/linux/spinlock.h:347 [inline]
  add_tail lib/klist.c:104 [inline]
  klist_add_tail+0x38/0x150 lib/klist.c:138
  bus_add_driver+0x306/0x620 drivers/base/bus.c:780
  driver_register+0x1e2/0x360 drivers/base/driver.c:174
  faux_bus_init+0x6e/0xc0 drivers/base/faux.c:249
  driver_init+0x33/0x60 drivers/base/init.c:35
  do_basic_setup init/main.c:1514 [inline]
  kernel_init_freeable+0x473/0x7b0 init/main.c:1732
  kernel_init+0x21/0x1e0 init/main.c:1622
  ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&k->k_lock);
                               local_irq_disable();
                               lock(&sd->lock);
                               lock(&k->k_lock);
  <Interrupt>
    lock(&sd->lock);

 *** DEADLOCK ***

locks held by kworker/1:0/23: 7, last CPU#1:
 #0: ffff888105ea3948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1461/0x1b10 kernel/workqueue.c:3470
 #1: ffffc9000018fd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3471
 #2: ffff88810a7971d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #2: ffff88810a7971d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4510 drivers/usb/core/hub.c:5917
 #3: ffff888104a851d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #3: ffff888104a851d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x10a/0x9a0 drivers/usb/core/hub.c:2346
 #4: ffff8881212521a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #4: ffff8881212521a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1046 [inline]
 #4: ffff8881212521a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xa7/0x610 drivers/base/dd.c:1377
 #5: ffff888121fb1a58 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1109 [inline]
 #5: ffff888121fb1a58 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1046 [inline]
 #5: ffff888121fb1a58 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xa7/0x610 drivers/base/dd.c:1377
 #6: ffff888121fa2cd8 (&sd->lock){..-.}-{3:3}, at: sensor_hub_remove+0x69/0xf0 drivers/hid/hid-sensor-hub.c:823

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&sd->lock){..-.}-{3:3} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5942 [inline]
                    lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
                    sensor_hub_raw_event+0x124/0x1340 drivers/hid/hid-sensor-hub.c:550
                    __hid_input_report.constprop.0+0x319/0x470 drivers/hid/hid-core.c:2175
                    hid_ctrl+0x4a4/0x560 drivers/hid/usbhid/hid-core.c:486
                    __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
                    usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
                    dummy_timer+0xdb5/0x3840 drivers/usb/gadget/udc/dummy_hcd.c:2051
                    __run_hrtimer kernel/time/hrtimer.c:2079 [inline]
                    __hrtimer_run_queues+0x448/0x9a0 kernel/time/hrtimer.c:2136
                    hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2153
                    handle_softirqs+0x209/0xa00 kernel/softirq.c:669
                    __do_softirq kernel/softirq.c:703 [inline]
                    invoke_softirq kernel/softirq.c:542 [inline]
                    __irq_exit_rcu+0x17a/0x220 kernel/softirq.c:786
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
                    sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
                    finish_task_switch.isra.0+0x214/0xad0 kernel/sched/core.c:5434
                    context_switch kernel/sched/core.c:5586 [inline]
                    __schedule+0x132d/0x4900 kernel/sched/core.c:7382
                    schedule_idle+0x54/0x80 kernel/sched/core.c:7500
                    do_idle+0x365/0x5b0 kernel/sched/idle.c:384
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:458
                    start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
                    common_startup_64+0x13e/0x158
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5942 [inline]
                   lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
                   sensor_hub_raw_event+0x124/0x1340 drivers/hid/hid-sensor-hub.c:550
                   __hid_input_report.constprop.0+0x319/0x470 drivers/hid/hid-core.c:2175
                   hid_ctrl+0x4a4/0x560 drivers/hid/usbhid/hid-core.c:486
                   __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
                   usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
                   dummy_timer+0xdb5/0x3840 drivers/usb/gadget/udc/dummy_hcd.c:2051
                   __run_hrtimer kernel/time/hrtimer.c:2079 [inline]
                   __hrtimer_run_queues+0x448/0x9a0 kernel/time/hrtimer.c:2136
                   hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2153
                   handle_softirqs+0x209/0xa00 kernel/softirq.c:669
                   __do_softirq kernel/softirq.c:703 [inline]
                   invoke_softirq kernel/softirq.c:542 [inline]
                   __irq_exit_rcu+0x17a/0x220 kernel/softirq.c:786
                   irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
                   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
                   sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
                   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
                   finish_task_switch.isra.0+0x214/0xad0 kernel/sched/core.c:5434
                   context_switch kernel/sched/core.c:5586 [inline]
                   __schedule+0x132d/0x4900 kernel/sched/core.c:7382
                   schedule_idle+0x54/0x80 kernel/sched/core.c:7500
                   do_idle+0x365/0x5b0 kernel/sched/idle.c:384
                   cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:458
                   start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
                   common_startup_64+0x13e/0x158
 }
 ... key      at: [<ffffffff94568d40>] __key.104+0x0/0x40

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&k->k_lock){+.+.}-{3:3} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5942 [inline]
                    lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
                    __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
                    spin_lock include/linux/spinlock.h:347 [inline]
                    add_tail lib/klist.c:104 [inline]
                    klist_add_tail+0x38/0x150 lib/klist.c:138
                    bus_add_driver+0x306/0x620 drivers/base/bus.c:780
                    driver_register+0x1e2/0x360 drivers/base/driver.c:174
                    faux_bus_init+0x6e/0xc0 drivers/base/faux.c:249
                    driver_init+0x33/0x60 drivers/base/init.c:35
                    do_basic_setup init/main.c:1514 [inline]
                    kernel_init_freeable+0x473/0x7b0 init/main.c:1732
                    kernel_init+0x21/0x1e0 init/main.c:1622
                    ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5942 [inline]
                    lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
                    __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
                    spin_lock include/linux/spinlock.h:347 [inline]
                    add_tail lib/klist.c:104 [inline]
                    klist_add_tail+0x38/0x150 lib/klist.c:138
                    bus_add_driver+0x306/0x620 drivers/base/bus.c:780
                    driver_register+0x1e2/0x360 drivers/base/driver.c:174
                    faux_bus_init+0x6e/0xc0 drivers/base/faux.c:249
                    driver_init+0x33/0x60 drivers/base/init.c:35
                    do_basic_setup init/main.c:1514 [inline]
                    kernel_init_freeable+0x473/0x7b0 init/main.c:1732
                    kernel_init+0x21/0x1e0 init/main.c:1622
                    ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5942 [inline]
                   lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
                   __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
                   spin_lock include/linux/spinlock.h:347 [inline]
                   add_tail lib/klist.c:104 [inline]
                   klist_add_tail+0x38/0x150 lib/klist.c:138
                   bus_add_driver+0x306/0x620 drivers/base/bus.c:780
                   driver_register+0x1e2/0x360 drivers/base/driver.c:174
                   faux_bus_init+0x6e/0xc0 drivers/base/faux.c:249
                   driver_init+0x33/0x60 drivers/base/init.c:35
                   do_basic_setup init/main.c:1514 [inline]
                   kernel_init_freeable+0x473/0x7b0 init/main.c:1732
                   kernel_init+0x21/0x1e0 init/main.c:1622
                   ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 }
 ... key      at: [<ffffffff946a2560>] __key.0+0x0/0x40
 ... acquired at:
   check_prevs_add kernel/locking/lockdep.c:3328 [inline]
   validate_chain kernel/locking/lockdep.c:3952 [inline]
   __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
   lock_acquire kernel/locking/lockdep.c:5942 [inline]
   lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
   klist_next+0x86/0x510 lib/klist.c:390
   next_device drivers/base/core.c:4028 [inline]
   device_for_each_child+0xdb/0x1a0 drivers/base/core.c:4106
   sensor_hub_remove+0x7d/0xf0 drivers/hid/hid-sensor-hub.c:824
   hid_device_remove+0xd1/0x200 drivers/hid/hid-core.c:2897
   device_remove+0xcb/0x180 drivers/base/dd.c:617
   __device_release_driver drivers/base/dd.c:1357 [inline]
   device_release_driver_internal+0x441/0x610 drivers/base/dd.c:1380
   bus_remove_device+0x2bc/0x560 drivers/base/bus.c:678
   device_del+0x376/0x9b0 drivers/base/core.c:3967
   hid_remove_device drivers/hid/hid-core.c:3126 [inline]
   hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:3148
   usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1486
   usb_unbind_interface+0x1dd/0x9b0 drivers/usb/core/driver.c:460
   device_remove drivers/base/dd.c:619 [inline]
   device_remove+0x12a/0x180 drivers/base/dd.c:611
   __device_release_driver drivers/base/dd.c:1357 [inline]
   device_release_driver_internal+0x441/0x610 drivers/base/dd.c:1380
   bus_remove_device+0x2bc/0x560 drivers/base/bus.c:678
   device_del+0x376/0x9b0 drivers/base/core.c:3967
   usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1484
   usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2355
   hub_port_connect drivers/usb/core/hub.c:5425 [inline]
   hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
   port_event drivers/usb/core/hub.c:5889 [inline]
   hub_event+0x1d46/0x4510 drivers/usb/core/hub.c:5971
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
   process_scheduled_works kernel/workqueue.c:3578 [inline]
   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
   kthread+0x373/0x450 kernel/kthread.c:436
   ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245


stack backtrace:
CPU: 1 UID: 0 PID: 23 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2660 [inline]
 check_irq_usage+0x87d/0x8b0 kernel/locking/lockdep.c:2901
 check_prev_add+0xfe/0xe60 kernel/locking/lockdep.c:3213
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
 klist_next+0x86/0x510 lib/klist.c:390
 next_device drivers/base/core.c:4028 [inline]
 device_for_each_child+0xdb/0x1a0 drivers/base/core.c:4106
 sensor_hub_remove+0x7d/0xf0 drivers/hid/hid-sensor-hub.c:824
 hid_device_remove+0xd1/0x200 drivers/hid/hid-core.c:2897
 device_remove+0xcb/0x180 drivers/base/dd.c:617
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x441/0x610 drivers/base/dd.c:1380
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:678
 device_del+0x376/0x9b0 drivers/base/core.c:3967
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1486
 usb_unbind_interface+0x1dd/0x9b0 drivers/usb/core/driver.c:460
 device_remove drivers/base/dd.c:619 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:611
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x441/0x610 drivers/base/dd.c:1380
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:678
 device_del+0x376/0x9b0 drivers/base/core.c:3967
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1484
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2355
 hub_port_connect drivers/usb/core/hub.c:5425 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x1d46/0x4510 drivers/usb/core/hub.c:5971
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
 process_scheduled_works kernel/workqueue.c:3578 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
usb 4-1: new high-speed USB device number 3 using dummy_hcd
usb 4-1: New USB device found: idVendor=8086, idProduct=0000, bcdDevice=0.00
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid wMaxPacketSize 0
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hid-sensor-hub 0003:8086:0000.0002: hiddev0,hidraw0: USB HID v1.11 Device [HID 8086:0000] on usb-dummy_hcd.3-1/input0
hid-sensor-hub 0003:8086:0000.0002: No report with id 0xffffffff found
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: failed to setup common attributes
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: probe with driver hid_sensor_accel_3d failed with error -22
usb 4-1: new high-speed USB device number 4 using dummy_hcd
usb 4-1: New USB device found: idVendor=8086, idProduct=0000, bcdDevice=0.00
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid wMaxPacketSize 0
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hid-sensor-hub 0003:8086:0000.0003: hiddev0,hidraw0: USB HID v1.11 Device [HID 8086:0000] on usb-dummy_hcd.3-1/input0
hid-sensor-hub 0003:8086:0000.0003: No report with id 0xffffffff found
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: failed to setup common attributes
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: probe with driver hid_sensor_accel_3d failed with error -22
usb 4-1: USB disconnect, device number 4
usb 4-1: new high-speed USB device number 6 using dummy_hcd
usb 4-1: New USB device found: idVendor=8086, idProduct=0000, bcdDevice=0.00
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid wMaxPacketSize 0
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hid-sensor-hub 0003:8086:0000.0005: hiddev0,hidraw0: USB HID v1.11 Device [HID 8086:0000] on usb-dummy_hcd.3-1/input0
hid-sensor-hub 0003:8086:0000.0005: No report with id 0xffffffff found
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: failed to setup common attributes
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: probe with driver hid_sensor_accel_3d failed with error -22
usb 4-1: USB disconnect, device number 6
usb 4-1: new high-speed USB device number 7 using dummy_hcd
usb 4-1: New USB device found: idVendor=8086, idProduct=0000, bcdDevice=0.00
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 4-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid wMaxPacketSize 0
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hid-sensor-hub 0003:8086:0000.0006: hiddev0,hidraw0: USB HID v1.11 Device [HID 8086:0000] on usb-dummy_hcd.3-1/input0
hid-sensor-hub 0003:8086:0000.0006: No report with id 0xffffffff found
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: failed to setup common attributes
hid_sensor_accel_3d HID-SENSOR-200073.1.auto: probe with driver hid_sensor_accel_3d failed with error -22


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
