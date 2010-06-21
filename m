From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 3/4] ARM: S5PC100: Rename keypad clock for S5PC100.
Date: Tue, 22 Jun 2010 08:43:54 +0900
Message-ID: <1277163835-12439-4-git-send-email-kgene.kim@samsung.com>
References: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:39695 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab0FUXuy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 19:50:54 -0400
In-Reply-To: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org
Cc: ben-linux@fluff.org, dmitry.torokhov@gmail.com, Naveen Krishna Ch <ch.naveen@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch renames the keypad clock for S5PC100 from keyif to keypad.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index e3fed4c..e1136f4 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -737,7 +737,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
-		.name		= "keyif",
+		.name		= "keypad",
 		.id		= -1,
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_5_ctrl,
-- 
1.6.2.5

