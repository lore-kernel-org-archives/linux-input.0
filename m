From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/12 v2] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Fri, 17 Jun 2011 16:49:15 +0200
Message-ID: <1308322162-13953-5-git-send-email-dh.herrmann@googlemail.com>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45267 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759232Ab1FQOuU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 10:50:20 -0400
Received: by fxm17 with SMTP id 17so1796143fxm.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 07:50:19 -0700 (PDT)
In-Reply-To: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, dh.herrmann@googlemail.com

The wiimote first starts HID hardware and then registers the input
device. We need to synchronize the startup so no event handler will
start parsing events when the wiimote device is not ready, yet.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Add memory barriers to guarantee data consistency.

 drivers/hid/hid-wiimote.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index deaf232..afae0e9 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -10,6 +10,7 @@
  * any later version.
  */
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
@@ -20,6 +21,7 @@
 #define WIIMOTE_NAME "Nintendo Wii Remote"
 
 struct wiimote_data {
+	atomic_t ready;
 	struct hid_device *hdev;
 	struct input_dev *input;
 };
@@ -27,12 +29,24 @@ struct wiimote_data {
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+	smp_rmb();
+
 	return 0;
 }
 
 static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 							u8 *raw_data, int size)
 {
+	struct wiimote_data *wdata = hid_get_drvdata(hdev);
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+	smp_rmb();
+
 	if (size < 1)
 		return -EINVAL;
 
@@ -103,6 +117,8 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	smp_wmb();
+	atomic_set(&wdata->ready, 1);
 	hid_info(hdev, "New device registered\n");
 	return 0;
 
-- 
1.7.5.2

