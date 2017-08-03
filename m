From: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v8 07/12] mfd: dt-bindings: Add RK805 device tree bindings
 document
Date: Thu,  3 Aug 2017 20:25:12 +0800
Message-ID: <1501763112-20438-1-git-send-email-chenjh@rock-chips.com>
References: <1501762841-20262-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1501762841-20262-1-git-send-email-chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wdc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org, Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Add device tree bindings documentation for Rockchip's RK805 PMIC.

Signed-off-by: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 9636ae8..91b6522 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -1,11 +1,14 @@
 RK8XX Power Management Integrated Circuit
 
 The rk8xx family current members:
+rk805
 rk808
 rk818
 
 Required properties:
-- compatible: "rockchip,rk808", "rockchip,rk818"
+- compatible: "rockchip,rk805"
+- compatible: "rockchip,rk808"
+- compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
 - interrupts: the interrupt outputs of the controller.
@@ -18,6 +21,14 @@ Optional properties:
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
 
+Optional RK805 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1 and LDO_REG2
+- vcc6-supply:  The input supply for LDO_REG3
+
 Optional RK808 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -56,6 +67,15 @@ by a child node of the 'regulators' node.
 		/* standard regulator bindings here */
 	};
 
+Following regulators of the RK805 PMIC regulators are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK805 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 3
+
 Following regulators of the RK808 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK808 datasheet.
-- 
1.9.1
