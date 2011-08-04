From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] HID: ACRUX - fix enabling force feedback support
Date: Thu,  4 Aug 2011 00:25:56 -0700
Message-ID: <1312442757-31241-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63711 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab1HDH0I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 03:26:08 -0400
Received: by gxk21 with SMTP id 21so896521gxk.19
        for <linux-input@vger.kernel.org>; Thu, 04 Aug 2011 00:26:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Sergei Kolzun <x0r@dv-life.ru>

From: Sergei Kolzun <x0r@dv-life.ru>

The config option needs to be a 'bool' and not a tristate, otheriwse
force feedback support never makes it into the module.

Signed-off-by: Sergei Kolzun <x0r@dv-life.ru>
Cc: stable@kernel.org
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/hid/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 36ca465..a1f3c0d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -69,7 +69,7 @@ config HID_ACRUX
 	Say Y here if you want to enable support for ACRUX game controllers.
 
 config HID_ACRUX_FF
-	tristate "ACRUX force feedback support"
+	bool "ACRUX force feedback support"
 	depends on HID_ACRUX
 	select INPUT_FF_MEMLESS
 	---help---
-- 
1.7.6

