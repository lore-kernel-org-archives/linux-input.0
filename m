From: Matthew Leach <matthew@mattleach.net>
Subject: [PATCH] HID: hid-input: fix double-free in cleanup_battery
Date: Wed, 12 Aug 2015 13:09:44 +0100
Message-ID: <1439381384-13733-1-git-send-email-matthew@mattleach.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Matthew Leach <matthew@mattleach.net>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The power supply layer has taken control of the power supply objects
from the drivers to core, see [1].  As such, calling
power_supply_unregister is enough to free the power_supply device.

Remove the extra kfree's as the power_supply core will handle freeing
the power_supply object for us.

[1]: 297d716f6260cc9421d971b124ca196b957ee458

Signed-off-by: Matthew Leach <matthew@mattleach.net>
Cc: <stable@vger.kernel.org>
---
Hello,

Since upgrading to v4.1 of the kernel I have noticed that the kernel
started to freeze whenever I disconnected my Bluetooth mouse.  Other
people are experiencing this too (see [1]).

Between versions v4.0 and v4.1 the power_supply core was re-worked to
take back ownership of the power_supply objects from the driver to
core-code.  I think hidinput_cleanup_battery may have been missed and
as such caused a double-free to occur as power_supply_unregister now
handle's freeing the objects.  I confirmed this with [2], notice the
battery object is cleaned up just before the kernel panics on calling
kfree.

Any comments welcome,
Matt

[1]: https://bugs.archlinux.org/task/45787

