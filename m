From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: arizona-haptic - Don't assign input_dev parent
Date: Fri, 15 Apr 2016 13:15:49 +0100
Message-ID: <1460722549-31804-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:45542 "EHLO
	mx0a-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232AbcDOMPn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Apr 2016 08:15:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

We shouldn't assign the parent device of the input_dev to be the
parent MFD device, because this will be used for devres which causes
input_unregister_device to run after the haptics device has been
removed, since it is itself a child of the MFD device. The default
of using the haptics device itself as the parent is correct.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/input/misc/arizona-haptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index d5994a7..9829363 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -178,7 +178,6 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 	input_set_drvdata(haptics->input_dev, haptics);
 
 	haptics->input_dev->name = "arizona:haptics";
-	haptics->input_dev->dev.parent = pdev->dev.parent;
 	haptics->input_dev->close = arizona_haptics_close;
 	__set_bit(FF_RUMBLE, haptics->input_dev->ffbit);
 
-- 
2.1.4

