From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 1/2] HID: wacom: Fix HID_WACOM self-dependency
Date: Wed, 28 Mar 2012 22:13:36 +0100
Message-ID: <1332969217-10727-2-git-send-email-przemo@firszt.eu>
References: <1332969217-10727-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:38462 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932894Ab2C1VON (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 17:14:13 -0400
In-Reply-To: <1332969217-10727-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

This patch fixes a silly mistake: HID_WACOM was dependent on HID_WACOM, so
the option wasn't showing up after make menuconfig

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 77daaf21..7f1c032 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -620,7 +620,6 @@ config THRUSTMASTER_FF
 config HID_WACOM
 	tristate "Wacom Bluetooth devices support"
 	depends on BT_HIDP
-	depends on HID_WACOM
 	select POWER_SUPPLY
 	---help---
 	Support for Wacom Graphire Bluetooth and Intuos4 WL tablets.
-- 
1.7.9.1

