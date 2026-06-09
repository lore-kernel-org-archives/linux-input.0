Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B913DA7E4
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994136; cv=none; b=iHONbV5+9xeJ4wd3rg429FxkLIp0MfVzg6cIXtN8IDfU54yzMZVO8XGlQ9mwA3ZbtNAPpgv/bsu/7CW2uwwARUMV7UtVB6bGjoBZy6q8zixB94QnBigORfuqRL1+u0EjCq0S6Re1Fqw6me8mnWeTTQhm8lRR4mYUc40AI7hlkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994136; c=relaxed/simple;
	bh=+P9np9Vka2QTiz07ylMGTts8gjD5wS+NjaH1YvfbKcs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=flJ/0sfQw/9Hb9DzZ31BaoFo18giIKaQNscn0xl9D7Jrikf85046H/D/VgiG23tcPHe5QzOOb1RIaU9uNMSQd7GNd2qPfiXSMa5DG7rTs9Ch4+FkyXUGxHFI7gVNdqv8IiiH6HSz7Evlkjhv+aBLMf+9RGz42I6AqdTmXxsSflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e74781faaaso2315022a34.2
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994134; x=1781598934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VdIF8pTA7WFCZP9AlK4xwxv3lQF76PPRLqZ1KRVk1g=;
        b=TrnkuJfm+6HtIAddWhpe5MXPcX0CXtnCnjg/rbpsVCpqdd4CEQrextQC9mQWSKJBik
         R5d7opp/VjpgBDSiAfnmrWUe33Y5nneSuMgHj7ylPvGm36BOW0RzRT2fa5Trn1lKVvPk
         rvzQ2hkpM4KiudlVen4x3YZ9IfoE0IF1F1u2H9ZuUdiFvK0QXn6W2ZrXMM0wQIAWKPq3
         gJsxaSIUwx3T8S5QLUFkgRsJfILLSzCs6YZimoSgPaQmmus8gGrmgg9UwRmocx3+nRol
         bHgeSqAJ04X2xnC6rI3q4uikWDn5Ox/Vbtok73kTrAdB/UM0h5OEQIn/n5yy+8ArRly2
         69lA==
X-Gm-Message-State: AOJu0YwgSITS9MAR1lQzqIpZ56cVwS7/qo033cIHCPmH2pEwc9NTOKt5
	ofCkYnRGpb/og/m5LDvkmOS1DojAHx+qGU0bBwIeHPY+M6ihvK4XL+tudWbDzoN3AKSjIchb7ae
	IG2/AZw7uYF35KGpkn60LSS62HD1RYtbOA+vVd29Oir7hEHTqtRgxCJBzsxpkKQ==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1999:b0:69e:3c64:7f6f with SMTP id
 006d021491bc7-69e68c58c2bmr9469034eaf.48.1780994133929; Tue, 09 Jun 2026
 01:35:33 -0700 (PDT)
Date: Tue, 09 Jun 2026 01:35:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a27d055.39669fcc.33b062.008d.GAE@google.com>
Subject: [syzbot] [usb?] [input?] KMSAN: uninit-value in steam_register
From: syzbot <syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e65320d91cd Merge tag 'drm-fixes-2026-06-06' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cb9e7a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0ca3b8cb3875012
dashboard link: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/793bd3b9425c/disk-8e65320d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bfe5cfc266c/vmlinux-8e65320d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99c7cd705a06/bzImage-8e65320d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com

hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
hid-steam 0003:28DE:1102.0007: : USB HID v7f.fd Device [HID 28de:1102] on usb-dummy_hcd.1-1/input0
=====================================================
BUG: KMSAN: uninit-value in steam_get_serial drivers/hid/hid-steam.c:457 [inline]
BUG: KMSAN: uninit-value in steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
 steam_get_serial drivers/hid/hid-steam.c:457 [inline]
 steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
 steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
 __hid_device_probe drivers/hid/hid-core.c:2822 [inline]
 hid_device_probe+0x60d/0xb90 drivers/hid/hid-core.c:2859
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d5/0xe40 drivers/base/dd.c:709
 __driver_probe_device+0x2fb/0x410 drivers/base/dd.c:871
 driver_probe_device+0x70/0x8f0 drivers/base/dd.c:901
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:1029
 bus_for_each_drv+0x3e3/0x680 drivers/base/bus.c:500
 __device_attach+0x3c5/0x5f0 drivers/base/dd.c:1101
 device_initial_probe+0x126/0x170 drivers/base/dd.c:1156
 bus_probe_device+0x287/0x530 drivers/base/bus.c:613
 device_add+0x12e3/0x1c90 drivers/base/core.c:3706
 hid_add_device+0x440/0x5d0 drivers/hid/hid-core.c:3003
 usbhid_probe+0x1a25/0x20e0 drivers/hid/usbhid/hid-core.c:1449
 usb_probe_interface+0xd51/0x1440 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d5/0xe40 drivers/base/dd.c:709
 __driver_probe_device+0x2fb/0x410 drivers/base/dd.c:871
 driver_probe_device+0x70/0x8f0 drivers/base/dd.c:901
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:1029
 bus_for_each_drv+0x3e3/0x680 drivers/base/bus.c:500
 __device_attach+0x3c5/0x5f0 drivers/base/dd.c:1101
 device_initial_probe+0x126/0x170 drivers/base/dd.c:1156
 bus_probe_device+0x287/0x530 drivers/base/bus.c:613
 device_add+0x12e3/0x1c90 drivers/base/core.c:3706
 usb_set_configuration+0x3484/0x3b60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xfc/0x290 drivers/usb/core/generic.c:250
 usb_probe_device+0x38d/0x690 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d5/0xe40 drivers/base/dd.c:709
 __driver_probe_device+0x2fb/0x410 drivers/base/dd.c:871
 driver_probe_device+0x70/0x8f0 drivers/base/dd.c:901
 __device_attach_driver+0x4ee/0x950 drivers/base/dd.c:1029
 bus_for_each_drv+0x3e3/0x680 drivers/base/bus.c:500
 __device_attach+0x3c5/0x5f0 drivers/base/dd.c:1101
 device_initial_probe+0x126/0x170 drivers/base/dd.c:1156
 bus_probe_device+0x287/0x530 drivers/base/bus.c:613
 device_add+0x12e3/0x1c90 drivers/base/core.c:3706
 usb_new_device+0x106a/0x2120 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x5404/0x77c0 drivers/usb/core/hub.c:5953
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb65/0x1e40 kernel/workqueue.c:3397
 worker_thread+0xee4/0x1590 kernel/workqueue.c:3478
 kthread+0x53a/0x5f0 kernel/kthread.c:436
 ret_from_fork+0x20f/0x8d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable reply.i created at:
 steam_get_serial drivers/hid/hid-steam.c:448 [inline]
 steam_register+0x180/0x10e0 drivers/hid/hid-steam.c:965
 steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273

CPU: 0 UID: 0 PID: 7403 Comm: kworker/0:6 Tainted: G             L      syzkaller #0 PREEMPT(lazy) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: usb_hub_wq hub_event
=====================================================


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
