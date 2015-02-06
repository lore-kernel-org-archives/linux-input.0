From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] blackfin: convert pinmux request API into empty static inline functions for bf609 and bf548
Date: Fri, 6 Feb 2015 17:41:39 +0800
Message-ID: <1423215699-11153-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:29682
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750853AbbBFJnv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 04:43:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 arch/blackfin/include/asm/portmux.h |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/blackfin/include/asm/portmux.h b/arch/blackfin/include/asm/portmux.h
index ccb96ca..2f6893e 100644
--- a/arch/blackfin/include/asm/portmux.h
+++ b/arch/blackfin/include/asm/portmux.h
@@ -23,10 +23,17 @@ int bfin_internal_set_wake(unsigned int irq, unsigned int state);
 #define gpio_pint_regs bfin_pint_regs
 #define adi_internal_set_wake bfin_internal_set_wake
 
-#define peripheral_request(per, label) (0)
-#define peripheral_free(per)
-#define peripheral_request_list(per, label) (0)
-#define peripheral_free_list(per)
+static inline int peripheral_request(unsigned short per, const char *label)
+{
+	return 0;
+}
+static inline void peripheral_free(unsigned short per) {}
+static inline int peripheral_request_list(const unsigned short per[],
+					  const char *label)
+{
+	return 0;
+}
+static inline void peripheral_free_list(const unsigned short per[]) {}
 int pinmux_request(unsigned short per, const char *label);
 void pinmux_free(unsigned short per);
 int pinmux_request_list(const unsigned short per[], const char *label);
-- 
1.7.9.5