[2]:
[ 1521.116857] kobject: 'power_supply' (ffff880135bff4e0): kobject_cleanup, parent ffff8800b642b8f8
[ 1521.116879] kobject: 'power_supply' (ffff880135bff4e0): auto cleanup kobject_del
[ 1521.116886] kobject: 'power_supply' (ffff880135bff4e0): calling ktype release
[ 1521.116892] kobject: 'power_supply': free name
[ 1521.116898] kobject: 'hid-f0:65:dd:82:af:c6-battery' (ffff8800a3ddd848): kobject_cleanup, parent           (null)
[ 1521.116903] kobject: 'hid-f0:65:dd:82:af:c6-battery' (ffff8800a3ddd848): calling ktype release
[ 1521.116911] kobject: 'hid-f0:65:dd:82:af:c6-battery': free name
[ 1521.116921] BUG: unable to handle kernel NULL pointer dereference at           (null)
[ 1521.117052] IP: [<ffffffff818e24e9>] hidinput_disconnect+0x29/0xc0
[ 1521.117150] PGD 0
[ 1521.117190] Oops: 0000 [#1] PREEMPT SMP
[ 1521.117283] CPU: 0 PID: 176 Comm: kworker/u9:0 Not tainted 4.2.0-rc6-ARCH #12
[ 1521.117373] Hardware name: LENOVO 7469W92/7469W92, BIOS 6DET44WW (2.08 ) 04/22/2009
[ 1521.117475] Workqueue: hci0 hci_rx_work
[ 1521.117535] task: ffff880136b5f300 ti: ffff8800b73b4000 task.ti: ffff8800b73b4000
[ 1521.117629] RIP: 0010:[<ffffffff818e24e9>]  [<ffffffff818e24e9>] hidinput_disconnect+0x29/0xc0
[ 1521.117749] RSP: 0018:ffff8800b73b7a98  EFLAGS: 00010292
[ 1521.117825] RAX: 0000000000000000 RBX: ffff8800b642a000 RCX: 0000000180800071
[ 1521.117913] RDX: 0000000180800072 RSI: 0000000000000001 RDI: ffff880137001c00
[ 1521.118001] RBP: ffff8800b73b7ab8 R08: 2779726574746162 R09: ffff880137001c00
[ 1521.118090] R10: ffff880137001c00 R11: ffffffff81453d76 R12: ffff8800b642b8e8
[ 1521.118181] R13: ffff8800b642a000 R14: ffff8800b642a000 R15: ffff8800b642b8d0
[ 1521.118270] FS:  0000000000000000(0000) GS:ffff88013bc00000(0000) knlGS:0000000000000000
[ 1521.118372] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1521.118444] CR2: 0000000000000000 CR3: 000000000240d000 CR4: 00000000000406f0
[ 1521.118531] Stack:
[ 1521.118565]  ffff8800b642a000 ffff8800b642b8e8 ffff8800b642a000 ffff8800b642b8b8
[ 1521.118688]  ffff8800b73b7ad8 ffffffff818e0e11 00000000fffffffc ffff8800b642b8e8
[ 1521.118809]  ffff8800b73b7b18 ffffffff818e0ed5 ffff8800b73b7b18 ffff8800b642b8e8
[ 1521.118930] Call Trace:
[ 1521.118971]  [<ffffffff818e0e11>] hid_disconnect+0x71/0x80
[ 1521.119045]  [<ffffffff818e0ed5>] hid_device_remove+0xb5/0xd0
[ 1521.119122]  [<ffffffff8168bd7d>] __device_release_driver+0x8d/0x120
[ 1521.119205]  [<ffffffff8168c8ce>] device_release_driver+0x1e/0x30
[ 1521.119283]  [<ffffffff8168ad50>] bus_remove_device+0x100/0x180
[ 1521.119358]  [<ffffffff81688604>] device_del+0x134/0x260
[ 1521.119430]  [<ffffffff818e12d2>] hid_destroy_device+0x22/0x60
[ 1521.119510]  [<ffffffff81b34af6>] hidp_session_remove+0x46/0xb0
[ 1521.119588]  [<ffffffff81b12762>] l2cap_conn_del+0xa2/0x200
[ 1521.119661]  [<ffffffff81b128f9>] l2cap_disconn_cfm+0x39/0x60
[ 1521.119736]  [<ffffffff81af76d5>] hci_event_packet+0x1b75/0x3320
[ 1521.119818]  [<ffffffff81107202>] ? dequeue_entity+0x152/0x620
[ 1521.119897]  [<ffffffff81c323c3>] ? _raw_write_unlock_irqrestore+0x13/0x30
[ 1521.120884]  [<ffffffff81ae4248>] hci_rx_work+0x1b8/0x3e0
[ 1521.120884]  [<ffffffff810eee73>] process_one_work+0x123/0x3c0
[ 1521.120884]  [<ffffffff810ef153>] worker_thread+0x43/0x490
[ 1521.120884]  [<ffffffff810ef110>] ? process_one_work+0x3c0/0x3c0
[ 1521.120884]  [<ffffffff810f51f3>] kthread+0xd3/0xf0
[ 1521.120884]  [<ffffffff81c32379>] ? _raw_spin_unlock_irq+0x9/0x10
[ 1521.120884]  [<ffffffff810f5120>] ? __kthread_parkme+0x70/0x70
[ 1521.120884]  [<ffffffff81c3299f>] ret_from_fork+0x3f/0x70
[ 1521.120884]  [<ffffffff810f5120>] ? __kthread_parkme+0x70/0x70
[ 1521.120884] Code: 00 00 55 48 89 e5 41 56 49 89 fe 41 55 41 54 53 48 8b bf 98 1b 00 00 48 85 ff 74 31 e8 11 76 fa ff 49 8b 86 98 1b 00 00 48 8b 00 <48> 8b 38 e8 af 1b 8e ff 49 8b 86 98 1b 00 00 48 8b 38 e8 a0 1b
[ 1521.120884] RIP  [<ffffffff818e24e9>] hidinput_disconnect+0x29/0xc0
[ 1521.120884]  RSP <ffff8800b73b7a98>
[ 1521.120884] CR2: 0000000000000000

 drivers/hid/hid-input.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3511bbab..3a867bd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -466,8 +466,6 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 		return;
 
 	power_supply_unregister(dev->battery);
-	kfree(dev->battery->desc->name);
-	kfree(dev->battery->desc);
 	dev->battery = NULL;
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
-- 
2.5.0
