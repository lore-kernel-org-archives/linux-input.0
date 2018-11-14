From: syzbot <syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com>
Subject: Re: BUG: GPF in non-whitelisted uaccess (non-canonical address?)
Date: Tue, 13 Nov 2018 16:25:04 -0800
Message-ID: <0000000000002d2a5b057a94f7ff@google.com>
References: <00000000000080f8fa057a67b75c@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000000000080f8fa057a67b75c@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, dh.herrmann@googlemail.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b4e77b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=72473edc9bf4eb1c6556
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1646a225400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108a6533400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com

audit: type=1400 audit(1542154838.102:35): avc:  denied  { map } for   
pid=6149 comm="bash" path="/bin/bash" dev="sda1" ino=1457  
scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
audit: type=1400 audit(1542154844.872:36): avc:  denied  { map } for   
pid=6163 comm="syz-executor697" path="/root/syz-executor697315096"  
dev="sda1" ino=16483 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
BUG: GPF in non-whitelisted uaccess (non-canonical address?)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6163 Comm: syz-executor697 Not tainted 4.20.0-rc2+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:180
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
RSP: 0018:ffff8881d188f398 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000109 RCX: 0000000000000109
RDX: 0000000000000109 RSI: 241037f828e5769d RDI: ffff8881ce130738
RBP: ffff8881d188f3d0 R08: ffffed1039c26109 R09: ffffed1039c26109
R10: ffffed1039c26108 R11: ffff8881ce130840 R12: 241037f828e577a6
R13: 241037f828e5769d R14: ffff8881ce130738 R15: ffffffffffffffff
FS:  0000000001dab880(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020d83ff8 CR3: 00000001b6a5c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  copy_from_user include/linux/uaccess.h:147 [inline]
  uhid_dev_create+0x20c/0xb40 drivers/hid/uhid.c:542
  uhid_char_write+0xc74/0xef0 drivers/hid/uhid.c:725
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  __kernel_write+0x10c/0x370 fs/read_write.c:506
  write_pipe_buf+0x180/0x240 fs/splice.c:797
  splice_from_pipe_feed fs/splice.c:503 [inline]
  __splice_from_pipe+0x38b/0x7c0 fs/splice.c:627
  splice_from_pipe+0x1ec/0x340 fs/splice.c:662
  default_file_splice_write+0x3c/0x90 fs/splice.c:809
  do_splice_from fs/splice.c:851 [inline]
  direct_splice_actor+0x128/0x190 fs/splice.c:1018
  splice_direct_to_actor+0x318/0x8f0 fs/splice.c:973
  do_splice_direct+0x2d4/0x420 fs/splice.c:1061
  do_sendfile+0x62a/0xe20 fs/read_write.c:1439
  __do_sys_sendfile64 fs/read_write.c:1494 [inline]
  __se_sys_sendfile64 fs/read_write.c:1486 [inline]
  __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1486
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440309
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcd9cfe2e8 EFLAGS: 00000203 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440309
RDX: 0000000020d83ff8 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00008000fffffffe R11: 0000000000000203 R12: 0000000000401b90
R13: 0000000000401c20 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d77e684529ebafbc ]---
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:180
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
RSP: 0018:ffff8881d188f398 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000109 RCX: 0000000000000109
RDX: 0000000000000109 RSI: 241037f828e5769d RDI: ffff8881ce130738
RBP: ffff8881d188f3d0 R08: ffffed1039c26109 R09: ffffed1039c26109
R10: ffffed1039c26108 R11: ffff8881ce130840 R12: 241037f828e577a6
R13: 241037f828e5769d R14: ffff8881ce130738 R15: ffffffffffffffff
FS:  0000000001dab880(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020d83ff8 CR3: 00000001b6a5c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
