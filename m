From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: [PATCH v3] altera_ps2: Add devicetree support
Date: Thu,  3 Feb 2011 11:05:04 +0800
Message-ID: <1296702304-30471-1-git-send-email-thomas@wytron.com.tw>
References: <AANLkTikxSrwOfU=m_h+6G5hQMk6drOpqOPSfbBdzg53g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <AANLkTikxSrwOfU=m_h+6G5hQMk6drOpqOPSfbBdzg53g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Walter Goossens <waltergoossens-CmkmPbn3yAE@public.gmane.org>
Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
---
v2 use const and add compat version.
v3 change compatible vendor to ALTR.
   add dts binding doc.

 .../devicetree/bindings/serio/altera_ps2.txt       |    4 ++++
 drivers/input/serio/altera_ps2.c                   |   11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serio/altera_ps2.txt

diff --git a/Documentation/devicetree/bindings/serio/altera_ps2.txt b/Documentation/devicetree/bindings/serio/altera_ps2.txt
new file mode 100644
index 0000000..4d9eecc
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/altera_ps2.txt
@@ -0,0 +1,4 @@
+Altera UP PS/2 controller
+
+Required properties:
+- compatible : should be "ALTR,ps2-1.0".
diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index 7998560..d94b4a3 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #define DRV_NAME "altera_ps2"
 
@@ -173,6 +174,12 @@ static int __devexit altera_ps2_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id altera_ps2_match[] = {
+	{ .compatible = "ALTR,ps2-1.0", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, altera_ps2_match);
+
 /*
  * Our device driver structure
  */
@@ -182,6 +189,7 @@ static struct platform_driver altera_ps2_driver = {
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = altera_ps2_match,
 	},
 };
 
@@ -189,13 +197,12 @@ static int __init altera_ps2_init(void)
 {
 	return platform_driver_register(&altera_ps2_driver);
 }
+module_init(altera_ps2_init);
 
 static void __exit altera_ps2_exit(void)
 {
 	platform_driver_unregister(&altera_ps2_driver);
 }
-
-module_init(altera_ps2_init);
 module_exit(altera_ps2_exit);
 
 MODULE_DESCRIPTION("Altera University Program PS2 controller driver");
-- 
1.7.3.5
