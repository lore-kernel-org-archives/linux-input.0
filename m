From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: [PATCH 1/2] Documentation: sample averaging for imx6ul_tsc
Date: Sun, 27 Nov 2016 09:44:57 +0200
Message-ID: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, Guy Shapiro <guy.shapiro@mobi-wize.com>, devicetree@vger.kernel.org, haibo.chen@freescale.com, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

The i.MX6UL internal touchscreen controller contains an option to
average upon samples. This feature reduces noise from the produced
touch locations.

This patch introduces a new device tree optional property for this
feature. It provides control over the amount of averaged samples per
touch event.

The property was inspired by a similar property on the
"brcm,iproc-touchscreen" binding.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
index 853dff9..a66069f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
@@ -17,6 +17,13 @@ Optional properties:
   This value depends on the touch screen.
 - pre-charge-time: the touch screen need some time to precharge.
   This value depends on the touch screen.
+- average-samples: Number of data samples which are averaged for each read.
+	Valid values 0-4
+	0 =  1 sample
+	1 =  4 samples
+	2 =  8 samples
+	3 = 16 samples
+	4 = 32 samples
 
 Example:
 	tsc: tsc@02040000 {
@@ -32,5 +39,6 @@ Example:
 		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		measure-delay-time = <0xfff>;
 		pre-charge-time = <0xffff>;
+		average-samples = <4>;
 		status = "okay";
 	};
-- 
2.1.4
