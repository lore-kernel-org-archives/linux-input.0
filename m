From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [RFC][PATCH] Input: define keys for WWAN and SES
Date: Thu, 28 Nov 2013 12:48:13 +0100
Message-ID: <1385639293-23225-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:36744 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab3K1LsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 06:48:19 -0500
Received: by mail-ea0-f178.google.com with SMTP id d10so5611290eaj.23
        for <linux-input@vger.kernel.org>; Thu, 28 Nov 2013 03:48:18 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>

This is just a RFC, so be nice to this "patch", please ;)

My goal is to add support for buttons on bcm47xx arch. However after
analyzing existing database of devices I realized I don't know what code
I should assign to some buttons.

First of all, older routers often have a "SES" button. SES stands for
SecureEasySetup and is Broadcom's proprietary protocol which was later
replaced with WPS (Wi-Fi Protected Setup).
Btw. WPS appeared to be broken because it's easy to attack it with
brutal-force method. I'm not sure if any distribution have any interest
in using that buttons, but it still would be nice to have support for
them in kernel. One option is to add KEY_SES for this purpose.
Is this the right way? It's similar to the KEY_WPS_BUTTON, but I wanted
to somehow distinct them. Is there any other option? Should I use
KEY_UNKNOWN or BTN_MISC or BTN_n?

Another thing is WWAN key. Some routers support mobile networks (for
example Linksys 54G3G) and they may have button for enabling/disabling
such connection. We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB,
but nothing for WWAN device control. I guess in future KEY_WWAN could
be also supported in rfkill by mapping it to the RFKILL_TYPE_WWAN.

What do you think about this?
---
 include/uapi/linux/input.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 4649ee3..a06c8bf 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -749,6 +749,9 @@ struct input_keymap_entry {
 #define BTN_TRIGGER_HAPPY39		0x2e6
 #define BTN_TRIGGER_HAPPY40		0x2e7
 
+#define KEY_WWAN			0x2e8	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
+#define KEY_SES				0x2e9	/* SecureEasySetup */
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
-- 
1.7.10.4

