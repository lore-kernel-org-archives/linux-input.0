From: Alessandro Guido <ag@alessandroguido.name>
Subject: [PATCH] Remove duplicate Kconfig entry for HID_PANTHERLORD
Date: Thu, 17 Sep 2009 15:42:57 +0200
Message-ID: <4AB23CE1.8030806@alessandroguido.name>
References: <1253191090-23675-1-git-send-email-ag@alessandroguido.name> <alpine.LNX.2.00.0909171526360.17028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:42667 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZIQNsm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2009 09:48:42 -0400
Received: by fxm17 with SMTP id 17so35023fxm.37
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 06:48:45 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0909171526360.17028@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Signed-off-by: Alessandro Guido <ag@alessandroguido.name>

---
  drivers/hid/Kconfig |    7 -------
  1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 111afbe..24d90ea 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -205,13 +205,6 @@ config HID_NTRIG
  	Support for N-Trig touch screen.
   config HID_PANTHERLORD
-	tristate "Pantherlord devices support" if EMBEDDED
-	depends on USB_HID
-	default !EMBEDDED
-	---help---
-	Support for PantherLord/GreenAsia based device support.
-
-config HID_PANTHERLORD
  	tristate "Pantherlord support" if EMBEDDED
  	depends on USB_HID
  	default !EMBEDDED

