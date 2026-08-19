Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0803A1D14
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122238; cv=none; b=UDgpaILxO9XW2cQdH4pwhE15/+vAtO3gXm+tE9iFH6ZB0h0UmW6TZh+VTuUPwedIXxOCsxkSWQ7Ai0y/h3/JJNxQ2pe0JVIsJu6djpc/K1SKQ8gsn7KpYv/i5LTVRHTLAqrOGFgd5RQ2LxckTG0e2QzAuCovcUJ0eWoa8NIZDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122238; c=relaxed/simple;
	bh=q6ygtxCrhJfC9aYFm8ppas5s7/qfe+GU0wHw8fU0VHU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LBU2LWAPOoSlyaiz9uF99hHnyWkNJFitccmlpd76f9EpOWhbulBO8ywxvIy0iXLOPmdakbb8N14yNw/EoyUGEWE1+vSdWvp8TaELp1TxnDM19Zwape4PeiJEOS6T+Ng2YkpqyOPZNzRTThc9FBZy4b9bQdCC/BOcDf75FzgGHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so244710b6e.0
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 23:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122235; x=1787727035;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wxu/FpO8lAQ4l4YakyHtTDOfDut5q1C3byR/UEFIKPc=;
        b=Op31ZwnVCSP6t4tE2KvATl6zKQBSr04raAYieYcEhKUt0Y2UTO6y9DFvqyjCMDTcHB
         rH0aGJYvYQdl3nh/ko+4RrF1biKNGQM/BA1UdYsdO9XYBBBAMI4qbBXdLXm9NqR+qgFT
         /frKa0hsdu1wrXdV1paPU47pIAoBrmO92i9owgEqiCpHQydY6ekEkpZL5V2hYbxqPBdq
         k6CccrE836DG3kPt+cm7VSzGKqkWrbPj1DGFfda8KGWYfeekYExMrxZfllzjX9pddV+J
         6hqFkyRmspHvStjm274SywFyg+N25wDV/Ux+/QKhsNtrG8n16eg+/3M1NvmfXR+4GtCq
         hPRA==
X-Gm-Message-State: AOJu0YyVLdkMxX+6aXj//+ECXQFrG1kk8dpDFVaGUoBIFn3gD+6aU7qD
	zyahrcX0g8Iwk3gVoP1orScU4o7X2rGBV+4u038uh2kGJLWsdMHhMdXuM6/VXYbRWDtyGQYrYPg
	efQPOi8EsHU3D5n8ffh/4WG5TGNmcwkoNBYc6d0AOsYI8n21kLMnbzgoZUpcmMg==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b8f:b0:4b1:9f12:e2f6 with SMTP id
 5614622812f47-4b2bcbdd19emr2057934b6e.19.1787122235427; Tue, 18 Aug 2026
 23:50:35 -0700 (PDT)
Date: Tue, 18 Aug 2026 23:50:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a85523b.ae6ddae5.3da009.0008.GAE@google.com>
Subject: [syzbot] [input?] [usb?] memory leak in __usbhid_submit_report (2)
From: syzbot <syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2ca25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11ad91fcc8fa7933
dashboard link: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c6a949580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f43279580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bba3e686406/disk-2f1baf1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8b74261d93c/vmlinux-2f1baf1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/952847c3fd89/bzImage-2f1baf1f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881279df600 (size 16):
  comm "syz.5.22", pid 6103, jiffies 4294942311
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __do_kmalloc_node mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5359
    __usbhid_submit_report+0x362/0x4c0 drivers/hid/usbhid/hid-core.c:541
    usbhid_submit_report drivers/hid/usbhid/hid-core.c:640 [inline]
    usbhid_request+0x5b/0xa0 drivers/hid/usbhid/hid-core.c:1303
    hid_hw_request+0x3c/0x70 drivers/hid/hid-core.c:2521
    hiddev_ioctl+0x33e/0x9d0 drivers/hid/usbhid/hiddev.c:726
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
