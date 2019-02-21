From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v2 1/2] drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
Date: Thu, 21 Feb 2019 02:56:08 -0800
Message-ID: <20190221105609.5710-2-ronald@innovation.ch>
References: <20190221105609.5710-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221105609.5710-1-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-input@vger.kernel.org

commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
INPUT. However, this causes problems with other drivers, in particular
an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
future commit):

  drivers/clk/Kconfig:9:error: recursive dependency detected!
  drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
  drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
  drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
  drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
  drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
  drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
  drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
  drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK

According to the docs, select should only be used for non-visible
symbols. Furthermore almost all other references to INPUT throughout the
kernel config are depends, not selects. Hence this change.

CC: Inki Dae <inki.dae@samsung.com>
CC: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 9eeb8ef0b174..bc838e7bb7c8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
 config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
+	depends on INPUT
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
 	select RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
-- 
2.20.1
