From: stillcompiling@gmail.com
Subject: [PATCH v3 2/3] HID: core: Add printk_once variants to hid_warn() etc
Date: Mon, 22 Jul 2019 15:48:26 -0600
Message-ID: <20190722214827.29257-2-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
 <20190722214827.29257-1-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722214827.29257-1-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

hid_warn_once() is needed, add the others as part of the block

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 include/linux/hid.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index e6c7efdb0458..cd41f209043f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1171,4 +1171,15 @@ do {									\
 #define hid_dbg(hid, fmt, ...)				\
 	dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
 
+#define hid_err_once(hid, fmt, ...)			\
+	dev_err_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice_once(hid, fmt, ...)			\
+	dev_notice_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn_once(hid, fmt, ...)			\
+	dev_warn_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info_once(hid, fmt, ...)			\
+	dev_info_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg_once(hid, fmt, ...)			\
+	dev_dbg_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+
 #endif
-- 
2.21.0
