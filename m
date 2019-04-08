From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH 2/6] MIPS: SGI-IP27: remove setup of RTC platform device
Date: Mon,  8 Apr 2019 16:20:54 +0200
Message-ID: <20190408142100.27618-3-tbogendoerfer@suse.de>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408142100.27618-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

RTC platform device will be setup by new IOC3 MFD driver, therefore
remove it from IP27 platform code.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-timer.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 9b4b9ac621a3..5631e93ea350 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -188,23 +188,3 @@ void hub_rtc_init(cnodeid_t cnode)
 		LOCAL_HUB_S(PI_RT_PEND_B, 0);
 	}
 }
-
-static int __init sgi_ip27_rtc_devinit(void)
-{
-	struct resource res;
-
-	memset(&res, 0, sizeof(res));
-	res.start = XPHYSADDR(KL_CONFIG_CH_CONS_INFO(master_nasid)->memory_base +
-			      IOC3_BYTEBUS_DEV0);
-	res.end = res.start + 32767;
-	res.flags = IORESOURCE_MEM;
-
-	return IS_ERR(platform_device_register_simple("rtc-m48t35", -1,
-						      &res, 1));
-}
-
-/*
- * kludge make this a device_initcall after ioc3 resource conflicts
- * are resolved
- */
-late_initcall(sgi_ip27_rtc_devinit);
-- 
2.13.7
