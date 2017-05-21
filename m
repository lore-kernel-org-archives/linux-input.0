From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 1/3] mfd: dm355evm_msp: move header file out of
 I2C realm
Date: Mon, 22 May 2017 00:02:08 +0200
Message-ID: <20170521220212.1404-2-wsa@the-dreams.de>
References: <20170521220212.1404-1-wsa@the-dreams.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <rtc-linux+bncBDP47C6LHEIOZHEIZECRUBFUFGPZ2-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170521220212.1404-1-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/input/misc/dm355evm_keys.c        | 2 +-
 drivers/mfd/dm355evm_msp.c                | 2 +-
 drivers/rtc/rtc-dm355evm.c                | 2 +-
 include/linux/{i2c => mfd}/dm355evm_msp.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)

diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index bab256ef32b9b3..c803db64a3760d 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 
-#include <linux/i2c/dm355evm_msp.h>
+#include <linux/mfd/dm355evm_msp.h>
 #include <linux/module.h>
 
 
diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 86eca614507bd8..2a2756709f22f0 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -18,7 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-#include <linux/i2c/dm355evm_msp.h>
+#include <linux/mfd/dm355evm_msp.h>
 
 
 /*
diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index f225cd873ff6c2..97d8259b94940f 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -13,7 +13,7 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/dm355evm_msp.h>
+#include <linux/mfd/dm355evm_msp.h>
 #include <linux/module.h>
 
 
diff --git a/include/linux/i2c/dm355evm_msp.h b/include/linux/mfd/dm355evm_msp.h
similarity index 100%
rename from include/linux/i2c/dm355evm_msp.h
rename to include/linux/mfd/dm355evm_msp.h
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
