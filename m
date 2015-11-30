From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: arizona-haptic: Correct disable of haptics device
Date: Mon, 30 Nov 2015 18:02:20 +0000
Message-ID: <1448906540-15356-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35516 "EHLO
	mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753327AbbK3SCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 13:02:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com

A small copy and paste error was preventing the haptics device being
disabled. This patch corrects the value written on disable.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/input/misc/arizona-haptics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 4bf6785..d5994a7 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -97,8 +97,7 @@ static void arizona_haptics_work(struct work_struct *work)
 
 		ret = regmap_update_bits(arizona->regmap,
 					 ARIZONA_HAPTICS_CONTROL_1,
-					 ARIZONA_HAP_CTRL_MASK,
-					 1 << ARIZONA_HAP_CTRL_SHIFT);
+					 ARIZONA_HAP_CTRL_MASK, 0);
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to stop haptics: %d\n",
 				ret);
-- 
2.1.4

