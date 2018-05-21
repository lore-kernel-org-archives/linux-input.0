From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v6 1/9] MAINTAINERS: add generic resistive touchscreen adc
Date: Mon, 21 May 2018 13:27:49 +0300
Message-ID: <1526898477-9952-2-git-send-email-eugen.hristev@microchip.com>
References: <1526898477-9952-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526898477-9952-1-git-send-email-eugen.hristev@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add MAINTAINERS entry for generic resistive touchscreen adc

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
 - Changed source file name

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..ce9720f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5943,6 +5943,12 @@ F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 F:	Documentation/devicetree/bindings/power/power_domain.txt
 
+GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/resistive-adc-touch.c
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
-- 
2.7.4
