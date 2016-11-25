From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 2/2] Input - soc_button_array: bail out earlier if gpiod_count is null
Date: Fri, 25 Nov 2016 17:36:42 +0100
Message-ID: <1480091802-14482-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1480091802-14482-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932810AbcKYQgs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 11:36:48 -0500
In-Reply-To: <1480091802-14482-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The PNP0C40 device of the Surface 3 doesn't have any GPIO attached to it.
Instead of trying to access the GPIO, request the count beforehand and
bail out if it is null or if an error is returned.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

no changes in v3

changes in v2:
- hunk moved down for better integration with later patches
---
 drivers/input/misc/soc_button_array.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index bbd433c..5467d04 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -167,6 +167,11 @@ static int soc_button_probe(struct platform_device *pdev)
 
 	button_info = (struct soc_button_info *)id->driver_data;
 
+	if (gpiod_count(&pdev->dev, KBUILD_MODNAME) <= 0) {
+		dev_info(&pdev->dev, "no GPIO attached, ignoring...\n");
+		return -ENODEV;
+	}
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.7.4

