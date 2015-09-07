From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] input: keyboard: use of_property_read_bool()
Date: Mon,  7 Sep 2015 15:00:28 +0800
Message-ID: <1441609228-4787-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:43322 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbIGHCV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2015 03:02:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Use more compact of_property_read_bool() calls instead of the
of_find_property() calls.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/input/keyboard/tegra-kbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index f97c73b..a08825d 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -514,10 +514,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	if (!of_property_read_u32(np, "nvidia,repeat-delay-ms", &prop))
 		kbc->repeat_cnt = prop;
 
-	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
+	if (of_property_read_bool(np, "nvidia,needs-ghost-filter"))
 		kbc->use_ghost_filter = true;
 
-	if (of_find_property(np, "nvidia,wakeup-source", NULL))
+	if (of_property_read_bool(np, "nvidia,wakeup-source"))
 		kbc->wakeup = true;
 
 	if (!of_get_property(np, "nvidia,kbc-row-pins", &proplen)) {
-- 
2.3.7


