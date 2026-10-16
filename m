Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2B42AD7C
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175002; cv=none; b=EYWBYMYyvd/zr+q7PO1mivF/Tsj9g4duifP80kCr/p1aaA9/5cJz6PkVkGcQRpP/zMq8FY+yWG3p3NJ2Di/63v6pdedvKCcKIDqcY2SU8g7PrkOkGf6jTWto9wi2H9oSsUjcUZCraieniO1cP1WP7eCNmkYCcA7DCo5RPyvuAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175002; c=relaxed/simple;
	bh=gETURQQ+Xa8MgCP1He3CpMIe9f2O4aU074sVjeVEiAM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JiUqEgykmMqw4qwYxt/NhlyvtGDDU6EGukqOUYFI4eMuGWqDTQGBwz9YAN7YP814v8jKqz8/9Ah7BTTRvwQ+RGOQMOsnLrnu3bKyXALQRg/0oklX9aN85dl3sYnBFAoaqHvaeOovLEk0yl7S3XfuJKfK/oF2Z+hn3Cu0SM+EVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-47d81384b4bso363103fac.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175000; x=1792779800;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXUlZPp0nSM1FDqQDGQMJiVLPwQpzHfTyLK9N1GyqQE=;
        b=yotOX7/xPO9DeAKCMMsfQ1bWf8H2N/sPEszOC0b9SGLl6bDxN228rYwUoXIsW0Wyi2
         Ev7NFWZmZS6yWSRH2eFLOI2d6976ORByCLuAHuM/o7qLgoTZEyx1/Y1fdNK6BGyMrLcM
         SQ6oi8IPhXuLJX1PUNcN+70FnaufPyM6Y45P6WhPn24SXNjfrZGgMMh3wEs0aiaKEaCW
         kwyWyadfm6rxE6yEOqZHKyf81HFBKUZf7rbEyatt0woSfc2QpiC2w4B5c0jJnNvRu9Hf
         VrwvFjHYxcP9St/7Xh5wADZK/zoVRMURpwjK94twH9EdGViUJtIDJ19IagyUiPyskM1G
         Z8dg==
X-Gm-Message-State: AFq9FYInHbqCRXWZ7QZwK8pQtbHhX3JRE3hMWIpaKP1PECDiDGIdrBgZ
	++MMg+MVW+N3TDIVdoTUYafCeFcy85uUemIWzVlaWAL44FPIday7g67fkgeVA69B1qFlRqpKYjE
	OIy3wNhMgHhwfHcSLFD+sxonOmcYw1l3Dj3+GVHIFeJDlxj31rqlpA3LxbD8=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3a19:b0:4f5:4780:582 with SMTP id
 5614622812f47-53cd33186cbmr355454b6e.50.1792174999824; Fri, 16 Oct 2026
 11:23:19 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:23:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad26b97.7952420f.283480.034d.GAE@google.com>
Subject: [syzbot] [input?] general protection fault in input_ff_flush
From: syzbot <syzbot+788733b16e87faa63deb@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f2f7eeef8b0 Merge tag 'soc-fixes-7.3-3' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=166b2d71580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=788733b16e87faa63deb
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c9f67f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+788733b16e87faa63deb@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.172' (ED25519) to the list of known hosts.
[*] Reproducer for general protection fault in input_ff_flush
[+] opendir /sys/class/udc successful.
[+] closedir /sys/class/udc successful.
[+] Using UDC device: dummy_udc.2
[+] open /dev/raw-gadget successful (fd=3).
[+] USB_RAW_IOCTL_INIT successful.
[+] pthread_create ep0_loop successful.
[+] pthread_create ep_io_loop successful.
[+] USB_RAW_IOCTL_RUN successful.
[*] Waiting for Logitech G920 to enumerate and bind...
[+] Found Logitech G920 device: 0003:046D:C262.0001
[*] Starting deterministic fault injection rebind loop (1..100)...
[+] fail_n=1: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event4, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event4.
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[+] fail_n=6: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event4, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event4.
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[+] fail_n=7: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event4, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event4.
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[*] Tested fail_n=10
[+] fail_n=11: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event4, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event4.
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[+] fail_n=15: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event4, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event4.
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[*] Tested fail_n=20
[+] fail_n=30: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event4, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event4.
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[+] fail_n=34: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.
[+] fail_n=37: bind succeeded, scanning /dev/input to trigger bug...
[*] Opened /dev/input/event3, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event3.
[*] Opened /dev/input/event2, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event2.
[*] Opened /dev/input/event1, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event1.
[*] Opened /dev/input/event0, closing now (should crash if ff teardown leaked flush)...
[*] Closed /dev/input/event0.


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
