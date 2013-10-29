From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 04/19] input: sh_keysc: Enable the driver on all ARM platforms
Date: Tue, 29 Oct 2013 23:37:39 +0100
Message-ID: <1383086274-11049-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38736 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab3J2Whg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Oct 2013 18:37:36 -0400
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index c1edd39..28d75c7 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -525,7 +525,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH || ARCH_SHMOBILE
+	depends on SUPERH || ARM || COMPILE_TEST
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
-- 
1.8.1.5

