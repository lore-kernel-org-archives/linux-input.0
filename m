From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 01/10] MAINTAINERS: add generic resistive touchscreen adc
Date: Tue, 27 Mar 2018 15:32:34 +0300
Message-ID: <1522153963-1121-2-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add MAINTAINERS entry for generic resistive touchscreen adc

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36f1442..ba227cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5943,6 +5943,12 @@ F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 F:	Documentation/devicetree/bindings/power/power_domain.txt
 
+GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/touch_adc.c
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
-- 
2.7.4
