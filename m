From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/7] HID: remove no longer used hid->open field
Date: Wed, 31 May 2017 13:59:51 -0700
Message-ID: <20170531205951.30852-8-dmitry.torokhov@gmail.com>
References: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Now that all users have migrated to use hid->ll_open_count, we can remove
hid->open field.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/hid.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5501eb64dbc4..72e8ac667771 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -548,7 +548,6 @@ struct hid_device {							/* device report descriptor */
 	void *hiddev;							/* The hiddev structure */
 	void *hidraw;
 
-	int open;							/* is the device open by anyone? */
 	char name[128];							/* Device name */
 	char phys[64];							/* Device physical location */
 	char uniq[64];							/* Device unique identifier (serial #) */
-- 
2.13.0.506.g27d5fe0cd-goog
