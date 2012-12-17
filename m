From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] HID: uhid: use __packed__ for uhid_feature_answer_req
Date: Mon, 17 Dec 2012 13:20:43 +0100
Message-ID: <1355746843-14015-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53629 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2LQMUR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Dec 2012 07:20:17 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so2678574wey.19
        for <linux-input@vger.kernel.org>; Mon, 17 Dec 2012 04:20:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>

We use __packed__ for all API structures so we can extend them without
breaking alignment rules. We do try to explicitly align the structures,
but to be safe we also use __packed__.
uhid_feature_answer_req is already 64bit aligned so we can add __packed__
without breaking ABI.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/uapi/linux/uhid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index 9c6974f..e9ed951 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -86,7 +86,7 @@ struct uhid_feature_answer_req {
 	__u16 err;
 	__u16 size;
 	__u8 data[UHID_DATA_MAX];
-};
+} __attribute__((__packed__));
 
 struct uhid_event {
 	__u32 type;
-- 
1.8.0.2

