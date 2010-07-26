From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 15/36]  [Driver][Qualcomm 1070][VERSION] Adding version definition
Date: Mon, 26 Jul 2010 16:30:24 +0800
Message-ID: <1280133045-25945-15-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56228 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0GZIbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:31:20 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so4322709pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:31:20 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/include/asm/img_version.h |   14 +++++++++
 arch/arm/mach-msm/Makefile         |    1 +
 arch/arm/mach-msm/smd_private.h    |    2 +
 arch/arm/mach-msm/version.c        |   56 ++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100755 arch/arm/include/asm/img_version.h
 mode change 100644 => 100755 arch/arm/mach-msm/smd_private.h
 create mode 100755 arch/arm/mach-msm/version.c

diff --git a/arch/arm/include/asm/img_version.h b/arch/arm/include/asm/img_version.h
new file mode 100755
index 0000000..52a019f
--- /dev/null
+++ b/arch/arm/include/asm/img_version.h
@@ -0,0 +1,14 @@
+#ifndef	__IMG_VERSION_H__
+#define __IMG_VERSION_H__
+
+#define MAX_STRING_LEN   32
+
+struct version_info {
+	char project_name[MAX_STRING_LEN];
+	char hw_mode[MAX_STRING_LEN];
+	char hw_revision[MAX_STRING_LEN];
+	char bsp_version[MAX_STRING_LEN];
+	char bsp_revision[MAX_STRING_LEN];
+};
+
+#endif
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index a395627..a8b0153 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -13,6 +13,7 @@ obj-y += cpufreq.o
 obj-y += nohlt.o
 obj-y += pmic.o
 obj-y += internal_power_rail.o
+obj-y += version.o
 
 obj-$(CONFIG_ARCH_MSM_ARM11) += acpuclock.o
 obj-$(CONFIG_MSM_VIC) += irq-vic.o
diff --git a/arch/arm/mach-msm/smd_private.h b/arch/arm/mach-msm/smd_private.h
old mode 100644
new mode 100755
index 9686db9..a53d994
--- a/arch/arm/mach-msm/smd_private.h
+++ b/arch/arm/mach-msm/smd_private.h
@@ -253,6 +253,8 @@ enum {
 	SMEM_SMD_BRIDGE_ALLOC_TABLE,
 	SMEM_SMDLITE_TABLE,
 	SMEM_SD_IMG_UPGRADE_STATUS,
+	SMEM_QCI_RAMTEST_INFO,
+	SMEM_QCI_ST15_VERSION,
 	SMEM_SEFS_INFO,
 	SMEM_NUM_ITEMS,
 };
diff --git a/arch/arm/mach-msm/version.c b/arch/arm/mach-msm/version.c
new file mode 100755
index 0000000..c683fe1
--- /dev/null
+++ b/arch/arm/mach-msm/version.c
@@ -0,0 +1,56 @@
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/utsname.h>
+#include <linux/utsrelease.h>
+#include <asm/uaccess.h>
+#include <asm/img_version.h>
+
+#include "proc_comm.h"
+#include "smd_private.h"
+
+#define KERNEL_VERSION UTS_RELEASE
+#define IMAGE_VERSION "0.1.0"
+
+static int version_proc_show(struct seq_file *m, void *v)
+{
+	struct version_info *version;
+
+        version = smem_alloc(SMEM_QCI_ST15_VERSION , sizeof(struct version_info));
+	if(version == NULL) {
+                pr_err("failed to get data from smem");
+		return -1;
+	}
+
+	seq_printf(m, "Project Name : %s\n", version->project_name);
+	seq_printf(m, "Hardware Mode : %s\n", version->hw_mode);
+	seq_printf(m, "Hardware Revision : %s\n", version->hw_revision);
+	seq_printf(m, "BSP Version : %s\n", version->bsp_version);
+	seq_printf(m, "BSP Revision : %s\n", version->bsp_revision);
+	seq_printf(m, "Kernel version : %s\n", KERNEL_VERSION);
+	seq_printf(m, "Image version : %s\n", IMAGE_VERSION);
+	return 0;
+}
+
+static int version_proc_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, version_proc_show, NULL);
+}
+
+static const struct file_operations version_proc_fops = {
+        .open           = version_proc_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+        .release        = single_release,
+};
+
+static int __init proc_version_init(void)
+{
+        proc_create("img_version", 0, NULL, &version_proc_fops);
+
+        return 0;
+}
+module_init(proc_version_init);
+
-- 
1.7.0.4

