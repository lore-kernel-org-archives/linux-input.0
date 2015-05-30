From: Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH 1/2] Export hid_field_extract()
Date: Sat, 30 May 2015 11:00:26 +0200
Message-ID: <1432976427-12013-2-git-send-email-kreijack@libero.it>
References: <1432976427-12013-1-git-send-email-kreijack@libero.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-36.italiaonline.it ([212.48.25.164]:59621 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751192AbbE3JAj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 May 2015 05:00:39 -0400
In-Reply-To: <1432976427-12013-1-git-send-email-kreijack@libero.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, linux-input@vger.kernel.org, Goffredo Baroncelli <kreijack@inwind.it>

From: Goffredo Baroncelli <kreijack@inwind.it>

Rename the function extract() to hid_field_extract(), make it external linkage
to allow the use from other modules.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 drivers/hid/hid-core.c | 11 ++++++-----
 include/linux/hid.h    |  2 ++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..fe33f9e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1061,13 +1061,13 @@ static u32 s32ton(__s32 value, unsigned n)
  * Search linux-kernel and linux-usb-devel archives for "hid-core extract".
  */
 
-static __u32 extract(const struct hid_device *hid, __u8 *report,
+__u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
 		     unsigned offset, unsigned n)
 {
 	u64 x;
 
 	if (n > 32)
-		hid_warn(hid, "extract() called with n (%d) > 32! (%s)\n",
+		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
 			 n, current->comm);
 
 	report += offset >> 3;  /* adjust byte index */
@@ -1076,6 +1076,7 @@ static __u32 extract(const struct hid_device *hid, __u8 *report,
 	x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
 	return (u32) x;
 }
+EXPORT_SYMBOL_GPL(hid_field_extract);
 
 /*
  * "implement" : set bits in a little endian bit stream.
@@ -1221,9 +1222,9 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 	for (n = 0; n < count; n++) {
 
 		value[n] = min < 0 ?
-			snto32(extract(hid, data, offset + n * size, size),
-			       size) :
-			extract(hid, data, offset + n * size, size);
+			snto32(hid_field_extract(hid, data, offset + n * size,
+			       size), size) :
+			hid_field_extract(hid, data, offset + n * size, size);
 
 		/* Ignore report if ErrorRollOver */
 		if (!(field->flags & HID_MAIN_ITEM_VARIABLE) &&
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 176b436..f17980d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -815,6 +815,8 @@ void hid_disconnect(struct hid_device *hid);
 const struct hid_device_id *hid_match_id(struct hid_device *hdev,
 					 const struct hid_device_id *id);
 s32 hid_snto32(__u32 value, unsigned n);
+__u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
+		     unsigned offset, unsigned n);
 
 /**
  * hid_device_io_start - enable HID input during probe, remove
-- 
2.1.4

