Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79230E828
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609818; cv=none; b=ljMK9buBsU+qm3qOrxiXcQ3se5QiKVLljzgM8MIfGWb0JJ3JqiTmaFl0qd24cS5bkZpdsELR1R2H+Hv3975GGRx59NJbTNbJRgUH96wAUAdru8iFY+m2/t9ivuTcgXVq8/5eHQpJeONfyk1PiGr3Zh9MBrlm0t8NrfYfvImWc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609818; c=relaxed/simple;
	bh=IkbUQHAOfDRR8QJYVT76UHWjqqy2lR1E9xb+ik1LNpE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VwMqWp5E8gifKGcw4vKiLV9f28v8ZMIXkmy77DzeB40eRYwrnPjI0cVi/+G/G8Nc4Pv5UAZ1AeNe1sJC7NvcR4RSP7U05Pig1zbw+lcmLD+bd3GbVRRehjgUdGSWMQPjuKt5WLMxQJ7MtpIAtxVEqq+Fel40fgCGZlx3yAP44N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-45e6091d8a1so493371fac.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 22:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791609816; x=1792214616;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58B19+DhFBJ1hf8T5c/LPfinHQSqyHwbp0uTFqZKVB4=;
        b=rzVxQyWygAfzW/GzaM3DY8eMWeaytLhyyMx0XMQfQKuIDRoxZrEesZ4b8YYbwslpB3
         VmhqtLRLCQye+xcuQpHqfRmQtlm+3V0ORMmX5spK/IJRixbY4onMBjBIQsrCVOX1QUSF
         SSFL/nPzQnqCrUXA3dDBDaDOfUs+g9S6TLaJi0P7XrvyAup2wp0tmJ2sq22iA1fTnQpl
         Br+wix6JNR8wZxyxHSj0Z2quE026Rt1P6sakW59kylgjShBCPdzFm5K3RBlzoC3mTG0b
         5N0ZrnnclBCnt6W6pwtzjN1vvI0S90H1r7ri2anIwvO5uJJyhwu4jo+8rR2WVurm2jlY
         dSXw==
X-Gm-Message-State: AFq9FYIRjYmC6DUvgPKs7r2Php/yxS3CCW9cLGwweSPs9VkDCulMO7e0
	Xu8vAjtV5qR+FI9pETDePHrhpbFyMUwyNRMHalnqpmdzd6NhieJw3yo0SUeMX+wa7w6Aj9tyDnN
	6TRzLunFcYItyj0FeLks4lUkBVu9rQszwoTICLao4PVy+LcgbEQs82ShnQbA=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30aa:b0:4ab:318c:6b38 with SMTP id
 5614622812f47-50c435bb696mr3674298b6e.1.1791609816125; Fri, 09 Oct 2026
 22:23:36 -0700 (PDT)
Date: Fri, 09 Oct 2026 22:23:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac9cbd8.a150a118.27e199.0025.GAE@google.com>
Subject: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (3)
From: syzbot <syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5926a7da8789 Merge 7.3-rc6 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11fc7ff5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f0127eb11110629
dashboard link: https://syzkaller.appspot.com/bug?extid=25a1d2907885b2182275
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124fc715580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174ed835580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0667b4f9388e/disk-5926a7da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a1f8551bcab/vmlinux-5926a7da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/03e51d6db4ed/bzImage-5926a7da.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com

usb 4-1: config 0 interface 0 has no altsetting 0
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:80:21
shift exponent 32 is too large for 32-bit type 'int'
CPU: 1 UID: 0 PID: 780 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 s32ton.part.0.cold+0x1b/0x26 drivers/hid/hid-core.c:80
 s32ton drivers/hid/hid-core.c:71 [inline]
 hid_output_field drivers/hid/hid-core.c:1871 [inline]
 hid_output_report+0x3c2/0x500 drivers/hid/hid-core.c:1904
 __usbhid_submit_report+0x33f/0xeb0 drivers/hid/usbhid/hid-core.c:595
 usbhid_submit_report drivers/hid/usbhid/hid-core.c:640 [inline]
 usbhid_request+0x7d/0xf0 drivers/hid/usbhid/hid-core.c:1303
 hid_hw_request+0x75/0xc0 drivers/hid/hid-core.c:2531
 dr_input_configured+0x62c/0x770 drivers/hid/hid-dr.c:124
 hidinput_connect+0xf59/0x2ca0 drivers/hid/hid-input.c:2414
 hid_connect+0x1330/0x1790 drivers/hid/hid-core.c:2323
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2436
 __hid_device_probe drivers/hid/hid-core.c:2843 [inline]
 hid_device_probe+0x703/0x850 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:3065
 usbhid_probe+0xa64/0x10b0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 usb_set_configuration+0xd97/0x1dc0 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2713
 usb_new_device drivers/usb/core/hub.c:5838 [inline]
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5971
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---


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
