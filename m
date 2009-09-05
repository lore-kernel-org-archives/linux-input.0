From: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Subject: [PATCH 01/03] [INPUT][KEYBOARD] Kconfig support for s3c matrix keypad
Date: Sat, 05 Sep 2009 22:54:44 +0900
Message-ID: <00b001ca2e30$6c79ccf0$456d66d0$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:36579 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZIEOCL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 10:02:11 -0400
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPI00JL23UYTI@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Sat, 05 Sep 2009 22:52:11 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPI008P23UY1A@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Sat, 05 Sep 2009 22:52:11 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: laforge@gnumonks.org, ben-linux@fluff.org, =?UTF-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv?= =?UTF-8?B?7IK87ISx7KCE7J6Q?= <ki0351.kim@samsung.com>, =?UTF-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQp?= =?UTF-8?B?L+yCvOyEseyghOyekCc=?= <kgene.kim@samsung.com>

This patch supports to select configuration for s3c matrix keypad.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 drivers/input/keyboard/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a6b989a..4a04553 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -361,4 +361,10 @@ config KEYBOARD_XTKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called xtkbd.
 
+config KEYBOARD_S3C
+	tristate "Samsung S3C keypad support"
+	depends on PLAT_S3C
+	help
+	  Enable support for Samsung S3C keypad interface.
+
 endif
-- 
1.6.2.5

