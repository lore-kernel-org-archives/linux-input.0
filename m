From: stillcompiling@gmail.com
Subject: [PATCH v2 1/3] HID: core: reformat and reduce hid_printk macros
Date: Mon, 22 Jul 2019 15:26:11 -0600
Message-ID: <20190722212613.24906-1-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722163642.10417-2-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

Reformat hid_printk macros to use standard __VA_ARGS__ syntax
Remove hid_printk(), hid_emerg(), hid_crit(), and hid_alert().
Per Joe Perches these unused and likely never to be used.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 include/linux/hid.h | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index d770ab1a0479..b5e73331100e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1154,29 +1154,21 @@ int hid_pidff_init(struct hid_device *hid);
 #define hid_pidff_init NULL
 #endif
 
-#define dbg_hid(format, arg...)						\
+#define dbg_hid(fmt, ...)						\
 do {									\
 	if (hid_debug)							\
-		printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);	\
+		printk(KERN_DEBUG "%s: " fmt, __FILE__, ##__VA_ARGS__)	\
 } while (0)
 
-#define hid_printk(level, hid, fmt, arg...)		\
-	dev_printk(level, &(hid)->dev, fmt, ##arg)
-#define hid_emerg(hid, fmt, arg...)			\
-	dev_emerg(&(hid)->dev, fmt, ##arg)
-#define hid_crit(hid, fmt, arg...)			\
-	dev_crit(&(hid)->dev, fmt, ##arg)
-#define hid_alert(hid, fmt, arg...)			\
-	dev_alert(&(hid)->dev, fmt, ##arg)
-#define hid_err(hid, fmt, arg...)			\
-	dev_err(&(hid)->dev, fmt, ##arg)
-#define hid_notice(hid, fmt, arg...)			\
-	dev_notice(&(hid)->dev, fmt, ##arg)
-#define hid_warn(hid, fmt, arg...)			\
-	dev_warn(&(hid)->dev, fmt, ##arg)
-#define hid_info(hid, fmt, arg...)			\
-	dev_info(&(hid)->dev, fmt, ##arg)
-#define hid_dbg(hid, fmt, arg...)			\
-	dev_dbg(&(hid)->dev, fmt, ##arg)
+#define hid_err(hid, fmt, ...)				\
+	dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice(hid, fmt, ...)			\
+	dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn(hid, fmt, ...)				\
+	dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info(hid, fmt, ...)				\
+	dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg(hid, fmt, ...)				\
+	dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
 
 #endif
-- 
2.21.0
