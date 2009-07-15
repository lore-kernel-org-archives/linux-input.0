From: Alessandro Rubini <rubini-list@gnudd.com>
Subject: [PATCH] ads7846: allocate separate cache lines for tx and rx data
Date: Wed, 15 Jul 2009 11:33:13 +0200
Message-ID: <20090715093313.GA2897@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-input@vger.kernel.org
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, dbrownell@users.sourceforge.net
List-Id: linux-input@vger.kernel.org

From: Alessandro Rubini <rubini@gnudd.com>

Since the SPI master might use DMA, tx and rx buffers must live on
different cache lines.  Here one cache line is used for all tx and
another for all rx.  This will work whether the SPI master maps/unmaps
one buffer at a time or all together.  The patch only fixes the analog
inputs, as touch screen operation is not affected, although I didn't
check why.  I tested on at91sam9263, where buffers are all mapped
initially and unmapped individually at irq time.

The issue was discussed with Russell King on linux-arm-kernel.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/touchscreen/ads7846.c |   53 +++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index ba9d38c..6c940c9 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -27,6 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/dma-mapping.h>
 #include <asm/irq.h>
 
 
@@ -196,13 +197,20 @@ struct ads7846 {
  */
 
 struct ser_req {
+	struct spi_message	msg;
+	struct spi_transfer	xfer[6];
+	/* data buffers must live on different cache lines, for DMA access */
+	struct tx_data		*tx;
+	struct rx_data		*rx;
+};
+struct tx_data {
 	u8			ref_on;
 	u8			command;
 	u8			ref_off;
-	u16			scratch;
+};
+struct rx_data {
 	__be16			sample;
-	struct spi_message	msg;
-	struct spi_transfer	xfer[6];
+	__be16			scratch;
 };
 
 static void ads7846_enable(struct ads7846 *ts);
@@ -218,12 +226,27 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 {
 	struct spi_device	*spi = to_spi_device(dev);
 	struct ads7846		*ts = dev_get_drvdata(dev);
-	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
+	struct ser_req		*req;
+	void			*ptr;
 	int			status;
 	int			use_internal;
+	int			cacheline = dma_get_cache_alignment();
+	int			size;
+
+	/*
+	 * allocate the request and two different cache lines for tx and rx.
+	 * Use a single kmalloc and some simple quasi-constant aritmetics
+	 */
+	size = ALIGN(sizeof *req, cacheline)
+		+ ALIGN(sizeof *req->tx, cacheline)
+		+ ALIGN(sizeof *req->rx, cacheline);
 
-	if (!req)
+	ptr = kzalloc(size, GFP_KERNEL);
+	if (!ptr)
 		return -ENOMEM;
+	req = ptr;
+	req->tx = ptr + ALIGN(sizeof *req, cacheline);
+	req->rx = (void *)req->tx + ALIGN(sizeof *req->tx, cacheline);
 
 	spi_message_init(&req->msg);
 
@@ -232,12 +255,12 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 
 	/* maybe turn on internal vREF, and let it settle */
 	if (use_internal) {
-		req->ref_on = REF_ON;
-		req->xfer[0].tx_buf = &req->ref_on;
+		req->tx->ref_on = REF_ON;
+		req->xfer[0].tx_buf = &req->tx->ref_on;
 		req->xfer[0].len = 1;
 		spi_message_add_tail(&req->xfer[0], &req->msg);
 
-		req->xfer[1].rx_buf = &req->scratch;
+		req->xfer[1].rx_buf = &req->rx->scratch;
 		req->xfer[1].len = 2;
 
 		/* for 1uF, settle for 800 usec; no cap, 100 usec.  */
@@ -246,24 +269,24 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	}
 
 	/* take sample */
-	req->command = (u8) command;
-	req->xfer[2].tx_buf = &req->command;
+	req->tx->command = (u8) command;
+	req->xfer[2].tx_buf = &req->tx->command;
 	req->xfer[2].len = 1;
 	spi_message_add_tail(&req->xfer[2], &req->msg);
 
-	req->xfer[3].rx_buf = &req->sample;
+	req->xfer[3].rx_buf = &req->rx->sample;
 	req->xfer[3].len = 2;
 	spi_message_add_tail(&req->xfer[3], &req->msg);
 
 	/* REVISIT:  take a few more samples, and compare ... */
 
 	/* converter in low power mode & enable PENIRQ */
-	req->ref_off = PWRDOWN;
-	req->xfer[4].tx_buf = &req->ref_off;
+	req->tx->ref_off = PWRDOWN;
+	req->xfer[4].tx_buf = &req->tx->ref_off;
 	req->xfer[4].len = 1;
 	spi_message_add_tail(&req->xfer[4], &req->msg);
 
-	req->xfer[5].rx_buf = &req->scratch;
+	req->xfer[5].rx_buf = &req->rx->scratch;
 	req->xfer[5].len = 2;
 	CS_CHANGE(req->xfer[5]);
 	spi_message_add_tail(&req->xfer[5], &req->msg);
@@ -276,7 +299,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 
 	if (status == 0) {
 		/* on-wire is a must-ignore bit, a BE12 value, then padding */
-		status = be16_to_cpu(req->sample);
+		status = be16_to_cpu(req->rx->sample);
 		status = status >> 3;
 		status &= 0x0fff;
 	}
-- 
1.6.0.2

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
