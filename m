From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v4 4/4] OMAP4: Keyboard kernel configuration
Date: Wed, 16 Jun 2010 11:10:12 -0500
Message-ID: <1276704612-30743-1-git-send-email-x0066660@ti.com>
References: <x0066660@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <x0066660@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Syed Rafiuddin <rafiuddin.syed@ti.com>, Abraham Arce <x0066660@ti.com>
List-Id: linux-input@vger.kernel.org

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Update OMAP4430 configuration to enable OMAP4 keyboard driver

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 1fb0456..54c924f 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -578,7 +578,8 @@ CONFIG_INPUT_EVDEV=y
 #
 # Input Device Drivers
 #
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_OMAP4=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.6.3.3

