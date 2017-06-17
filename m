From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Input: soc_button_array - Fix leaking the ACPI button descriptor buffer
Date: Sat, 17 Jun 2017 12:57:13 +0200
Message-ID: <20170617105713.16164-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbdFQK5Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 06:57:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

We are passing a buffer with ACPI_ALLOCATE_BUFFER set to
acpi_evaluate_object, so we must free it when we are done with it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index e37d37273182..f600f3a7a3c6 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -248,7 +248,8 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 
 	if (!btns_desc) {
 		dev_err(dev, "ACPI Button Descriptors not found\n");
-		return ERR_PTR(-ENODEV);
+		button_info = ERR_PTR(-ENODEV);
+		goto out;
 	}
 
 	/* The first package describes the collection */
@@ -264,24 +265,31 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 	}
 	if (collection_uid == -1) {
 		dev_err(dev, "Invalid Button Collection Descriptor\n");
-		return ERR_PTR(-ENODEV);
+		button_info = ERR_PTR(-ENODEV);
+		goto out;
 	}
 
 	/* There are package.count - 1 buttons + 1 terminating empty entry */
 	button_info = devm_kcalloc(dev, btns_desc->package.count,
 				   sizeof(*button_info), GFP_KERNEL);
-	if (!button_info)
-		return ERR_PTR(-ENOMEM);
+	if (!button_info) {
+		button_info = ERR_PTR(-ENOMEM);
+		goto out;
+	}
 
 	/* Parse the button descriptors */
 	for (i = 1, btn = 0; i < btns_desc->package.count; i++, btn++) {
 		if (soc_button_parse_btn_desc(dev,
 					      &btns_desc->package.elements[i],
 					      collection_uid,
-					      &button_info[btn]))
-			return ERR_PTR(-ENODEV);
+					      &button_info[btn])) {
+			button_info = ERR_PTR(-ENODEV);
+			goto out;
+		}
 	}
 
+out:
+	kfree(buf.pointer);
 	return button_info;
 }
 
-- 
2.13.0

