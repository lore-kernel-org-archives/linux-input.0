From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH] HID: wacom: Change HID_WACOM option description.
Date: Mon, 19 Mar 2012 19:17:39 +0000
Message-ID: <1332184659-31530-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:58915 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032559Ab2CSTRz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 15:17:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pinglinux@gmail.com, jkosina@suse.cz
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

Trivial patch: now the hid-wacom driver supports also Intuos4 WL tablet.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8011d77..77daaf21 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -623,7 +623,7 @@ config HID_WACOM
 	depends on HID_WACOM
 	select POWER_SUPPLY
 	---help---
-	Support for Wacom Graphire Bluetooth tablet.
+	Support for Wacom Graphire Bluetooth and Intuos4 WL tablets.
 
 config HID_WIIMOTE
 	tristate "Nintendo Wii Remote support"
-- 
1.7.6.4

