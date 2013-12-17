From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [PATCH] input: Port rotary_encoder to of_property_read_bool
Date: Mon, 16 Dec 2013 19:10:38 -0500
Message-ID: <1387239038-19089-1-git-send-email-bgamari.foss@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:44018 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab3LQAKn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 19:10:43 -0500
Received: by mail-qa0-f49.google.com with SMTP id ii20so2084549qab.15
        for <linux-input@vger.kernel.org>; Mon, 16 Dec 2013 16:10:43 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <bgamari.foss@gmail.com>

---
 drivers/input/misc/rotary_encoder.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f920ba7..52049db 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -175,12 +175,9 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
 	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
 
-	pdata->relative_axis = !!of_get_property(np,
-					"rotary-encoder,relative-axis", NULL);
-	pdata->rollover = !!of_get_property(np,
-					"rotary-encoder,rollover", NULL);
-	pdata->half_period = !!of_get_property(np,
-					"rotary-encoder,half-period", NULL);
+	pdata->relative_axis = of_property_read_bool(np, "rotary-encoder,relative-axis");
+	pdata->rollover = of_property_read_bool(np, "rotary-encoder,rollover");
+	pdata->half_period = of_property_read_bool(np, "rotary-encoder,half-period");
 
 	return pdata;
 }
-- 
1.8.3.2

