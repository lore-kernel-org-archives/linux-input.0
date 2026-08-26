Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B3283FD9
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787782954; cv=none; b=Nh+7ijQGE4s0XaoTiqirUPK/6Pn8wdYdVyV1UzAtWn0jUmt4jz6DexDlL2HTL06xYpVkxPnsYVKYlCrfAvYsT79FvvhA4NDM20bYBblXguPCZVYqTPkU68Xerhwki5dbcR5QKHBF9HOUTTQMOJUd42dwmgYN3cJvZjoUDUfYxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787782954; c=relaxed/simple;
	bh=krTUWyTjFfNUvNAas2FH261nlZ1YuUcBeN6XdjGxIhM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FL766jgcJ9ZarJrxhGfuecf147djYQuVWxqoOqg44IbTH+NMx/ZxrIpZAAwKMCwVSkl2xnHRB6CLnUOPpRzumsEnXUpcCrfVNaG4Xkd+nc7BIGyh0dfTXFPPFn2frUVb2nqpAfPrO+nMOqBPAZQA2a0LfTWzo3riWnUlOlMsMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e8472960so873857fac.1
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 15:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787782951; x=1788387751;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y3Eieam+i47nsBCoX/y9GEyUNYggaF/JmMEBhjWIWLs=;
        b=MDbXdgzWmlwLmU2k7KoSAlvZEJVdUh+PMNoZbzk/3fIDF3BN3bETtthi32cW6c9uMr
         ImcXoEDbIXC2pt5oRdrp/RKA8iAquypb7x6YS9alw5qcdqoiH2GRDdkA28BQy7PvzP3a
         XFmH/RauxEaHqbehANjvB0oPU4DmrP+UUJJcYmgQAxbLxwJT5vvI4/Rn7Sa6caVR/vzm
         uhKl6lzW7HcKcV/+fAXo0pdJoySGD8VQGIZezp7PU4kLAInAuGLyN4QEKw/UKnGzYRQp
         kJkK31CYwhUNiUZl48115yhPffHGR/TGZdYQ7O3mj5pOOMhuZTTmjB52bSzTP1ilw/w7
         K7Tw==
X-Forwarded-Encrypted: i=1; AHgh+RrBB+XlH5t2iyAeZoD2tRGL+7qrr/6eKRi+/af6JBsW5tOcAMbVIQ3Cq2R1gm56A8xxht0GvBhvisfivQ==@vger.kernel.org
X-Gm-Message-State: AFuF++msWdZYzNAu+dq5RRMQ8qZwTck3QRQzdTlL9fed4mWb/VcXimoA
	HT4V2tnY2OqoSIoQcPhkNHqbY3+FHBt5iIijKcvoMyWZxVj1zyEisUQyPxDqGtzdotJZAzQj9eC
	KVWRrTYpv0Q0rGSYSVkuFMfHxBC/abXOuxTaQEJxio4gFV5UteBcy27tZ16s=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3407:20b0:6b1:9944:552b with SMTP id
 006d021491bc7-6b1a047f077mr7824802eaf.19.1787782951350; Wed, 26 Aug 2026
 15:22:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 15:22:31 -0700
In-Reply-To: <6a802643.9ebadd4d.20b15e.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8f6727.50659fcc.60cd.0008.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING: ODEBUG bug in corsair_remove
From: syzbot <syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com>
To: bentiss@kernel.org, ccc194101@163.com, chenchangcheng@kylinos.cn, 
	jeffinphilip14@gmail.com, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    45c13f3f9e3b Merge tag 'hwlock-v7.3' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=120b399e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b0fc292fc5639c
dashboard link: https://syzkaller.appspot.com/bug?extid=0a031a76585d1c7e737d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170de979580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12479625580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac6556827073/disk-45c13f3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01ff014f18d2/vmlinux-45c13f3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77e9c6302a14/bzImage-45c13f3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com

usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??
corsair 0003:1B1C:1B02.0001: hidraw0: USB HID v0.00 Device [HID 1b1c:1b02] on usb-dummy_hcd.3-1/input0
corsair 0003:1B1C:1B02.0001: Failed to get K90 initial state (error -71).
usb 4-1: USB disconnect, device number 2
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888122562ac8 object type: work_struct hint: k90_record_led_work+0x0/0x1f0 drivers/hid/hid-corsair.c:710
WARNING: lib/debugobjects.c:629 at debug_print_object+0x198/0x2b0 lib/debugobjects.c:629, CPU#1: kworker/1:0/24
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a5/0x2b0 lib/debugobjects.c:629
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4f 48 8d 3d d8 94 38 08 41 56 48 8b 14 ed 40 aa d2 87 4c 89 e6 <67> 48 0f b9 3a 58 83 05 f2 ef 33 08 01 48 83 c4 18 5b 5d 41 5c 41
RSP: 0018:ffffc9000019f1e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc9000019f2d0 RCX: 0000000000000000
RDX: ffffffff87d2a980 RSI: ffffffff87d2a520 RDI: ffffffff8b1a2d60
RBP: 0000000000000003 R08: ffff888122562ac8 R09: ffffffff87a8ade0
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff87d2a520
R13: ffffffff87a8ae20 R14: ffffffff85fa07c0 R15: ffffc9000019f2e8
FS:  0000000000000000(0000) GS:ffff8882684eb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e4079ef1d0 CR3: 0000000116d44000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
 debug_check_no_obj_freed+0x4da/0x630 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2679 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x3b2/0x650 mm/slub.c:6792
 k90_cleanup_macro_functions drivers/hid/hid-corsair.c:547 [inline]
 corsair_remove+0xfa/0x2f0 drivers/hid/hid-corsair.c:602
 hid_device_remove+0xd1/0x200 drivers/hid/hid-core.c:2897
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:610
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1478
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1d46/0x4510 drivers/usb/core/hub.c:5966
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	b8 00 00 00 00       	mov    $0x0,%eax
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	lcall  (bad)
   8:	df 48 89             	fisttps -0x77(%rax)
   b:	fa                   	cli
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	75 4f                	jne    0x65
  16:	48 8d 3d d8 94 38 08 	lea    0x83894d8(%rip),%rdi        # 0x83894f5
  1d:	41 56                	push   %r14
  1f:	48 8b 14 ed 40 aa d2 	mov    -0x782d55c0(,%rbp,8),%rdx
  26:	87
  27:	4c 89 e6             	mov    %r12,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	58                   	pop    %rax
  30:	83 05 f2 ef 33 08 01 	addl   $0x1,0x833eff2(%rip)        # 0x833f029
  37:	48 83 c4 18          	add    $0x18,%rsp
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	41 5c                	pop    %r12
  3f:	41                   	rex.B


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
