From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/5] net: mac8390: Use standard memcpy_{from,to}io()
Date: Mon,  9 Jul 2018 11:30:37 +0200
Message-ID: <20180709093040.23597-3-geert@linux-m68k.org>
References: <20180709093040.23597-1-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

The mac8390 driver defines its own variants of memcpy_fromio() and
memcpy_toio(), using similar implementations, but different function
signatures.

Remove the custom definitions of memcpy_fromio() and memcpy_toio(), and
adjust all callers to the standard signatures.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: David S. Miller <davem@davemloft.net>
---
This is a dependency for "m68k: Move mem*io define guards to
<asm/kmap.h>".

Untested on real hardware, assembler output compared.

v2:
  - Add Acked-by.
---
 drivers/net/ethernet/8390/mac8390.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index b6d735bf80117e27..342ae08ec3c29832 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -153,9 +153,6 @@ static void dayna_block_input(struct net_device *dev, int count,
 static void dayna_block_output(struct net_device *dev, int count,
 			       const unsigned char *buf, int start_page);
 
-#define memcpy_fromio(a, b, c)	memcpy((a), (void *)(b), (c))
-#define memcpy_toio(a, b, c)	memcpy((void *)(a), (b), (c))
-
 #define memcmp_withio(a, b, c)	memcmp((a), (void *)(b), (c))
 
 /* Slow Sane (16-bit chunk memory read/write) Cabletron uses this */
@@ -239,7 +236,7 @@ static enum mac8390_access mac8390_testio(unsigned long membase)
 	unsigned long outdata = 0xA5A0B5B0;
 	unsigned long indata =  0x00000000;
 	/* Try writing 32 bits */
-	memcpy_toio(membase, &outdata, 4);
+	memcpy_toio((void __iomem *)membase, &outdata, 4);
 	/* Now compare them */
 	if (memcmp_withio(&outdata, membase, 4) == 0)
 		return ACCESS_32;
@@ -711,7 +708,7 @@ static void sane_get_8390_hdr(struct net_device *dev,
 			      struct e8390_pkt_hdr *hdr, int ring_page)
 {
 	unsigned long hdr_start = (ring_page - WD_START_PG)<<8;
-	memcpy_fromio(hdr, dev->mem_start + hdr_start, 4);
+	memcpy_fromio(hdr, (void __iomem *)dev->mem_start + hdr_start, 4);
 	/* Fix endianness */
 	hdr->count = swab16(hdr->count);
 }
@@ -725,13 +722,16 @@ static void sane_block_input(struct net_device *dev, int count,
 	if (xfer_start + count > ei_status.rmem_end) {
 		/* We must wrap the input move. */
 		int semi_count = ei_status.rmem_end - xfer_start;
-		memcpy_fromio(skb->data, dev->mem_start + xfer_base,
+		memcpy_fromio(skb->data,
+			      (void __iomem *)dev->mem_start + xfer_base,
 			      semi_count);
 		count -= semi_count;
-		memcpy_fromio(skb->data + semi_count, ei_status.rmem_start,
-			      count);
+		memcpy_fromio(skb->data + semi_count,
+			      (void __iomem *)ei_status.rmem_start, count);
 	} else {
-		memcpy_fromio(skb->data, dev->mem_start + xfer_base, count);
+		memcpy_fromio(skb->data,
+			      (void __iomem *)dev->mem_start + xfer_base,
+			      count);
 	}
 }
 
@@ -740,7 +740,7 @@ static void sane_block_output(struct net_device *dev, int count,
 {
 	long shmem = (start_page - WD_START_PG)<<8;
 
-	memcpy_toio(dev->mem_start + shmem, buf, count);
+	memcpy_toio((void __iomem *)dev->mem_start + shmem, buf, count);
 }
 
 /* dayna block input/output */
-- 
2.17.1
