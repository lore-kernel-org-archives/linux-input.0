From: miguel.aguilar@ridgerun.com
Subject: [PATCH 3/3] DaVinci: DM365: Enable Key Scan in defconfig
Date: Thu, 24 Sep 2009 10:54:20 -0600
Message-ID: <1253811260-21466-1-git-send-email-miguel.aguilar@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:60838 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbZIXQyV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 12:54:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>


Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/configs/davinci_all_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index ec63c15..e994c83 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -763,6 +763,7 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_KEYBOARD_STOWAWAY is not set
 # CONFIG_KEYBOARD_SUNKBD is not set
 CONFIG_KEYBOARD_XTKBD=m
+CONFIG_KEYBOARD_DAVINCI_DM365=m
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-- 
1.6.0.4

