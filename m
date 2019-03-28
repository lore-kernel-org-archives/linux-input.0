From: Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH RESEND -next] Input: uinput - Avoid Use-After-Free with udev lock
Date: Thu, 28 Mar 2019 15:55:52 +0530
Message-ID: <1553768752-21739-1-git-send-email-mojha@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mukesh Ojha <mojha@codeaurora.org>, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

uinput_destroy_device() gets called from two places. In one place,
uinput_ioctl_handler() it is protected under a lock udev->mutex
but same is not true for other place inside uinput_release().

This can result in a race where udev device gets freed while it
is in use.

[  160.093398] Call trace:
[  160.093417]  kernfs_get+0x64/0x88
[  160.093438]  kernfs_new_node+0x94/0xc8
[  160.093450]  kernfs_create_dir_ns+0x44/0xfc
[  160.093463]  sysfs_create_dir_ns+0xa8/0x130
[  160.093479]  kobject_add_internal+0x278/0x650
[  160.093491]  kobject_add_varg+0xe0/0x130
[  160.093502]  kobject_add+0x15c/0x1d0
[  160.093518]  device_add+0x2bc/0xde0
[  160.093533]  input_register_device+0x5f4/0xa0c
[  160.093547]  uinput_ioctl_handler+0x1184/0x2198
[  160.093560]  uinput_ioctl+0x38/0x48
[  160.093573]  vfs_ioctl+0x7c/0xb4
[  160.093585]  do_vfs_ioctl+0x9ec/0x2350
[  160.093597]  SyS_ioctl+0x6c/0xa4
[  160.093610]  el0_svc_naked+0x34/0x38
[  160.093621] ---[ end trace bccf0093cda2c538 ]---
[  160.099041] =============================================================================
[  160.107459] BUG kernfs_node_cache (Tainted: G S      W  O   ): Object already free
[  160.115235] -----------------------------------------------------------------------------
[  160.115235]
[  160.125151] Disabling lock debugging due to kernel taint
[  160.130626] INFO: Allocated in __kernfs_new_node+0x8c/0x3c0 age=11 cpu=2 pid=7098
[  160.138314] 	kmem_cache_alloc+0x358/0x388
[  160.142445] 	__kernfs_new_node+0x8c/0x3c0
[  160.146590] 	kernfs_new_node+0x80/0xc8
[  160.150462] 	kernfs_create_dir_ns+0x44/0xfc
[  160.154777] 	sysfs_create_dir_ns+0xa8/0x130
[  160.158416] CPU5: update max cpu_capacity 1024
[  160.159085] 	kobject_add_internal+0x278/0x650
[  160.163567] 	kobject_add_varg+0xe0/0x130
[  160.167606] 	kobject_add+0x15c/0x1d0
[  160.168452] CPU5: update max cpu_capacity 780
[  160.171287] 	get_device_parent+0x2d0/0x34c
[  160.175510] 	device_add+0x240/0xde0
[  160.178371] CPU6: update max cpu_capacity 916
[  160.179108] 	input_register_device+0x5f4/0xa0c
[  160.183686] 	uinput_ioctl_handler+0x1184/0x2198
[  160.188346] 	uinput_ioctl+0x38/0x48
[  160.191941] 	vfs_ioctl+0x7c/0xb4
[  160.195261] 	do_vfs_ioctl+0x9ec/0x2350
[  160.199111] 	SyS_ioctl+0x6c/0xa4
[  160.202436] INFO: Freed in kernfs_put+0x2c8/0x434 age=14 cpu=0 pid=7096
[  160.209230] 	kernfs_put+0x2c8/0x434
[  160.212825] 	kobject_del+0x50/0xcc
[  160.216332] 	cleanup_glue_dir+0x124/0x16c
[  160.220456] 	device_del+0x55c/0x5c8
[  160.224047] 	__input_unregister_device+0x274/0x2a8
[  160.228974] 	input_unregister_device+0x90/0xd0
[  160.233553] 	uinput_destroy_device+0x15c/0x1dc
[  160.238131] 	uinput_release+0x44/0x5c
[  160.241898] 	__fput+0x1f4/0x4e4
[  160.245127] 	____fput+0x20/0x2c
[  160.248358] 	task_work_run+0x9c/0x174
[  160.252127] 	do_notify_resume+0x104/0x6bc
[  160.256253] 	work_pending+0x8/0x14
[  160.259751] INFO: Slab 0xffffffbf0215ff00 objects=33 used=11 fp=0xffffffc0857ffd08 flags=0x8101
[  160.268693] INFO: Object 0xffffffc0857ffd08 @offset=15624 fp=0xffffffc0857fefb0
[  160.268693]
[  160.277721] Redzone ffffffc0857ffd00: bb bb bb bb bb bb bb bb                          ........
[  160.286656] Object ffffffc0857ffd08: 00 00 00 00 01 00 00 80 58 a2 37 45 c1 ff ff ff  ........X.7E....
[  160.296207] Object ffffffc0857ffd18: ae 21 10 0b 90 ff ff ff 20 fd 7f 85 c0 ff ff ff  .!...... .......
[  160.305780] Object ffffffc0857ffd28: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[  160.315342] Object ffffffc0857ffd38: 00 00 00 00 00 00 00 00 7d a3 25 69 00 00 00 00  ........}.%i....
[  160.324896] Object ffffffc0857ffd48: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[  160.334446] Object ffffffc0857ffd58: 80 c0 28 47 c1 ff ff ff 00 00 00 00 00 00 00 00  ..(G............
[  160.344000] Object ffffffc0857ffd68: 80 4a ce d1 c0 ff ff ff dc 32 01 00 01 00 00 00  .J.......2......
[  160.353554] Object ffffffc0857ffd78: 11 00 ed 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
[  160.363099] Redzone ffffffc0857ffd88: bb bb bb bb bb bb bb bb                          ........
[  160.372032] Padding ffffffc0857ffee0: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
[  160.378299] CPU6: update max cpu_capacity 780
[  160.380971] CPU: 4 PID: 7098 Comm: syz-executor Tainted: G S  B   W  O    4.14.98+ #1

So, avoid the race by taking a udev lock inside `uinput_release()`.

Change-Id: I3bbb07589b7b6e0e1b3bea572b5eb4f6b09774d6
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Gaurav Kohli <gkohli@codeaurora.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Martin Kepplinger <martink@posteo.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>

---
 drivers/input/misc/uinput.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 26ec603f..a3fb3b1 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -714,9 +714,15 @@ static __poll_t uinput_poll(struct file *file, poll_table *wait)
 static int uinput_release(struct inode *inode, struct file *file)
 {
 	struct uinput_device *udev = file->private_data;
+	ssize_t retval;
+
+	retval = mutex_lock_interruptible(&udev->mutex);
+	if (retval)
+		return retval;
 
 	uinput_destroy_device(udev);
 	kfree(udev);
+	mutex_unlock(&udev->mutex);
 
 	return 0;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
