From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree module device table
Date: Tue, 16 Apr 2019 21:57:22 +0200
Message-ID: <1555444645-15156-2-git-send-email-info@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555444645-15156-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Little helper macro that declares an oftree module device table,
if CONFIG_OF is enabled. Otherwise it's just noop.

This is also helpful if some drivers can be built w/ or w/o
oftree support.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/mod_devicetable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c..853e301 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -245,6 +245,15 @@ struct of_device_id {
 	const void *data;
 };
 
+/*
+ * macro for adding the of module device table only if CONFIG_OF enabled
+ */
+#ifdef CONFIG_OF
+#define MODULE_DEVICE_TABLE_OF(name)	MODULE_DEVICE_TABLE(of,name)
+#else
+#define MODULE_DEVICE_TABLE_OF(name)
+#endif /* CONFIG_OF */
+
 /* VIO */
 struct vio_device_id {
 	char type[32];
-- 
1.9.1
