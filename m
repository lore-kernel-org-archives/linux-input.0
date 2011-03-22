From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH/TRIVIAL] HID: Fix typo Keyoutch -> Keytouch
Date: Tue, 22 Mar 2011 02:29:17 -0700
Message-ID: <1300786157-29746-1-git-send-email-bebarino@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34423 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1CVJ3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2011 05:29:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 drivers/hid/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index b7ec405..7c28ad9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -185,7 +185,7 @@ config HID_EZKEY
 	Support for Ezkey BTC 8193 keyboard.
 
 config HID_KEYTOUCH
-	tristate "Keyoutch HID devices"
+	tristate "Keytouch HID devices"
 	depends on USB_HID
 	---help---
 	Support for Keytouch HID devices not fully compliant with
-- 
1.7.4.1.343.ga91df

