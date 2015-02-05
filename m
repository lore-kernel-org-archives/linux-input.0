From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] bfin: check if an empty array pointer is passed to pinmux request API
Date: Thu, 5 Feb 2015 13:33:54 +0800
Message-ID: <1423114434-10063-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0095.outbound.protection.outlook.com ([207.46.100.95]:22508
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750734AbbBEFgt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Feb 2015 00:36:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

to avoid possible indigestion

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 arch/blackfin/kernel/bfin_gpio.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/blackfin/kernel/bfin_gpio.c b/arch/blackfin/kernel/bfin_gpio.c
index a017359..153841f 100644
--- a/arch/blackfin/kernel/bfin_gpio.c
+++ b/arch/blackfin/kernel/bfin_gpio.c
@@ -730,6 +730,8 @@ int peripheral_request_list(const unsigned short per[], const char *label)
 	u16 cnt;
 	int ret;
 
+	if (per == NULL)
+		return -ENODEV;
 	for (cnt = 0; per[cnt] != 0; cnt++) {
 
 		ret = peripheral_request(per[cnt], label);
@@ -778,6 +780,8 @@ EXPORT_SYMBOL(peripheral_free);
 void peripheral_free_list(const unsigned short per[])
 {
 	u16 cnt;
+	if (per == NULL)
+		return;
 	for (cnt = 0; per[cnt] != 0; cnt++)
 		peripheral_free(per[cnt]);
 }
-- 
1.7.9.5

