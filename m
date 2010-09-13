From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 7/7] davinci: add touchscreen config for tnetv107x evm board
Date: Mon, 13 Sep 2010 12:29:48 -0400
Message-ID: <1284395388-32687-8-git-send-email-cyril@ti.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab0IMQ3y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:29:54 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8DGTrf9001294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 11:29:53 -0500
In-Reply-To: <1284395388-32687-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Cyril Chemparathy <cyril@ti.com>

This patch adds evm board specific definitions (dimensions, default
calibration, etc.) for the on-chip keypad controller on tnetv107x silicon.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 2fe7a3f..287c5ee 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -182,11 +182,20 @@ static struct tnetv107x_keypad_data keypad_config = {
 	.stable		= 0x3,
 };
 
+static struct tnetv107x_tsc_data tsc_config = {
+	.xres	= 800,
+	.yres	= 480,
+	.calibration_data = {
+		217, 14019, -2540712, 8690, -140, -1651470, 65536,
+	},
+};
+
 static struct tnetv107x_device_info evm_device_info __initconst = {
 	.serial_config		= &serial_config,
 	.mmc_config[1]		= &mmc_config,	/* controller 1 */
 	.nand_config[0]		= &nand_config,	/* chip select 0 */
 	.keypad_config		= &keypad_config,
+	.tsc_config		= &tsc_config,
 };
 
 static __init void tnetv107x_evm_board_init(void)
-- 
1.7.0.4

