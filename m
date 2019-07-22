From: stillcompiling@gmail.com
Subject: [PATCH 1/2] HID: core: Add hid printk_once macros
Date: Mon, 22 Jul 2019 10:36:41 -0600
Message-ID: <20190722163642.10417-1-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

Make available printk_once variants to hid_warn() etc

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 include/linux/hid.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index d770ab1a0479..5b239712c902 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1179,4 +1179,23 @@ do {									\
 #define hid_dbg(hid, fmt, arg...)			\
 	dev_dbg(&(hid)->dev, fmt, ##arg)
 
+#define hid_level_once(level, hid, fmt, arg...)		\
+	dev_level_once(level, &(hid)->dev, fmt, ##arg)
+#define hid_emerg_once(hid, fmt, arg...)		\
+	dev_emerg_once(&(hid)->dev, fmt, ##arg)
+#define hid_crit_once(hid, fmt, arg...)			\
+	dev_crit_once(&(hid)->dev, fmt, ##arg)
+#define hid_alert_once(hid, fmt, arg...)		\
+	dev_alert_once(&(hid)->dev, fmt, ##arg)
+#define hid_err_once(hid, fmt, arg...)			\
+	dev_err_once(&(hid)->dev, fmt, ##arg)
+#define hid_notice_once(hid, fmt, arg...)		\
+	dev_notice_once(&(hid)->dev, fmt, ##arg)
+#define hid_warn_once(hid, fmt, arg...)			\
+	dev_warn_once(&(hid)->dev, fmt, ##arg)
+#define hid_info_once(hid, fmt, arg...)			\
+	dev_info_once(&(hid)->dev, fmt, ##arg)
+#define hid_dbg_once(hid, fmt, arg...)			\
+	dev_dbg_once(&(hid)->dev, fmt, ##arg)
+
 #endif
-- 
2.21.0
