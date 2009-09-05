From: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Subject: [PATCH 02/03] [INPUT][KEYBOARD] Makefile support for s3c matrix keypad
Date: Sat, 05 Sep 2009 22:54:44 +0900
Message-ID: <00af01ca2e30$6c647030$452d5090$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:36579 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbZIEOCK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 10:02:10 -0400
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPI00JL23UYTI@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Sat, 05 Sep 2009 22:52:11 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPI008P23UY1A@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Sat, 05 Sep 2009 22:52:10 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: laforge@gnumonks.org, ben-linux@fluff.org, =?UTF-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv?= =?UTF-8?B?7IK87ISx7KCE7J6Q?= <ki0351.kim@samsung.com>, =?UTF-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQp?= =?UTF-8?B?L+yCvOyEseyghOyekCc=?= <kgene.kim@samsung.com>

This patch supports to compile of s3c matrix keypad driver.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 drivers/input/keyboard/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index b5b5eae..21331b8 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_TOSA)		+= tosakbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
+obj-$(CONFIG_KEYBOARD_S3C)		+= s3c-keypad.o
-- 
1.6.2.5

