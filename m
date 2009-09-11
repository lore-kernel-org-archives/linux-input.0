From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: [PATCH -next] Input: i8042 - Fix pagefault caused by i8042_dmi_laptop_table
Date: Fri, 11 Sep 2009 12:16:01 +0900
Message-ID: <4AA9C0F1.6060708@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753712AbZIKDQE@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
List-Id: linux-input@vger.kernel.org

(This patch fixes bug of commit 1c49cd1bbb6e41e97079d389e86063ba5de825ed
 titled "Input: i8042 - bypass AUX IRQ delivery test on laptops")

When dmi_platform_init is called, the table i8042_dmi_laptop_table[] will
be checked. Because the end of this table is not "NULL", dmi_check_system
will lead to pagefault and oops will be happened.

In fact I got following oops on boot:
Call Trace:
  [<ffffffff813f86b8>] panic+0x7a/0x131
  [<ffffffff8105b29b>] ? exit_ptrace+0x94/0x114
  [<ffffffff81054acc>] do_exit+0x7a/0x695
  [<ffffffff813fbaec>] oops_end+0xb9/0xc1
  [<ffffffff81034037>] no_context+0x1f6/0x205
  [<ffffffff81034212>] __bad_area_nosemaphore+0x1cc/0x1f2
  [<ffffffff811f1739>] ? string+0x40/0x9f
  [<ffffffff811f20cf>] ? vsnprintf+0x8b/0x426
  [<ffffffff813fac0a>] ?_spin_unlock_irqrestore+0x29/0x41
  [<ffffffff8103424b>] bad_area_nosemaphore+0x13/0x15
  [<ffffffff813fcf9d>] do_page_fault+0x154/0x2a5
  [<ffffffff813faef5>] page_fault+0x25/0x30
  [<ffffffff81335895>] ? dmi_check_system+0x30/0x4b
  [<ffffffff816eee5f>] i8042_init+0x2ca/0x3c1
  [<ffffffff816ee5eb>] ? uhci_hcd_init+0x88/0xc0
  [<ffffffff816eeb95>] ? i8042_init+0x0/0x3c1
  [<ffffffff8100a069>] do_one_initcall+0x5e/0x15e
  [<ffffffff816be167>] kernel_init+0x170/0x1ca
  [<ffffffff81012c5a>] child_rip+0xa/0x20
  [<ffffffff810125bd>] ? restore_args+0x0/0x30
  [<ffffffff81bbdff7>] ? kernel_init+0x0/0x1ca
  [<ffffffff81012c50>] ? child_rip+0x0/0x20

I confirmed this patch fix this problem.

Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
---
 drivers/input/serio/i8042-x86ia64io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index e1b9ee4..6e244a0 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -483,7 +483,7 @@ static struct dmi_system_id __initdata i8042_dmi_laptop_table[] = {
 			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
 		},
 	},
-
+	{ }
 };
 #endif
 
-- 
1.6.2.2
