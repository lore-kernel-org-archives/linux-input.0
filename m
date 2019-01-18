From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 13/13] MAINTAINERS: add an entry for max77650 mfd driver
Date: Fri, 18 Jan 2019 14:42:44 +0100
Message-ID: <20190118134244.22253-14-brgl@bgdev.pl>
References: <20190118134244.22253-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118134244.22253-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..bb29fe250796 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9220,6 +9220,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.19.1
