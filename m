From: riyer@nvidia.com
Subject: [PATCH v1] Input: tegra-kbc - Fix support for key repeat.
Date: Fri, 22 Jul 2011 12:17:51 -0700
Message-ID: <1311362271-10544-1-git-send-email-riyer@nvidia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:9682 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab1GVTRQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 15:17:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, olof@lixom.net, amartin@nvidia.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Rakesh Iyer <riyer@nvidia.com>

From: Rakesh Iyer <riyer@nvidia.com>

To support key repeats, keyboard needs to be setup as an autorepeating device.

Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
---
 drivers/input/keyboard/tegra-kbc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 2b3b73e..da3828f 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -657,7 +657,7 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 
 	input_set_drvdata(input_dev, kbc);
 
-	input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
 	input_dev->keycode = kbc->keycode;
-- 
1.7.1

