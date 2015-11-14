From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] HID: core: use scnprintf in modalias_show()
Date: Sat, 14 Nov 2015 22:08:08 +0100
Message-ID: <1447535288-12523-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33896 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbKNVIT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Nov 2015 16:08:19 -0500
Received: by lffu14 with SMTP id u14so69138350lff.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2015 13:08:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

scnprintf() exists to provide these semantics, so we might as well use
it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hid/hid-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a694f67a..efa3660e23a0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2223,12 +2223,9 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 			     char *buf)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	int len;
-
-	len = snprintf(buf, PAGE_SIZE, "hid:b%04Xg%04Xv%08Xp%08X\n",
-		       hdev->bus, hdev->group, hdev->vendor, hdev->product);
 
-	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+	return scnprintf(buf, PAGE_SIZE, "hid:b%04Xg%04Xv%08Xp%08X\n",
+			 hdev->bus, hdev->group, hdev->vendor, hdev->product);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.6.1

