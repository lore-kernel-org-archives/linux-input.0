From: Zhipeng Xie <xiezhipeng1@huawei.com>
Subject: [PATCH] Input: fix oops in input_to_handler
Date: Fri, 1 Mar 2019 12:13:27 +0800
Message-ID: <1551413607-32036-1-git-send-email-xiezhipeng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel.openeuler@huawei.com, euleros@huawei.com, huawei.libin@huawei.com, yangyingliang@huawei.com, xiezhipeng1@huawei.com
List-Id: linux-input@vger.kernel.org

we got the following boot crash:

	[   36.086344] Internal error: Oops: 96000004 [#1] SMP
	[   36.091371] CPU: 32 PID: 0 Comm: swapper/32 Tainted: G           OE     4.19.25-vhulk1901.1.0.h111.aarch64 #1
	[   36.101444] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
	[   36.108860] pstate: 20000085 (nzCv daIf -PAN -UAO)
	[   36.113727] pc : input_to_handler+0x2c/0x148
	[   36.118058] lr : input_pass_values.part.2+0x148/0x168
	[   36.123177] sp : ffff000100103ba0
	[   36.126535] x29: ffff000100103ba0 x28: ffff801fb2ac5958
	[   36.131924] x27: ffff000009799000 x26: 0000000000000001
	[   36.137375] x25: 0000000000000000 x24: ffff801fb5b57c00
	[   36.142822] x23: 000000020987f3d0 x22: ffff801faf427e00
	[   36.148211] x21: 0000000000000003 x20: 0000000000000003
	[   36.153599] x19: ffff801faf427e00 x18: 000000000000000e
	[   36.158986] x17: 000000000000000e x16: 0000000000000007
	[   36.164374] x15: 0000000000000001 x14: 0000000000000019
	[   36.169762] x13: 0000000000000033 x12: 000000000000004c
	[   36.175150] x11: 0000000000000068 x10: ffff000008dfa290
	[   36.180538] x9 : 000000000000007d x8 : 0000000000000000
	[   36.185925] x7 : 0000000000000053 x6 : 0000000000000000
	[   36.191313] x5 : 0000000000000000 x4 : 0000000000000000
	[   36.196700] x3 : 0000000000000010 x2 : 0000000000000003
	[   36.202088] x1 : ffff801fb5b57c00 x0 : ffff000008a120a0
	[   36.207477] Process swapper/32 (pid: 0, stack limit = 0x0000000032f86b58)
	[   36.214361] Call trace:
	[   36.216840]  input_to_handler+0x2c/0x148
	[   36.220816]  input_pass_values.part.2+0x148/0x168
	[   36.225582]  input_handle_event+0x130/0x5b8
	[   36.229823]  i6.242013]  hid_input_report+0x128/0x1b0
	[   36.246076]  hid_irq_in+0x240/0x298
	[   36.249613]  __usb_hcd_giveback_urb+0x9c/0x130
	[   36.257460]  usb_giveback_urb_bh+0xf4/0x198
	[   36.265127]  tasklet_action_common.isra.6+0x94/0x160
	[   36.273458]  tasklet_hi_action+0x2c/0x38
	[   36.280597]  __do_softirq+0x118/0x314
	[   36.287494]  irq_exit+0xa4/0xe8
	[   36.293682]  __handle_domain_irq+0x6c/0xc0
	[   36.300783]  gic_handle_irq+0x6c/0x170
	[   36.307296]  el1_irq+0xb8/0x140
	[   36.313283]  arch_cpu_idle+0x38/0x1c0
	[   36.319776]  default_idle_call+0x24/0x44
	[   36.326527]  do_idle+0x1ec/0x2d0
	[   36.332503]  cpu_startup_entry+0x28/0x30
	[   36.339161]  secondary_start_kernel+0x194/0x1d8

We need to check the input_handler before referencing its members.

Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
---
 drivers/input/input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaa..b768d14 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -100,6 +100,9 @@ static unsigned int input_to_handler(struct input_handle *handle,
 	struct input_value *end = vals;
 	struct input_value *v;
 
+	if (!handler)
+		return 0;
+
 	if (handler->filter) {
 		for (v = vals; v != vals + count; v++) {
 			if (handler->filter(handle, v->type, v->code, v->value))
-- 
1.7.12.4
