From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: tablet: make USB drivers depend on USB
Date: Wed, 17 Jan 2018 22:36:45 +0100
Message-ID: <20180117213645.1233-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

A driver should not enable an entire subsystem.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/tablet/Kconfig | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index a2b9f97422ce..379f40858709 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -13,8 +13,7 @@ if INPUT_TABLET
 
 config TABLET_USB_ACECAD
 	tristate "Acecad Flair tablet support (USB)"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use the USB version of the Acecad Flair
 	  tablet.  Make sure to say Y to "Mouse support"
@@ -26,8 +25,7 @@ config TABLET_USB_ACECAD
 
 config TABLET_USB_AIPTEK
 	tristate "Aiptek 6000U/8000U and Genius G_PEN tablet support (USB)"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use the USB version of the Aiptek 6000U,
 	  Aiptek 8000U or Genius G-PEN 560 tablet.  Make sure to say Y to
@@ -51,8 +49,7 @@ config TABLET_USB_GTCO
 
 config TABLET_USB_HANWANG
 	tristate "Hanwang Art Master III tablet support (USB)"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use the USB version of the Hanwang Art
 	  Master III tablet.
@@ -62,8 +59,7 @@ config TABLET_USB_HANWANG
 
 config TABLET_USB_KBTAB
 	tristate "KB Gear JamStudio tablet support (USB)"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use the USB version of the KB Gear
 	  JamStudio tablet.  Make sure to say Y to "Mouse support"
@@ -75,8 +71,7 @@ config TABLET_USB_KBTAB
 
 config TABLET_USB_PEGASUS
 	tristate "Pegasus Mobile Notetaker Pen input tablet support"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use the Pegasus Mobile Notetaker,
 	  also known as:
-- 
2.15.1
