From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: hiddev: use IS_ENABLED() for USB_HIDDEV
Date: Fri, 24 Jun 2016 10:28:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606241027520.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Use IS_ENABLED() for checking USB_HIDDEV to make sure compilation works 
for all possible config combinations.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 include/linux/hiddev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
index a5dd814..b6f48d6 100644
--- a/include/linux/hiddev.h
+++ b/include/linux/hiddev.h
@@ -37,7 +37,7 @@ struct hid_usage;
 struct hid_field;
 struct hid_report;
 
-#ifdef CONFIG_USB_HIDDEV
+#if IS_ENABLED(CONFIG_USB_HIDDEV)
 int hiddev_connect(struct hid_device *hid, unsigned int force);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,

-- 
Jiri Kosina
SUSE Labs
