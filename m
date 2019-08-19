From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH v5 13/17] net: sgi: ioc3-eth: use csum_fold
Date: Mon, 19 Aug 2019 18:31:36 +0200
Message-ID: <20190819163144.3478-14-tbogendoerfer@suse.de>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819163144.3478-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

replace open coded checksum folding by csum_fold.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 647e3926bd71..56392f0b01de 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1378,16 +1378,12 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Sum up dest addr, src addr and protocol  */
 		ehsum = eh[0] + eh[1] + eh[2] + eh[3] + eh[4] + eh[5] + eh[6];
 
-		/* Fold ehsum.  can't use csum_fold which negates also ...  */
-		ehsum = (ehsum & 0xffff) + (ehsum >> 16);
-		ehsum = (ehsum & 0xffff) + (ehsum >> 16);
-
 		/* Skip IP header; it's sum is always zero and was
 		 * already filled in by ip_output.c
 		 */
 		csum = csum_tcpudp_nofold(ih->saddr, ih->daddr,
 					  ih->tot_len - (ih->ihl << 2),
-					  proto, 0xffff ^ ehsum);
+					  proto, csum_fold(ehsum));
 
 		csum = (csum & 0xffff) + (csum >> 16);	/* Fold again */
 		csum = (csum & 0xffff) + (csum >> 16);
-- 
2.13.7
