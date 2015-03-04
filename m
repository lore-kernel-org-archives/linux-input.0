From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH] Add short KEY_DIRECTION description
Date: Wed, 4 Mar 2015 22:42:39 +0100
Message-ID: <a7e525e6-b0a2-4329-99fd-21c0af989d8e@HUB1.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:52801 "EHLO
	mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbbCDVwX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 16:52:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>

Signed-off-by: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
---
Requested 5 years ago: https://lkml.org/lkml/2010/2/27/36
See also http://comments.gmane.org/gmane.linux.kernel.input/11175

 include/uapi/linux/input.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a1d7e93..0655300 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -368,7 +368,7 @@ struct input_keymap_entry {
 #define KEY_MSDOS		151
 #define KEY_COFFEE		152	/* AL Terminal Lock/Screensaver */
 #define KEY_SCREENLOCK		KEY_COFFEE
-#define KEY_DIRECTION		153
+#define KEY_DIRECTION		153     /* Display orientation for e.g. tablets=
 */
 #define KEY_CYCLEWINDOWS	154
 #define KEY_MAIL		155
 #define KEY_BOOKMARKS		156	/* AC Bookmarks */
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
