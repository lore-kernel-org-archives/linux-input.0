From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 02/12] HID: uhid: forward create_req to create2_req
Date: Tue, 29 Jul 2014 17:14:16 +0200
Message-ID: <1406646866-999-3-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32939 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaG2POt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:49 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so8970618wgh.2
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:47 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Instead of hard-coding the uhid_dev_create() function twice, copy any
create_req into a create2_req structure and forward it.

We allocate uhid_create_req on the stack here, but that should be fine.
Unlike uhid_create2_req it is fairly small (<1KB) and it's only used
temporarily to swap entries. uhid_dev_create2() doesn't access it.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 90 +++++++++++++++---------------------------------------
 1 file changed, 25 insertions(+), 65 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 16af4d3..c05b544 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -359,71 +359,6 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
 }
 #endif
 
-static int uhid_dev_create(struct uhid_device *uhid,
-			   const struct uhid_event *ev)
-{
-	struct hid_device *hid;
-	int ret;
-
-	if (uhid->running)
-		return -EALREADY;
-
-	uhid->rd_size = ev->u.create.rd_size;
-	if (uhid->rd_size <= 0 || uhid->rd_size > HID_MAX_DESCRIPTOR_SIZE)
-		return -EINVAL;
-
-	uhid->rd_data = kmalloc(uhid->rd_size, GFP_KERNEL);
-	if (!uhid->rd_data)
-		return -ENOMEM;
-
-	if (copy_from_user(uhid->rd_data, ev->u.create.rd_data,
-			   uhid->rd_size)) {
-		ret = -EFAULT;
-		goto err_free;
-	}
-
-	hid = hid_allocate_device();
-	if (IS_ERR(hid)) {
-		ret = PTR_ERR(hid);
-		goto err_free;
-	}
-
-	strncpy(hid->name, ev->u.create.name, 127);
-	hid->name[127] = 0;
-	strncpy(hid->phys, ev->u.create.phys, 63);
-	hid->phys[63] = 0;
-	strncpy(hid->uniq, ev->u.create.uniq, 63);
-	hid->uniq[63] = 0;
-
-	hid->ll_driver = &uhid_hid_driver;
-	hid->bus = ev->u.create.bus;
-	hid->vendor = ev->u.create.vendor;
-	hid->product = ev->u.create.product;
-	hid->version = ev->u.create.version;
-	hid->country = ev->u.create.country;
-	hid->driver_data = uhid;
-	hid->dev.parent = uhid_misc.this_device;
-
-	uhid->hid = hid;
-	uhid->running = true;
-
-	ret = hid_add_device(hid);
-	if (ret) {
-		hid_err(hid, "Cannot register HID device\n");
-		goto err_hid;
-	}
-
-	return 0;
-
-err_hid:
-	hid_destroy_device(hid);
-	uhid->hid = NULL;
-	uhid->running = false;
-err_free:
-	kfree(uhid->rd_data);
-	return ret;
-}
-
 static int uhid_dev_create2(struct uhid_device *uhid,
 			    const struct uhid_event *ev)
 {
@@ -484,6 +419,31 @@ err_free:
 	return ret;
 }
 
+static int uhid_dev_create(struct uhid_device *uhid,
+			   struct uhid_event *ev)
+{
+	struct uhid_create_req orig;
+
+	orig = ev->u.create;
+
+	if (orig.rd_size <= 0 || orig.rd_size > HID_MAX_DESCRIPTOR_SIZE)
+		return -EINVAL;
+	if (copy_from_user(&ev->u.create2.rd_data, orig.rd_data, orig.rd_size))
+		return -EFAULT;
+
+	memcpy(ev->u.create2.name, orig.name, sizeof(orig.name));
+	memcpy(ev->u.create2.phys, orig.phys, sizeof(orig.phys));
+	memcpy(ev->u.create2.uniq, orig.uniq, sizeof(orig.uniq));
+	ev->u.create2.rd_size = orig.rd_size;
+	ev->u.create2.bus = orig.bus;
+	ev->u.create2.vendor = orig.vendor;
+	ev->u.create2.product = orig.product;
+	ev->u.create2.version = orig.version;
+	ev->u.create2.country = orig.country;
+
+	return uhid_dev_create2(uhid, ev);
+}
+
 static int uhid_dev_destroy(struct uhid_device *uhid)
 {
 	if (!uhid->running)
-- 
2.0.3

