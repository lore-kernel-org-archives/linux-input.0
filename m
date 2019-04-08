From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH 1/6] MIPS: SGI-IP27: remove ioc3 ethernet init
Date: Mon,  8 Apr 2019 16:20:53 +0200
Message-ID: <20190408142100.27618-2-tbogendoerfer@suse.de>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408142100.27618-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Removed not needed disabling of ethernet interrupts in IP27 platform code.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 066b33f50bcc..59d5375c9021 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -130,17 +130,6 @@ cnodeid_t get_compact_nodeid(void)
 	return NASID_TO_COMPACT_NODEID(get_nasid());
 }
 
-static inline void ioc3_eth_init(void)
-{
-	struct ioc3 *ioc3;
-	nasid_t nid;
-
-	nid = get_nasid();
-	ioc3 = (struct ioc3 *) KL_CONFIG_CH_CONS_INFO(nid)->memory_base;
-
-	ioc3->eier = 0;
-}
-
 extern void ip27_reboot_setup(void);
 
 void __init plat_mem_setup(void)
@@ -182,8 +171,6 @@ void __init plat_mem_setup(void)
 		panic("Kernel compiled for N mode.");
 #endif
 
-	ioc3_eth_init();
-
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0UL;
 	set_io_port_base(IO_BASE);
-- 
2.13.7
