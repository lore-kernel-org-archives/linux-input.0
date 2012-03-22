From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 2/4] HID: wacom: Change HID_WACOM option description.
Date: Thu, 22 Mar 2012 18:54:06 +0000
Message-ID: <1332442448-10473-2-git-send-email-przemo@firszt.eu>
References: <1332442448-10473-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:48593 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757052Ab2CVS4M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Mar 2012 14:56:12 -0400
In-Reply-To: <1332442448-10473-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: pinglinux@gmail.com, chris@cnpbagwell.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

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

