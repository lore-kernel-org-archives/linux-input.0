From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory error path
Date: Mon,  2 Apr 2018 16:03:27 +0200
Message-ID: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

When extending the rmi_spi buffers, we must check that no out of memory
error occurs, otherwise we may access data above the currently allocated
memory.

Propagate the error code returned by 'rmi_spi_manage_pools()' instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/rmi4/rmi_spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 76edbf2c1bce..082defc329a8 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -147,8 +147,11 @@ static int rmi_spi_xfer(struct rmi_spi_xport *rmi_spi,
 	if (len > RMI_SPI_XFER_SIZE_LIMIT)
 		return -EINVAL;
 
-	if (rmi_spi->xfer_buf_size < len)
-		rmi_spi_manage_pools(rmi_spi, len);
+	if (rmi_spi->xfer_buf_size < len) {
+		ret = rmi_spi_manage_pools(rmi_spi, len);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (addr == 0)
 		/*
-- 
2.14.1
