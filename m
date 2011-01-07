From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v3 2/5] hid: set HID_MAX_FIELD at 128
Date: Fri,  7 Jan 2011 19:42:39 +0100
Message-ID: <1294425762-29730-3-git-send-email-benjamin.tissoires@enac.fr>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>
List-Id: linux-input@vger.kernel.org

Stantums multitouch panels sends more than 64 reports and this results
in not being able to handle all the touches given by this device.

This patch is required to be able to include Stantum panels in the
unified hid-multitouch driver.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Acked-by: Henrik Rydberg <rydberg@euromail.se>
---
 include/linux/hid.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75303b0..b76af97 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -402,7 +402,7 @@ struct hid_field {
 	__u16 dpad;			/* dpad input code */
 };
 
-#define HID_MAX_FIELDS 64
+#define HID_MAX_FIELDS 128
 
 struct hid_report {
 	struct list_head list;
-- 
1.7.3.4
