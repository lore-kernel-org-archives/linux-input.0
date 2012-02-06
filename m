From: chris@cnpbagwell.com
Subject: [PATCH 5/5] Input: wacom : Add missing LEDS_CLASS to Kconfig
Date: Sun,  5 Feb 2012 20:46:16 -0600
Message-ID: <1328496376-28502-6-git-send-email-chris@cnpbagwell.com>
References: <1328496376-28502-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:46352 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752906Ab2BFCqe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Feb 2012 21:46:34 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so6249563obc.19
        for <linux-input@vger.kernel.org>; Sun, 05 Feb 2012 18:46:33 -0800 (PST)
In-Reply-To: <1328496376-28502-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index 0edeb94..6c927a4 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -76,6 +76,7 @@ config TABLET_USB_KBTAB
 config TABLET_USB_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
 	depends on USB_ARCH_HAS_HCD
+	select LEDS_CLASS
 	select POWER_SUPPLY
 	select USB
 	help
-- 
1.7.7.6

