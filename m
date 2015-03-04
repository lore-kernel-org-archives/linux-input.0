From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH v2 1/2] Add alias KEY_ROTATE_DISPLAY for KEY_DIRECTION, add description
Date: Thu, 5 Mar 2015 00:31:09 +0100
Message-ID: <41beb348-6e52-44bf-923b-68d552ef328b@HUB2.rwth-ad.de>
References: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
 <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:56994 "EHLO
	mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbCDXbW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 18:31:22 -0500
In-Reply-To: <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>

Signed-off-by: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
---
 include/uapi/linux/input.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a1d7e93..47b0138 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -368,7 +368,8 @@ struct input_keymap_entry {
 #define KEY_MSDOS		151
 #define KEY_COFFEE		152	/* AL Terminal Lock/Screensaver */
 #define KEY_SCREENLOCK		KEY_COFFEE
-#define KEY_DIRECTION		153
+#define KEY_DIRECTION		153	/* Display orientation for e.g. tablets */
+#define KEY_ROTATE_DISPLAY	KEY_DIRECTION
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
