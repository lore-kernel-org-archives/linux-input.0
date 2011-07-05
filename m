From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/12] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Tue,  5 Jul 2011 13:45:12 +0200
Message-ID: <1309866319-12899-5-git-send-email-dh.herrmann@googlemail.com>
References: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59515 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab1GELph (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 07:45:37 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so6110854fxd.11
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 04:45:37 -0700 (PDT)
In-Reply-To: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

The wiimote first starts HID hardware and then registers the input
device. We need to synchronize the startup so no event handler will
start parsing events when the wiimote device is not ready, yet.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index deaf232..3416f69 100644
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
@@ -27,12 +29,26 @@ struct wiimote_data {
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
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
+	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
+	smp_rmb();
+
 	if (size < 1)
 		return -EINVAL;
 
@@ -103,6 +119,9 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	/* smp_wmb: Write wdata->xy first before wdata->ready is set to 1 */
+	smp_wmb();
+	atomic_set(&wdata->ready, 1);
 	hid_info(hdev, "New device registered\n");
 	return 0;
 
-- 
1.7.6

