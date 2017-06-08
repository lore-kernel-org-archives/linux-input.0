From: Jianhong Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 12/12] gpio: dt-bindings: add bindings for Rockchip RK805
 PMIC
Date: Thu,  8 Jun 2017 15:33:13 +0800
Message-ID: <1496907193-29294-1-git-send-email-chenjh@rock-chips.com>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1496905959-29202-1-git-send-email-chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org, chenjh <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: chenjh <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Add device tree bindings documentation for Rockchip's RK805 PMIC

Signed-off-by: chenjh <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 .../devicetree/bindings/gpio/gpio-rk805.txt        | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rk805.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-rk805.txt b/Documentation/devicetree/bindings/gpio/gpio-rk805.txt
new file mode 100644
index 0000000..98b75fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-rk805.txt
@@ -0,0 +1,37 @@
+RK805 GPIO controller
+
+This driver follows the usual GPIO bindings found in
+Documentation/devicetree/bindings/gpio/gpio.txt
+
+Required properties:
+- #gpio-cells: Should be two. The first cell is the pin number and the
+  second is the GPIO flags.
+- gpio-controller: Marks the device node as a GPIO controller.
+
+These properties must be added in the RK805 PMIC node, documented in
+Documentation/devicetree/bindings/mfd/rk808.txt
+
+Example:
+
+rk805: pmic@18 {
+	compatible = "rockchip,rk808";
+	clock-output-names = "xin32k", "rk808-clkout2";
+	interrupt-parent = <&gpio0>;
+	interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+	reg = <0x1a>;
+	rockchip,system-power-controller;
+	wakeup-source;
+	#clock-cells = <1>;
+	...
+	gpio-controller;
+	#gpio-cells = <2>;
+};
+
+
+Example of a peripheral using the PMIC GPIOs:
+
+wireless-bluetooth {
+		compatible = "bluetooth-platdata";
+		...
+		gpios = <&rk805 0 GPIO_ACTIVE_HIGH>, <&rk805 1 GPIO_ACTIVE_HIGH>;
+};
-- 
1.9.1
