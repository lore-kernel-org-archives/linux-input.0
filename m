From: Simon Wood <simon@mungewell.org>
Subject: [PATCHv2 3/3] HID:Kconfig: Correct MOMO description in wrong place (handled by LG4FF).
Date: Thu, 10 Oct 2013 08:20:14 -0600
Message-ID: <1381414814-2107-3-git-send-email-simon@mungewell.org>
References: <alpine.LNX.2.00.1310101002120.13289@pobox.suse.cz>
 <1381414814-2107-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:58978 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab3JJOUc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 10:20:32 -0400
In-Reply-To: <1381414814-2107-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, Elias Vanderstuyft <elias.vds@gmail.com>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@prifuk.cz>

Minor correction to the description in Kconfig.

The Logitect MOMO wheel is actually handled by the LOGITECH_WHEELS (hid-lg4ff) 
section, not by the LOGITECH_FF (hid-lgff).

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 46fd27f..aee7182 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -362,7 +362,6 @@ config LOGITECH_FF
 	  - Logitech WingMan Force 3D
 	  - Logitech Formula Force EX
 	  - Logitech WingMan Formula Force GP
-	  - Logitech MOMO Force wheel
 
 	  and if you want to enable force feedback for them.
 	  Note: if you say N here, this device will still be supported, but without
-- 
1.8.1.2

