From: Dan Carpenter <error27@gmail.com>
Subject: [patch 1/2 -next] hid-lg4ff: silence sparse complaint
Date: Thu, 18 Aug 2011 16:42:26 +0300
Message-ID: <20110818134226.GA21927@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53239 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1HRNp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 09:45:28 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

Sparse complains that:
drivers/hid/hid-lg4ff.c:288:44: warning: Using plain integer as NULL pointer
drivers/hid/hid-lg4ff.c:311:44: warning: Using plain integer as NULL pointer

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index dc38c2d..2d8762d 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -285,7 +285,7 @@ static void hid_lg4ff_switch_native(struct hid_device *hid, const struct lg4ff_n
 /* Read current range and display it in terminal */
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct lg4ff_device_entry *entry = 0;
+	struct lg4ff_device_entry *uninitialized_var(entry);
 	struct list_head *h;
 	struct hid_device *hid = to_hid_device(dev);
 	size_t count;
@@ -308,7 +308,7 @@ static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *att
  * according to the type of the wheel */
 static ssize_t lg4ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct lg4ff_device_entry *entry = 0;
+	struct lg4ff_device_entry *uninitialized_var(entry);
 	struct list_head *h;
 	struct hid_device *hid = to_hid_device(dev);
 	__u16 range = simple_strtoul(buf, NULL, 10);
