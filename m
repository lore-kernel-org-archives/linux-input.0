Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9311476061
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625547; cv=none; b=rMQtuy+8JXgAqd8S1glYkPO917k6iZv8azqDIX4GsOkhu8WHQ/r6dVeafQbgs5hXnpj97jxT19rrrKOWzN0HLr1gmKuzEuTFhEGoUgqN8s0Ayk/HRY+/4f0Xtu7tjiXxwjwrt8tQQ6/71jit9jliIrJ80VJ5qaUTTgcDaCIVmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625547; c=relaxed/simple;
	bh=JX50RXTBrA5Y05E7l76IE7oCZGZvxBakMAQNdcm0yk4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g3CF6YfZFU4pOLsWRRePawAWlB48j0tCNkLLbj5DOKCObsdCrzGyW50Z9e8HyLwBbEdwhtwJZijdm8IIY2sqFFRCeA77aFmL8t9JWDADYqHmY1Y9A/MtgxcfZY+VCwf1BFee/9M7/ZReHtM3KalVTML6ZhbysFe6FYkHGy5I8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-45952ce9ee0so851000fac.1
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 05:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625545; x=1787230345;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6k0TYruOcUa+BZt8cfgVYPKEbF3/lmBzdZC02TGCOk=;
        b=PRXDLc2XhbcYW+WyWFz/iCtjPnQJjWaSYvLkGVJWrLjtAtIVC7v1zBSn12T43vRxJ7
         nZQuA3WghHTzPdbVadYJYU0epML68TIHiN9KyKENDDMP1Jd85m7/1kSPGZhFvhxLV7jU
         dpEpMa9jnQBdtujeYDkASRFBTjQqQbABYJGbJ9CGld7CdBjqpYy6zVjo6bVhI8diDQtj
         z0rwkBZhV5j00co36bEWmWC6yVplmj5Aiz39YdZ9PvsgpeSWOCzTq8pF0tgVpSEgOM2n
         t2u/hLZwONhd9/9ynzQoS1JSNda6+vAiYrl7njb/3ZRZrG34FyeR6oa7LpMbOdpqAOfI
         z4fQ==
X-Gm-Message-State: AOJu0Yx1GuBXLEN/LYhRcFu8HoEbFf4q90TdlgAjFYH23B876w3LFx8K
	9oWc/TNg2qhp00qc4R28frneFqKKtL5iZpDpKTHcJGH0zRNEoC85CYDDAaYkJaHr2KdKRNjX+uW
	hUnVq7IeqTUgWHjr4Y57yZ0DTDzsJIU5ghsH2lEG7nyH3qMF9lghQrCYdPGk=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:807:b0:6b0:4c0b:4846 with SMTP id
 006d021491bc7-6b0c42191d2mr4377668eaf.10.1786625544656; Thu, 13 Aug 2026
 05:52:24 -0700 (PDT)
Date: Thu, 13 Aug 2026 05:52:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7dbe08.ec5dc6cc.21cb3f.00b6.GAE@google.com>
Subject: [syzbot] [input?] BUG: unable to handle kernel paging request in amd_mp2_pci_probe
From: syzbot <syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140d5149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=4eadd4dfe9e66522bae8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e1b225580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com

Console: switching to colour dummy device 80x25
BUG: unable to handle page fault for address: ffffc9000386468c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1bc00067 P4D 1bc00067 PUD 1d293067 PMD 26b0e067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6020 Comm: syz-executor364 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:mp2_select_ops drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:282 [inline]
RIP: 0010:amd_mp2_pci_probe+0x43d/0x820 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:487
Code: f9 e9 c7 02 00 00 e8 52 46 f8 f8 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 72 03 00 00 48 8b 45 10 <8b> 98 8c 06 01 00 48 8d bd a0 00 00 00 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000354f810 EFLAGS: 00010246
RAX: ffffc90003854000 RBX: 0000000000000000 RCX: ffffffff89122b85
RDX: 1ffff110025a5009 RSI: ffffffff89122d2e RDI: ffff888034c9a540
RBP: ffff888012d28038 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888022e82000
R13: ffff888022e820d0 R14: ffffffff8c438280 R15: ffff888012d28048
FS:  0000555584ff9400(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000386468c CR3: 0000000027179000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 bus_rescan_devices_helper+0xfb/0x220 drivers/base/bus.c:854
 drivers_probe_store+0x4a/0x90 drivers/base/bus.c:318
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd76cf69e77
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffdac17fdf0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000555584ff9400 RCX: 00007fd76cf69e77
RDX: 000000000000000d RSI: 00007ffdac17fe9c RDI: 0000000000000003
RBP: 000000000000000d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffdac17fea9
R13: 00007ffdac17fe9c R14: 00007ffdac17fe70 R15: 00007fd76cfa507a
 </TASK>
Modules linked in:
CR2: ffffc9000386468c
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:mp2_select_ops drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:282 [inline]
RIP: 0010:amd_mp2_pci_probe+0x43d/0x820 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:487
Code: f9 e9 c7 02 00 00 e8 52 46 f8 f8 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 72 03 00 00 48 8b 45 10 <8b> 98 8c 06 01 00 48 8d bd a0 00 00 00 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000354f810 EFLAGS: 00010246
RAX: ffffc90003854000 RBX: 0000000000000000 RCX: ffffffff89122b85
RDX: 1ffff110025a5009 RSI: ffffffff89122d2e RDI: ffff888034c9a540
RBP: ffff888012d28038 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888022e82000
R13: ffff888022e820d0 R14: ffffffff8c438280 R15: ffff888012d28048
FS:  0000555584ff9400(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000386468c CR3: 0000000027179000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	f9                   	stc
   1:	e9 c7 02 00 00       	jmp    0x2cd
   6:	e8 52 46 f8 f8       	call   0xf8f8465d
   b:	4c 89 fa             	mov    %r15,%rdx
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 c1 ea 03          	shr    $0x3,%rdx
  1c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  20:	0f 85 72 03 00 00    	jne    0x398
  26:	48 8b 45 10          	mov    0x10(%rbp),%rax
* 2a:	8b 98 8c 06 01 00    	mov    0x1068c(%rax),%ebx <-- trapping instruction
  30:	48 8d bd a0 00 00 00 	lea    0xa0(%rbp),%rdi
  37:	48                   	rex.W
  38:	b8 00 00 00 00       	mov    $0x0,%eax
  3d:	00 fc                	add    %bh,%ah
  3f:	ff                   	.byte 0xff


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
