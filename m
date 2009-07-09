From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] input: Add depends on support for w90p910 ts.
Date: Thu, 09 Jul 2009 22:44:31 +0800
Message-ID: <4A56024F.4060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:55258 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761352AbZGIOoh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 10:44:37 -0400
Received: by pzk5 with SMTP id 5so147310pzk.33
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 07:44:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Dear Dmitry,

Add depends on support for w90p910 ts.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/input/touchscreen/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 72e2712..2dc8fe6 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -492,6 +492,7 @@ config TOUCHSCREEN_TSC2007
 
 config TOUCHSCREEN_W90X900
 	tristate "W90P910 touchscreen driver"
+	depends on ARCH_W90X900
 	help
 	  Say Y here if you have a W90P910 based touchscreen.
 
-- 
1.5.6.3
