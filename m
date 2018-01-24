From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] input/rmi4: Delete an error message for a failed memory
 allocation in two functions
Date: Wed, 24 Jan 2018 19:28:44 +0100
Message-ID: <423a3ec4-eef2-f663-d6b8-9ec9d31ddfc2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:57532 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964850AbeAXSdj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 13:33:39 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Wei Yongjun <weiyongjun1@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 19:19:14 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/rmi4/rmi_driver.c | 4 +---
 drivers/input/rmi4/rmi_f30.c    | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 4f2bb5947a4e..6c47e4f3ca7e 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1060,10 +1060,8 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 
 	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
 	data->irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
-	if (!data->irq_memory) {
-		dev_err(dev, "Failed to allocate memory for irq masks.\n");
+	if (!data->irq_memory)
 		return -ENOMEM;
-	}
 
 	data->irq_status	= data->irq_memory + size * 0;
 	data->fn_irq_bits	= data->irq_memory + size * 1;
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index 82e0f0d43d55..a111ea370c30 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -238,10 +238,8 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
 					    button_count,
 					    sizeof(f30->gpioled_key_map[0]),
 					    GFP_KERNEL);
-	if (!f30->gpioled_key_map) {
-		dev_err(&fn->dev, "Failed to allocate gpioled map memory.\n");
+	if (!f30->gpioled_key_map)
 		return -ENOMEM;
-	}
 
 	for (i = 0; i < button_count; i++) {
 		if (!rmi_f30_is_valid_button(i, f30->ctrl))
-- 
2.16.1

