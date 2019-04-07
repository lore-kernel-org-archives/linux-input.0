From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v4 1/2] drm/bridge: sil_sii8620: make remote control optional.
Date: Sat,  6 Apr 2019 22:03:57 -0700
Message-ID: <20190407050358.2976-2-ronald@innovation.ch>
References: <20190407050358.2976-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190407050358.2976-1-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-input@vger.kernel.org

commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
of RC_CORE) changed the driver to select both RC_CORE and INPUT.
However, this causes problems with other drivers, in particular an input
driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
commit):

  drivers/clk/Kconfig:9:error: recursive dependency detected!
  drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
  drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
  drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
  drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
  drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
  drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
  drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
  drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK

According to the docs and general consensus, select should only be used
for non user-visible symbols, but both RC_CORE and INPUT are
user-visible. Furthermore almost all other references to INPUT
throughout the kernel config are depends, not selects. For this reason
the first part of this change reverts commit d6abe6df706c.

In order to address the original reason for commit d6abe6df706c, namely
that not all boards use the remote controller functionality and hence
should not need have to deal with RC_CORE, the second part of this
change now makes the remote control support in the driver optional and
contingent on RC_CORE being defined. And with this the hard dependency
on INPUT also goes away as that is only needed if RC_CORE is defined
(which in turn already depends on INPUT).

CC: Inki Dae <inki.dae@samsung.com>
CC: Andrzej Hajda <a.hajda@samsung.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/gpu/drm/bridge/Kconfig       |  3 +--
 drivers/gpu/drm/bridge/sil-sii8620.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..9cf07105b73a 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -85,8 +85,7 @@ config DRM_SIL_SII8620
 	depends on OF
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
-	select RC_CORE
+	imply RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index a6e8f4591e63..f8dfbf01caa8 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -66,7 +66,9 @@ enum sii8620_mt_state {
 struct sii8620 {
 	struct drm_bridge bridge;
 	struct device *dev;
+#if IS_ENABLED(CONFIG_RC_CORE)
 	struct rc_dev *rc_dev;
+#endif
 	struct clk *clk_xtal;
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_int;
@@ -1757,6 +1759,7 @@ static void sii8620_send_features(struct sii8620 *ctx)
 	sii8620_write_buf(ctx, REG_MDT_XMIT_WRITE_PORT, buf, ARRAY_SIZE(buf));
 }
 
+#if IS_ENABLED(CONFIG_RC_CORE)
 static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
 {
 	bool pressed = !(scancode & MHL_RCP_KEY_RELEASED_MASK);
@@ -1775,6 +1778,12 @@ static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
 
 	return true;
 }
+#else
+static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
+{
+	return false;
+}
+#endif
 
 static void sii8620_msc_mr_set_int(struct sii8620 *ctx)
 {
@@ -2098,6 +2107,7 @@ static void sii8620_cable_in(struct sii8620 *ctx)
 	enable_irq(to_i2c_client(ctx->dev)->irq);
 }
 
+#if IS_ENABLED(CONFIG_RC_CORE)
 static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 {
 	struct rc_dev *rc_dev;
@@ -2127,6 +2137,11 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 	}
 	ctx->rc_dev = rc_dev;
 }
+#else
+static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
+{
+}
+#endif
 
 static void sii8620_cable_out(struct sii8620 *ctx)
 {
@@ -2213,12 +2228,18 @@ static int sii8620_attach(struct drm_bridge *bridge)
 	return sii8620_clear_error(ctx);
 }
 
+#if IS_ENABLED(CONFIG_RC_CORE)
 static void sii8620_detach(struct drm_bridge *bridge)
 {
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
 
 	rc_unregister_device(ctx->rc_dev);
 }
+#else
+static void sii8620_detach(struct drm_bridge *bridge)
+{
+}
+#endif
 
 static int sii8620_is_packing_required(struct sii8620 *ctx,
 				       const struct drm_display_mode *mode)
-- 
2.20.1
