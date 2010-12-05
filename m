From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 8/8] input: gpio_keys_polled: fix Kconfig help text
Date: Sun,  5 Dec 2010 10:34:52 +0100
Message-ID: <1291541692-15988-1-git-send-email-juhosg@openwrt.org>
References: <1291142663-1011-9-git-send-email-juhosg@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44690 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab0LEJfC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Dec 2010 04:35:02 -0500
In-Reply-To: <1291142663-1011-9-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com, Gabor Juhos <juhosg@openwrt.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
  - remove 'which is ' from the help text

 drivers/input/keyboard/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 9648ff4..897b758 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -491,7 +491,7 @@ config KEYBOARD_GPIO_POLLED
 	select INPUT_POLLDEV
 	help
 	  This driver implements support for buttons connected
-	  to GPIO pins of various CPUs (and some other chips).
+	  to GPIO pins not capable to generate interrupts.
 
 	  Say Y here if your device has buttons connected
 	  directly to such GPIO pins.  Your board-specific
@@ -499,6 +499,6 @@ config KEYBOARD_GPIO_POLLED
 	  with configuration data saying which GPIOs are used.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called gpio-buttons.
+	  module will be called gpio_keys_polled.
 
 endif
-- 
1.7.2.1

