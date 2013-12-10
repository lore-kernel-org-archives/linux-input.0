From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] Input: define KEY_WWAN for Wireless WAN
Date: Tue, 10 Dec 2013 11:29:09 +0100
Message-ID: <1386671349-16337-1-git-send-email-zajec5@gmail.com>
References: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:54499 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3LJK3T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 05:29:19 -0500
Received: by mail-ea0-f182.google.com with SMTP id a15so2144041eae.13
        for <linux-input@vger.kernel.org>; Tue, 10 Dec 2013 02:29:17 -0800 (PST)
In-Reply-To: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>

Some devices with support for mobile networks may have buttons for
enabling/disabling such connection. An example can be Linksys router
54G3G.
We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB so it makes sense
to add KEY_WWAN as well.
As we already have KEY_WIMAX, use it's value for KEY_WWAN and make it a=
n
alias.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
---
V2: Re-use 246 value for WWAN and make WIMAX an aliast to WWAN
---
 include/uapi/linux/input.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a372627..7c69941 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -464,7 +464,8 @@ struct input_keymap_entry {
 #define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
 #define KEY_DISPLAY_OFF		245	/* display device to off state */
=20
-#define KEY_WIMAX		246
+#define KEY_WWAN		246	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
+#define KEY_WIMAX		KEY_WWAN
 #define KEY_RFKILL		247	/* Key that controls all radios */
=20
 #define KEY_MICMUTE		248	/* Mute / unmute the microphone */
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
