From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] HID: drop remove Unicode non-breaking space from Kconfig
Date: Tue, 10 Jun 2014 14:35:36 -0700
Message-ID: <1402436136-17918-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:41627 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbaFJVf4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jun 2014 17:35:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Brian Norris <computersforpeace@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

There is a UTF-8 non-breaking space character (0xc2 0xa0) after the "Y"
in "Say Y here". This is probably not intentional. Replace it with a
standard ASCII space (0x20).

If you can't see a difference here, I don't blame you :)

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 800c8b60f7a2..08c9693e6f83 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -785,7 +785,7 @@ config HID_XINMO
 	depends on HID
 	---help---
 	Support for Xin-Mo devices that are not fully compliant with the HID
-	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y=C2=A0=
here
+	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
 	if you have a Xin-Mo Dual Arcade controller.
=20
 config HID_ZEROPLUS
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
