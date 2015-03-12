From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 22/22] arm: mach-pxa: Decrement the power supply's
 device reference counter
Date: Thu, 12 Mar 2015 08:44:20 +0100
Message-ID: <1426146260-30081-23-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:8801 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbbCLHpL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 03:45:11 -0400
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Use power_supply_put() to decrement the power supply's device reference
counter.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-pxa/raumfeld.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index a762b23ac830..6dc4f025e674 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -758,8 +758,10 @@ static void raumfeld_power_signal_charged(void)
 	struct power_supply *psy =
 		power_supply_get_by_name(raumfeld_power_supplicants[0]);
 
-	if (psy)
+	if (psy) {
 		power_supply_set_battery_charged(psy);
+		power_supply_put(psy);
+	}
 }
 
 static int raumfeld_power_resume(void)
-- 
1.9.1

