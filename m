From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 3/3] HID:Kconfig: Correct MOMO description in wrong place (handled by LG4FF).
Date: Wed,  9 Oct 2013 18:04:47 -0600
Message-ID: <1381363487-2167-3-git-send-email-simon@mungewell.org>
References: <1381363487-2167-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:51710 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab3JJAFG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 20:05:06 -0400
In-Reply-To: <1381363487-2167-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, Elias Vanderstuyft <elias.vds@gmail.com>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@prifuk.cz>


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

