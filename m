From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-sony: Delete an error message for a failed memory
 allocation in two functions
Date: Fri, 2 Feb 2018 22:12:16 +0100
Message-ID: <75be18ab-f4b2-89b9-6283-ec80b45f6384@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:61339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeBBVMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Feb 2018 16:12:25 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 22:08:31 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-sony.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b9dc3ac4d4aa..dc22f40c2ea2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1930,7 +1930,6 @@ static int sony_leds_init(struct sony_sc *sc)
 
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
 		if (!led) {
-			hid_err(hdev, "Couldn't allocate memory for LED %d\n", n);
 			ret = -ENOMEM;
 			goto error_leds;
 		}
@@ -2722,10 +2721,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		quirks |= FUTUREMAX_DANCE_MAT;
 
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
-	if (sc == NULL) {
-		hid_err(hdev, "can't alloc sony descriptor\n");
+	if (!sc)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&sc->lock);
 
-- 
2.16.1

