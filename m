From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 1/7] davinci: define tnetv107x keypad platform data
Date: Mon, 13 Sep 2010 12:29:42 -0400
Message-ID: <1284395388-32687-2-git-send-email-cyril@ti.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56516 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab0IMQ3w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:29:52 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8DGTq4t006436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 11:29:52 -0500
In-Reply-To: <1284395388-32687-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Cyril Chemparathy <cyril@ti.com>

This patch adds a definition for the platform data structure needed to
configure the keypad controller on tnetv107x socs.

Since this controller is (so far) present only on tnetv107x devices, the data
structure definition has been kept local to tnetv107x.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/include/mach/tnetv107x.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index c720647..1ee3035 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -37,6 +37,16 @@
 #include <mach/nand.h>
 #include <mach/serial.h>
 
+struct tnetv107x_keypad_data {
+	int		*keymap;
+	const char	**keynames;
+	int		keymap_size;
+	int		rows;
+	int		cols;
+	u32		debounce;
+	u32		stable;
+};
+
 struct tnetv107x_device_info {
 	struct davinci_uart_config	*serial_config;
 	struct davinci_mmc_config	*mmc_config[2];  /* 2 controllers */
-- 
1.7.0.4

