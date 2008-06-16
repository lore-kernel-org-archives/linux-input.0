From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] input: make mainstone-wm97xx.c depend on MACH_MAINSTONE instead
 of ARCH_PXA
Date: Mon, 16 Jun 2008 18:32:19 +0800
Message-ID: <48564133.3070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:35179 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYFPKcZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jun 2008 06:32:25 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1590048tic.23
        for <linux-input@vger.kernel.org>; Mon, 16 Jun 2008 03:32:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

If this is totally mainstone specific.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 565ec71..17d0623 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -228,7 +228,7 @@ config TOUCHSCREEN_WM9713
 
 config TOUCHSCREEN_WM97XX_MAINSTONE
 	tristate "WM97xx Mainstone accelerated touch"
-	depends on TOUCHSCREEN_WM97XX && ARCH_PXA
+	depends on TOUCHSCREEN_WM97XX && MACH_MAINSTONE
 	help
 	  Say Y here for support for streaming mode with WM97xx touchscreens
 	  on Mainstone systems.
-- 
1.5.4.3

