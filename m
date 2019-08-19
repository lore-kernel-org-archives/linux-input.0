From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH v5 11/17] net: sgi: ioc3-eth: no need to stop queue set_multicast_list
Date: Mon, 19 Aug 2019 18:31:34 +0200
Message-ID: <20190819163144.3478-12-tbogendoerfer@suse.de>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819163144.3478-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

netif_stop_queue()/netif_wake_qeue() aren't needed for changing
multicast filters. Use spinlocks instead for proper protection
of private struct.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index d862f28887f9..7f85a3bfef14 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1542,8 +1542,7 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 	struct netdev_hw_addr *ha;
 	u64 ehar = 0;
 
-	netif_stop_queue(dev);				/* Lock out others. */
-
+	spin_lock_irq(&ip->ioc3_lock);
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous.  */
 		ip->emcr |= EMCR_PROMISC;
 		writel(ip->emcr, &regs->emcr);
@@ -1572,7 +1571,7 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 		writel(ip->ehar_l, &regs->ehar_l);
 	}
 
-	netif_wake_queue(dev);			/* Let us get going again. */
+	spin_unlock_irq(&ip->ioc3_lock);
 }
 
 module_pci_driver(ioc3_driver);
-- 
2.13.7
