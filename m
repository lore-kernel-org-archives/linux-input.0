From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] MAINTAINERS: add maintainers for ChromeOS EC sub-drivers
Date: Tue, 11 Dec 2018 20:00:53 +0100
Message-ID: <20181211190053.9997-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, Benson Leung <bleung@chromiumg.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Lar
List-Id: linux-input@vger.kernel.org

There are multiple ChromeOS EC sub-drivers spread in different
subsystems, as all of them are related to the Chrome stuff add
Benson and myself as a maintainers for all these sub-drivers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 MAINTAINERS | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a24129b0b043..2f24f5c977ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3625,6 +3625,30 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
 
+CHROMEOS EC SUBDRIVERS
+M:	Benson Leung <bleung@chromiumg.org>
+M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
+F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
+F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
+F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
+F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
+F:	drivers/extcon/extcon-usbc-cros-ec.c
+F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
+F:	drivers/iio/accel/cros_ec*
+F:	drivers/iio/common/cros_ec_sensors/
+F:	drivers/iio/light/cros_ec*
+F:	drivers/iio/pressure/cros_ec*
+F:	drivers/input/keyboard/cros_ec*
+F:	drivers/mfd/cros_ec*
+F:	drivers/power/supply/cros_usbpd-charger.c
+F:	drivers/pwm/pwm-cros-ec.c
+F:	drivers/rtc/rtc-cros-ec.c
+F:	include/linux/iio/common/cros_ec_sensors_core.h
+F:	include/linux/mfd/cros_ec*
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.19.2
