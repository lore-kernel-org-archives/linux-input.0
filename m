From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input: fix UBSAN warning in
 input_defuzz_abs_event
Date: Mon, 12 Nov 2018 11:48:53 -0800
Message-ID: <20181112194853.GH192687@dtor-ws>
References: <1541166531-248528-1-git-send-email-liujian56@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541166531-248528-1-git-send-email-liujian56@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: liujian <liujian56@huawei.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Fri, Nov 02, 2018 at 09:48:51PM +0800, liujian wrote:
> syzkaller triggered a UBCAN warning:
> 
> [  196.188950] UBSAN: Undefined behaviour in drivers/input/input.c:62:23
> [  196.188958] signed integer overflow:
> [  196.188964] -2147483647 - 104 cannot be represented in type 'int [2]'
> [  196.188973] CPU: 7 PID: 4763 Comm: syz-executor Not tainted
> 4.19.0-514.55.6.9.x86_64+ #7
> [  196.188977] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  196.188979] Call Trace:
> [  196.189001]  dump_stack+0x91/0xeb
> [  196.189014]  ubsan_epilogue+0x9/0x7c
> [  196.189020]  handle_overflow+0x1d7/0x22c
> [  196.189028]  ? __ubsan_handle_negate_overflow+0x18f/0x18f
> [  196.189038]  ? __mutex_lock+0x213/0x13f0
> [  196.189053]  ? drop_futex_key_refs+0xa0/0xa0
> [  196.189070]  ? __might_fault+0xef/0x1b0
> [  196.189096]  input_handle_event+0xe1b/0x1290
> [  196.189108]  input_inject_event+0x1d7/0x27e
> [  196.189119]  evdev_write+0x2cf/0x3f0
> [  196.189129]  ? evdev_pass_values+0xd40/0xd40
> [  196.189157]  ? mark_held_locks+0x160/0x160
> [  196.189171]  ? __vfs_write+0xe0/0x6c0
> [  196.189175]  ? evdev_pass_values+0xd40/0xd40
> [  196.189179]  __vfs_write+0xe0/0x6c0
> [  196.189186]  ? kernel_read+0x130/0x130
> [  196.189204]  ? _cond_resched+0x15/0x30
> [  196.189214]  ? __inode_security_revalidate+0xb8/0xe0
> [  196.189222]  ? selinux_file_permission+0x354/0x430
> [  196.189233]  vfs_write+0x160/0x440
> [  196.189242]  ksys_write+0xc1/0x190
> [  196.189248]  ? __ia32_sys_read+0xb0/0xb0
> [  196.189259]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [  196.189267]  ? do_syscall_64+0x22/0x4a0
> [  196.189276]  do_syscall_64+0xa5/0x4a0
> [  196.189287]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  196.189293] RIP: 0033:0x44e7c9
> [  196.189299] Code: fc ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00
> 
> the syzkaller reproduce script(but can't reproduce it every time):
> 
> r0 = syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> 0x1)
> write$binfmt_elf64(r0, &(0x7f0000000240)={{0x7f, 0x45, 0x4c, 0x46, 0x40,
> 0x2, 0x2, 0xffffffff, 0xffffffffffff374c, 0x3, 0x0, 0x80000001, 0x103,
> 0x40, 0x22e, 0x26, 0x1, 0x38, 0x2, 0xa23, 0x1, 0x2}, [{0x6474e557, 0x5,
> 0x6, 0x2, 0x9, 0x9, 0x6c3, 0x1ff}], "", [[], [], [], []]}, 0x478)
> ioctl$EVIOCGSW(0xffffffffffffffff, 0x8040451b, &(0x7f0000000040)=""/7)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> r1 = syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> 0x1)
> openat$smack_task_current(0xffffffffffffff9c,
> &(0x7f0000000040)='/proc/self/attr/current\x00', 0x2, 0x0)
> ioctl$EVIOCSABS0(r1, 0x401845c0, &(0x7f0000000000)={0x4, 0x10000, 0x4,
> 0xd1, 0x81, 0x3})
> eventfd(0x1ff)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> 0x200)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> 
> Typecast int to long to fix the issue.

Does this fix 32-bit platforms where long equals int? BTW, I'd prefer if
we did not have to do 64 bit arithmetic on 32 bit arches here, if
possible.

Thanks.

-- 
Dmitry
