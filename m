From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] Input: define KEY_WWAN for Wireless WAN
Date: Thu, 28 Nov 2013 19:42:53 +0100
Message-ID: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:34574 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181Ab3K1Sm7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 13:42:59 -0500
Received: by mail-ea0-f172.google.com with SMTP id q10so6012157ead.17
        for <linux-input@vger.kernel.org>; Thu, 28 Nov 2013 10:42:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>

Some devices with support for mobile networks may have buttons for
enabling/disabling such connection. An example can be Linksys router
54G3G.
We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB so it makes sense
to add KEY_WWAN as well.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
---
 include/uapi/linux/input.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 4649ee3..173d77f 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -749,6 +749,8 @@ struct input_keymap_entry {
 #define BTN_TRIGGER_HAPPY39		0x2e6
 #define BTN_TRIGGER_HAPPY40		0x2e7
=20
+#define KEY_WWAN			0x2e8	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
+
 /* We avoid low common keys in module aliases so they don't get huge. =
*/
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
