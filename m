From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Input: mma8450: add device tree probe support
Date: Fri, 22 Jul 2011 00:25:51 +0800
Message-ID: <1311265551-23233-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sammy He <r62914-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

It adds device tree probe support for mma8450 driver.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Sammy He <r62914-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
---
 .../devicetree/bindings/input/fsl-mma8450.txt      |   11 +++++++++++
 drivers/input/misc/mma8450.c                       |    8 ++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/fsl-mma8450.txt

diff --git a/Documentation/devicetree/bindings/input/fsl-mma8450.txt b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
new file mode 100644
index 0000000..a00c94c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
@@ -0,0 +1,11 @@
+* Freescale MMA8450 3-Axis Accelerometer
+
+Required properties:
+- compatible : "fsl,mma8450".
+
+Example:
+
+accelerometer: mma8450@1c {
+	compatible = "fsl,mma8450";
+	reg = <0x1c>;
+};
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 20f8f92..6c76cf7 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/input-polldev.h>
+#include <linux/of_device.h>
 
 #define MMA8450_DRV_NAME	"mma8450"
 
@@ -229,10 +230,17 @@ static const struct i2c_device_id mma8450_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mma8450_id);
 
+static const struct of_device_id mma8450_dt_ids[] = {
+	{ .compatible = "fsl,mma8450", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, mma8450_dt_ids);
+
 static struct i2c_driver mma8450_driver = {
 	.driver = {
 		.name	= MMA8450_DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = mma8450_dt_ids,
 	},
 	.probe		= mma8450_probe,
 	.remove		= __devexit_p(mma8450_remove),
-- 
1.7.4.1
