From: syzbot <syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com>
Subject: Re: INFO: trying to register non-static key in usbtouch_reset_resume
Date: Thu, 20 Jun 2019 02:33:05 -0700
Message-ID: <000000000000773344058bbe0858@google.com>
References: <0000000000005463aa0589dcfb85@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000005463aa0589dcfb85@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: allison@lohutok.net, andreyknvl@google.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, mpe@ellerman.id.au, rfontana@redhat.com, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
List-Id: linux-input@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9939f56e usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=100c063aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df134eda130bb43a
dashboard link: https://syzkaller.appspot.com/bug?extid=933daad9be4e67ba91a9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144fa5e6a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d12de6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com

usb 1-1: reset low-speed USB device number 2 using dummy_hcd
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc5+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:775 [inline]
  register_lock_class+0x11ae/0x1240 kernel/locking/lockdep.c:1084
  __lock_acquire+0x11d/0x5340 kernel/locking/lockdep.c:3674
  lock_acquire+0x100/0x2b0 kernel/locking/lockdep.c:4303
  __mutex_lock_common kernel/locking/mutex.c:926 [inline]
  __mutex_lock+0xf9/0x12b0 kernel/locking/mutex.c:1073
  usbtouch_reset_resume+0xb1/0x170  
drivers/input/touchscreen/usbtouchscreen.c:1611
  usb_resume_interface drivers/usb/core/driver.c:1242 [inline]
  usb_resume_interface.isra.0+0x184/0x390 drivers/usb/core/driver.c:1210
  usb_resume_both+0x23d/0x780 drivers/usb/core/driver.c:1412
  __rpm_callback+0x27e/0x3c0 drivers/base/power/runtime.c:355
  rpm_callback+0x18f/0x230 drivers/base/power/runtime.c:485
  rpm_resume+0x10c5/0x1840 drivers/base/power/runtime.c:849
  __pm_runtime_resume+0x103/0x180 drivers/base/power/runtime.c:1076
  pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
  usb_autoresume_device+0x1e/0x60 drivers/usb/core/driver.c:1599
  usb_remote_wakeup+0x7b/0xb0 drivers/usb/core/hub.c:3601
  hub_port_connect_change drivers/usb/core/hub.c:5190 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x23d7/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb 1-1: reset low-speed USB device number 2 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb 1-1: reset low-speed USB device number 2 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb 1-1: reset low-speed USB device number 2 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb 1-1: reset low-speed USB device number 2 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
usb 1-1: reset low-speed USB device number 2 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
