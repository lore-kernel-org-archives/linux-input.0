From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: sun4i-ts: add thermal driver dependency
Date: Wed, 28 Jan 2015 16:17:10 +0100
Message-ID: <2265502.1m7jYBaqyh@wuerfel>
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
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The sun4i-ts driver has had a dependency on the thermal code
since it was first merged, but this is not currently enforced
in Kconfig, so in some randconfig builds we get

drivers/built-in.o: In function `sun4i_ts_remove':
:(.text+0x2376f4): undefined reference to `thermal_zone_of_sensor_unregister'
drivers/built-in.o: In function `sun4i_ts_probe':
:(.text+0x237a94): undefined reference to `thermal_zone_of_sensor_register'
:(.text+0x237c00): undefined reference to `thermal_zone_of_sensor_unregister'

We need the dependency on THERMAL in order to ensure that this
driver becomes a loadable module if the thermal support itself
is modular, while the dependency on THERMAL_OF is a runtime dependency
and the driver will still build but not work if it is missing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6decea7c5438e2 ("Input: add driver for Allwinner sunxi SoC's rtp controller")

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 58917525126e..e2447f0063b7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -943,6 +943,8 @@ config TOUCHSCREEN_SUN4I
 	tristate "Allwinner sun4i resistive touchscreen controller support"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on HWMON
+	depends on THERMAL
+	depends on THERMAL_OF || COMPILE_TEST
 	help
 	  This selects support for the resistive touchscreen controller
 	  found on Allwinner sunxi SoCs.
