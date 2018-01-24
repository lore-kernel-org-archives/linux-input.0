From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: wm831x-on: Delete an error message for a failed
 memory allocation in wm831x_on_probe()
Date: Wed, 24 Jan 2018 22:21:39 +0100
Message-ID: <d393999d-0c39-c9ea-3a0c-eb534e61b665@users.sourceforge.net>
References: <e307cfde-58e2-3f4d-ecd7-5c80ace0bb5b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:62657 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932238AbeAXVVr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 16:21:47 -0500
In-Reply-To: <e307cfde-58e2-3f4d-ecd7-5c80ace0bb5b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, patches@opensource.cirrus.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 21:55:49 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/wm831x-on.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 1b44de265a0a..06f5c4857a0c 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -77,10 +77,8 @@ static int wm831x_on_probe(struct platform_device *pdev)
 
 	wm831x_on = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_on),
 				 GFP_KERNEL);
-	if (!wm831x_on) {
-		dev_err(&pdev->dev, "Can't allocate data\n");
+	if (!wm831x_on)
 		return -ENOMEM;
-	}
 
 	wm831x_on->wm831x = wm831x;
 	INIT_DELAYED_WORK(&wm831x_on->work, wm831x_poll_on);
-- 
2.16.1

