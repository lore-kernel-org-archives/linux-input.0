From: "He, Bo" <bo.he@intel.com>
Subject: must hold the driver_input_lock in hid_debug_rdesc_show
Date: Thu, 14 Mar 2019 02:28:21 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Zhang, Jun" <jun.zhang@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

we see the below kernel panic logs when run suspend resume test with
usb mouse and usb keyboard connected.

the scenario is the userspace call the hid_debug_rdesc_show to dump
the input device while the device is removed. the patch
hold the driver_input_lock to avoid the race.

[ 5381.757295] selinux: SELinux:  Could not stat
/sys/devices/pci0000:00/0000:00:15.0/usb1/1-2/1-2:1.0/0003:03F0:0325.0320/input/input960/input960::scrolllock:
No such file or directory.
[ 5382.636498] BUG: unable to handle kernel paging request at 0000000783316040
[ 5382.651950] CPU: 1 PID: 1512 Comm: getevent Tainted: G     U     O 4.19.20-quilt-2e5dc0ac-00029-gc455a447dd55 #1
[ 5382.663797] RIP: 0010:hid_dump_device+0x9b/0x160
[ 5382.758853] Call Trace:
[ 5382.761581]  hid_debug_rdesc_show+0x72/0x1d0
[ 5382.766343]  seq_read+0xe0/0x410
[ 5382.769941]  full_proxy_read+0x5f/0x90
[ 5382.774121]  __vfs_read+0x3a/0x170
[ 5382.788392]  vfs_read+0xa0/0x150
[ 5382.791984]  ksys_read+0x58/0xc0
[ 5382.801404]  __x64_sys_read+0x1a/0x20
[ 5382.805483]  do_syscall_64+0x55/0x110
[ 5382.809559]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
---
 drivers/hid/hid-debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index ebc9ffde41e9..a353a011fbdf 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1060,10 +1060,15 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	seq_printf(f, "\n\n");
 
 	/* dump parsed data and input mappings */
+	if (down_interruptible(&hdev->driver_input_lock))
+		return 0;
+
 	hid_dump_device(hdev, f);
 	seq_printf(f, "\n");
 	hid_dump_input_mapping(hdev, f);
 
+	up(&hdev->driver_input_lock);
+
 	return 0;
 }
 
-- 
2.20.1
