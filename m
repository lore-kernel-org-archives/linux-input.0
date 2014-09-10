From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] HID: wacom - Add default permission defines for sysfs attributes
Date: Wed, 10 Sep 2014 11:40:04 -0700
Message-ID: <1410374404-25832-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43193 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbaIJSkO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 14:40:14 -0400
Received: by mail-pd0-f172.google.com with SMTP id v10so12879643pde.3
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 11:40:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: killertofu@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, "Paul A. Tessier" <phernost@gmail.com>

RW : ug=rw,o=r
WO : ug=w

Signed-off-by: Paul A. Tessier <phernost@gmail.com>
Signed-Off-by: Ping Cheng <pingc@wacom.com>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f0db7ec..2ce102b 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -23,6 +23,9 @@
 #define WAC_CMD_ICON_BT_XFER	0x26
 #define WAC_CMD_RETRIES		10
 
+#define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
+#define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
+
 static int wacom_get_report(struct hid_device *hdev, u8 type, u8 id,
 			    void *buf, size_t size, unsigned int retries)
 {
-- 
1.9.1

