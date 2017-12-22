From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 11/14] iio: adc: at91-sama5d2_adc: optimize scan index for diff channels
Date: Fri, 22 Dec 2017 17:07:18 +0200
Message-ID: <1513955241-10985-12-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Optimize the scan index for the differential channels. Before, it
was single channel count + index of the first single channel
number of the differential pair. (e.g. 11+0, +2, +4, etc.)
Divide that number by two (since it's always even), and add it up
as a scan index to have consecutive numbered channels in the
index.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 7b9febc..9610393 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -209,7 +209,7 @@
 		.channel = num,						\
 		.channel2 = num2,					\
 		.address = addr,					\
-		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
+		.scan_index = (num >> 1) + AT91_SAMA5D2_SINGLE_CHAN_CNT,\
 		.scan_type = {						\
 			.sign = 's',					\
 			.realbits = 12,					\
-- 
2.7.4
