From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: omap-keypad: fix memory leak
Date: Fri, 18 Sep 2015 16:54:40 +0530
Message-ID: <1442575480-336-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

If omap4_keypad_parse_dt() fails we returned the error code but we
missed releasing keypad_data.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/keyboard/omap4-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index b052afe..6639b2b 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -266,7 +266,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 
 	error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
 	if (error)
-		return error;
+		goto err_free_keypad;
 
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (!res) {
-- 
1.9.1
