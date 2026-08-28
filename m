Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD73DDAE6
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930069; cv=none; b=YueqPmBRsQHsSvpft508Ez6GWg9FMp1aLzb8Jmsu0Xf7Y1OpFvi+HHvpbv+zpoVNlpTphlU0VBvPTuQ4a/9qDarci1bkJzXVVLRySC25XJSUw1z6si7ROzVwVAajx4bPdgdDnFsiNmWDktsRK8/EWsfgFTlqFytcniqzueTMU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930069; c=relaxed/simple;
	bh=bxkizeat5GUcIP4sFJ+GCIBzsET33wm+HcTeHEwKYLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dA/eiRS4g4tDIofp0QYzdJJeu5oupQ/VjBiLM8izQddBngo7yTm6cXa2Q5TToFtwkWJNhsT7ne1S2sKkwvKsr6qtNIKlAQB7shzr6XRiA4cu8R0FdHO851hynCGqiDtbu4vk37x/PWHqGVEPBy/fkI6CFqHFtL3cFDmC4GfoaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ab260600easo3781926b6e.1
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 08:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930066; x=1788534866;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F35JUbY5RodIRW30ZhUW7omH8qQRFCxSw/t423wJwO0=;
        b=OAwiGe+Nbc/FWHA8c9l1MCFLt3Is6Nr3AuXKxZHtiW5pG9P0Ca2Kw525m4JGdzqj5Q
         9xNzJCiyIHGENSkw8iQKalL9/q6prntk3BSyDe2uYl3RkK8Q6rxLhYOSBy1dcP5Ekmfp
         1VlYoIE3cvRovKcCiFGOL/AeOSBMu8vRWxEzWgw71bwJppLqPfmgkppybTMyZ5lcnFjd
         /wsoImR+yDgbthch/709HzKYcA+2p4HodFwqUXFfAbno4p0ikyRPkUmwaCJBa4cJT3Mh
         bg/CZ7M6Vz7G+m6uxEPlaN191BY0DNBR6wNXP8iRP0CDvsPcC2Enmg04VGulrRSVgV7F
         65Jg==
X-Gm-Message-State: AFuF++k59h20bHnuQbrshwgsi3BroiY3MakmTMQ306E85c0F5fXWWL4J
	7cyKYO9FjIDWZMhhIWv38ZuWzwvB5l+b1YRTGC4mA5H80wL9zNWMbhRlkH+iPzblVLJlkqgWMXc
	dwWZp4sBBNZ9OSycFTK6CTMhmWjxCyGYFTRoDdBbzAvnWk5rNRXb7Bl/VrqKn0A==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c173:b0:492:c9a4:2104 with SMTP id
 5614622812f47-4b37c999474mr12651871b6e.10.1787930066527; Fri, 28 Aug 2026
 08:14:26 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a91a5d2.4d659fcc.734b4.0021.GAE@google.com>
Subject: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in k90_backlight_work
From: syzbot <syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    73e3f0710014 Merge tag 'nfs-for-7.3-1' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a76579580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9efed59cf70d6280
dashboard link: https://syzkaller.appspot.com/bug?extid=abcedffc9201f2bb66c2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef9dc2fd7978/disk-73e3f071.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1de9c5b90e55/vmlinux-73e3f071.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79167e663675/bzImage-73e3f071.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in k90_backlight_work+0x174/0x1c0 drivers/hid/hid-corsair.c:209
Read of size 1 at addr ffff888026a23b00 by task kworker/1:3/5600

CPU: 1 UID: 0 PID: 5600 Comm: kworker/1:3 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events k90_backlight_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 k90_backlight_work+0x174/0x1c0 drivers/hid/hid-corsair.c:209
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 11427:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 k90_init_backlight drivers/hid/hid-corsair.c:430 [inline]
 corsair_probe+0x627/0xbc0 drivers/hid/hid-corsair.c:589
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x46a/0x870 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3065
 usbhid_probe+0x9dc/0xde0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x99a/0x1680 drivers/usb/core/hub.c:2708
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x28cf/0x4cf0 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 11427:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6792
 hid_device_remove+0xc8/0x1d0 drivers/hid/hid-core.c:2897


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
