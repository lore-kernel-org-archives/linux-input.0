From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v3 1/3] input: goodix - support Goodix gt5688
Date: Fri, 15 Feb 2019 15:11:51 +0100
Message-ID: <f342ad633683716cd2acb99b819da76c06ce0850.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, Matthias Brugger <matthias.bgg@gmail.com>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

>From what I've seen in vendor trees it's fine to treat this as gt1x¹.
Tested on the Purism Librem 5 Devkit (Rocktech JH057N00900 panel).

[1]: https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drivers/input/touchscreen/mediatek/GT5688

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 drivers/input/touchscreen/goodix.c                             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..57d3d8870a09 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5688"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..47b1ced41576 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -216,6 +216,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5688:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -942,6 +943,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5688" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.20.1
