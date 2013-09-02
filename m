From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: move HID_REPORT_TYPES closer to the report-definitions
Date: Mon,  2 Sep 2013 14:00:05 +0200
Message-ID: <1378123205-4032-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:53043 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab3IBMAX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Sep 2013 08:00:23 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so2319409eek.14
        for <linux-input@vger.kernel.org>; Mon, 02 Sep 2013 05:00:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

HID_REPORT_TYPES defines the number of available report-types. Move it
closer to the actualy definition of the report-types so we can see the
relation more clearly (and hopefully will never forget to update it).

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/linux/hid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 650dc29..383b9d6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -252,6 +252,8 @@ struct hid_item {
 #define HID_OUTPUT_REPORT	1
 #define HID_FEATURE_REPORT	2
 
+#define HID_REPORT_TYPES	3
+
 /*
  * HID connect requests
  */
@@ -401,8 +403,6 @@ struct hid_report_enum {
 	struct hid_report *report_id_hash[256];
 };
 
-#define HID_REPORT_TYPES 3
-
 #define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a packet size of space */
 #define HID_MAX_BUFFER_SIZE	4096		/* 4kb */
 #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
-- 
1.8.4

