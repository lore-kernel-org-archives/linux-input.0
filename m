From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 06/19] input: tegra-kbc: enable support for the standard "wakeup-source" property
Date: Wed, 21 Oct 2015 11:10:03 +0100
Message-ID: <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59950 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932550AbbJUKKs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 06:10:48 -0400
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org

Though the mmc core driver should/will continue to support the legacy
"nvidia,wakeup-source" property to enable SDIO as the wakeup source, we
need to add support for the new standard property "wakeup-source".

This patch adds support for "wakeup-source" property in addition to the
existing "nvidia,wakeup-source" property.

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/input/keyboard/tegra-kbc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index f97c73bd14f8..f80c72d4ac8f 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -517,7 +517,8 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
 		kbc->use_ghost_filter = true;
 
-	if (of_find_property(np, "nvidia,wakeup-source", NULL))
+	if (of_property_read_bool(np, "wakeup-source") ||
+	    of_property_read_bool(np, "nvidia,wakeup-source")) /* legacy */
 		kbc->wakeup = true;
 
 	if (!of_get_property(np, "nvidia,kbc-row-pins", &proplen)) {
-- 
1.9.1

