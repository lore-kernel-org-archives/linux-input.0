From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 04/11 linux-next] input: remove unnecessary version.h inclusion
Date: Mon, 29 Dec 2014 15:29:38 +0100
Message-ID: <1419863387-24233-5-git-send-email-fabf@skynet.be>
References: <1419863387-24233-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419863387-24233-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Based on versioncheck.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/input/touchscreen/elants_i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index a510f7e..926c58e 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -33,10 +33,8 @@
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/buffer_head.h>
-#include <linux/version.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
-#include <linux/version.h>
 #include <linux/input/mt.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
-- 
2.1.0
