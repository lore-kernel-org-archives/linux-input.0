From: riyer@nvidia.com
Subject: [PATCH v1] input: tegra-kbc: Fix build error.
Date: Fri, 28 Jan 2011 14:03:33 -0800
Message-ID: <1296252213-15003-1-git-send-email-riyer@nvidia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10825 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab1A1WBq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 17:01:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: olof@lixom.net, achew@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Rakesh Iyer <riyer@nvidia.com>

From: Rakesh Iyer <riyer@nvidia.com>

Fix build error introduced by variable name change.

Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
---
 drivers/input/keyboard/tegra-kbc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 6ca903a..ac471b7 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -355,8 +355,8 @@ static void tegra_kbc_config_pins(struct tegra_kbc *kbc)
 	for (i = 0; i < KBC_MAX_GPIO; i++) {
 		u32 r_shft = 5 * (i % 6);
 		u32 c_shft = 4 * (i % 8);
-		u32 r_mask = 0x1f << r_shift;
-		u32 c_mask = 0x0f << c_shift;
+		u32 r_mask = 0x1f << r_shft;
+		u32 c_mask = 0x0f << c_shft;
 		u32 r_offs = (i / 6) * 4 + KBC_ROW_CFG0_0;
 		u32 c_offs = (i / 8) * 4 + KBC_COL_CFG0_0;
 		u32 row_cfg = readl(kbc->mmio + r_offs);
-- 
1.7.0.4

