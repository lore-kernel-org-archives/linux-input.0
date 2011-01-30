From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 1/8] HID: roccat: Removed empty functions definitions for
 roccat chardev
Date: Sun, 30 Jan 2011 13:38:20 +0100
Message-ID: <1296391100.2283.180.camel__36667.0343479656$1296391211$gmane$org@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:49494 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753972Ab1A3Mi0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jan 2011 07:38:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil>

Roccat chardev is a dependency of all device specific drivers, so
the empty definitions are not needed anymore.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-roccat.h b/drivers/hid/hid-roccat.h
index 5784281..c739337 100644
--- a/drivers/hid/hid-roccat.h
+++ b/drivers/hid/hid-roccat.h
@@ -15,18 +15,8 @@
 #include <linux/hid.h>
 #include <linux/types.h>
 
-#if defined(CONFIG_HID_ROCCAT) || defined(CONFIG_HID_ROCCAT_MODULE)
 int roccat_connect(struct class *klass, struct hid_device *hid);
 void roccat_disconnect(int minor);
 int roccat_report_event(int minor, u8 const *data, int len);
-#else
-static inline int roccat_connect(struct class *klass,
-		struct hid_device *hid) { return -1; }
-static inline void roccat_disconnect(int minor) {}
-static inline int roccat_report_event(int minor, u8 const *data, int len)
-{
-	return 0;
-}
-#endif
 
 #endif
-- 
1.7.3.4



