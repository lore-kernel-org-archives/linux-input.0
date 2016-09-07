From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 3/4] Input: jornada720_kbd - remove unneeded mach/hardware.h
 include
Date: Wed, 07 Sep 2016 10:51:14 +0100
Message-ID: <E1bhZVi-0005cf-AK@rmk-PC.armlinux.org.uk>
References: <20160907095029.GL1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52467 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbcIGJvR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 05:51:17 -0400
In-Reply-To: <20160907095029.GL1041@n2100.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

The Jornada720 keyboard driver does not make use of anything from the
mach/hardware.h header, so this header can be removed.

Tested-by: Adam Wysocki <armlinux@chmurka.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/input/keyboard/jornada720_kbd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 6ac9fee1d8fa..3d29e5e392c2 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 
 #include <mach/jornada720.h>
-#include <mach/hardware.h>
 
 MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
 MODULE_DESCRIPTION("HP Jornada 710/720/728 keyboard driver");
-- 
2.1.0

