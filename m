From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] Input: twl4030-pwrbutton: Use input_set_capability() helper
Date: Fri, 28 Apr 2017 14:28:55 +0200
Message-ID: <20170428122855.3185-2-sebastian.reichel@collabora.co.uk>
References: <20170428122855.3185-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52199 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423072AbdD1M3U (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 08:29:20 -0400
In-Reply-To: <20170428122855.3185-1-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Cleanup driver slightly by using input_set_capability() instead
of manually setting the required bits.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/input/misc/twl4030-pwrbutton.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 7c4504c31b07..1c13005b228f 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -64,8 +64,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	pwr->evbit[0] = BIT_MASK(EV_KEY);
-	pwr->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
+	input_set_capability(pwr, EV_KEY, KEY_POWER);
 	pwr->name = "twl4030_pwrbutton";
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
-- 
2.11.0

