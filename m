From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 5/5] ARM: configs: at91: add PTC driver to sama5_defconfig
Date: Fri, 20 Oct 2017 15:31:21 +0200
Message-ID: <20171020133121.7992-6-ludovic.desroches@microchip.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-input@vger.kernel.org

Add Peripheral Touch Controller driver to sama5_defconfig.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 6529cb43e0fd..0422345ff3a3 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -118,6 +118,8 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_ATMEL_PTC=m
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_ATMEL=y
-- 
2.12.2
