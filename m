From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 54/63] Input: atmel_mxt_ts: Avoid race condition in freeing of input device
Date: Fri, 16 Aug 2019 17:37:48 +0900
Message-ID: <20190816083757.19449-5-jiada_wang@mentor.com>
References: <20190816083757.19449-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083757.19449-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>

>From the static analysis of the code it seems that there could be a
race condition leading to crash while freeing input device in
mxt_free_input_device(). The backtrace of crash is as shown below:

Unable to handle kernel NULL pointer dereference at virtual address 0000003c
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
CPU: 1 PID: 229 Comm: load_firmware.s Not tainted 3.14.79-00978-g58395f0ebac4 #1
PC is at kernfs_find_ns+0x14/0xf0
LR is at kernfs_find_and_get_ns+0x34/0x50
Backtrace:
[<801745c0>] (kernfs_find_ns) from [<801746e4>] (kernfs_find_and_get_ns+0x34/0x50)
[<801746b0>] (kernfs_find_and_get_ns) from [<801730c8>] (sysfs_unmerge_group+0x20/0x60)
[<801730a8>] (sysfs_unmerge_group) from [<80328490>] (pm_qos_sysfs_remove_latency+0x18/0x20)
[<80328478>] (pm_qos_sysfs_remove_latency) from [<80329844>] (dev_pm_qos_constraints_destroy+0x20/0x128)
[<80329824>] (dev_pm_qos_constraints_destroy) from [<80328510>] (dpm_sysfs_remove+0x18/0x44)
[<803284f8>] (dpm_sysfs_remove) from [<80320514>] (device_del+0x3c/0x178)
[<803204d8>] (device_del) from [<803b5ae8>] (__input_unregister_device+0x120/0x134)
[<803b59c8>] (__input_unregister_device) from [<803b5b68>] (input_unregister_device+0x54/0x74)
[<803b5b14>] (input_unregister_device) from [<7f1288bc>] (mxt_debug_enable_store+0x1a8/0x2c4 [atmel_mxt_ts])
[<7f12888c>] (mxt_debug_enable_store [atmel_mxt_ts]) from [<7f12b534>] (mxt_update_cfg_store+0xc4/0x154 [atmel_mxt_ts])
[<7f12b470>] (mxt_update_cfg_store [atmel_mxt_ts]) from [<8031f4e8>] (dev_attr_store+0x20/0x2c)
[<8031f4c8>] (dev_attr_store) from [<80172558>] (sysfs_kf_write+0x40/0x4c)
[<80172518>] (sysfs_kf_write) from [<801756fc>] (kernfs_fop_write+0xf8/0x140)
[<80175604>] (kernfs_fop_write) from [<801136e0>] (vfs_write+0xd8/0x16c)
[<80113608>] (vfs_write) from [<80113c34>] (SyS_write+0x50/0x90)
[<80113be4>] (SyS_write) from [<8000e0a0>] (ret_fast_syscall+0x0/0x38)

Note: mxt_free_input_device() is misrepresented as mxt_debug_enable_store()
in the crash backtrace. From the disassembly of the atmel_mxt_ts.ko, address
pointed by (mxt_debug_enable_store+0x1a8/0x2c4 [atmel_mxt_ts]) refers to
mxt_free_input_device()

There is speculation that this race condition may occur while
configuration (firmware) is loading and driver is being unloaded parallely.

The solution is to take a local pointer to data->input_dev with the lock
held and then to set data->input_dev to NULL to prevent any parallel
thread from executing input_unregister_device() for a second time overall
so avoiding the crash. The lock is released and the local pointer is
safely used by input_unregister_device() so this function only runs a
single time overall.

Signed-off-by: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
Signed-off-by: Sanjeev Chugh <sanjeev_chugh@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 79fc6561f6ad..35d92751e49f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2221,8 +2221,10 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 static void mxt_free_input_device(struct mxt_data *data)
 {
 	if (data->input_dev) {
-		input_unregister_device(data->input_dev);
+		struct input_dev *dev = data->input_dev;
+
 		data->input_dev = NULL;
+		input_unregister_device(dev);
 	}
 }
 
-- 
2.19.2
