From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/4] Input: htcpen - Remove redundant dev_set_drvdata
Date: Fri,  6 Sep 2013 23:38:07 +0530
Message-ID: <1378490888-5083-3-git-send-email-sachin.kamat@linaro.org>
References: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34397 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab3IFSI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 14:08:27 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so3531608pbc.17
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 11:08:27 -0700 (PDT)
In-Reply-To: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Pau Oliva Fora <pof@eslack.org>

Driver core sets the data to NULL upon release or probe
failure. Hence explicit setting is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Pau Oliva Fora <pof@eslack.org>
---
 drivers/input/touchscreen/htcpen.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index 6650085..92e2243 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -186,8 +186,6 @@ static int htcpen_isa_remove(struct device *dev, unsigned int id)
 	release_region(HTCPEN_PORT_INIT, 1);
 	release_region(HTCPEN_PORT_IRQ_CLEAR, 1);
 
-	dev_set_drvdata(dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.4.1

