From: Jerone Young <jerone.young@gmail.com>
Subject: [PATCH] Add keycode for microphone mute key
Date: Fri, 22 Apr 2011 21:14:49 -0500
Message-ID: <1303524889.2457.24.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55722 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074Ab1DWCOx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2011 22:14:53 -0400
Received: by yia27 with SMTP id 27so263879yia.19
        for <linux-input@vger.kernel.org>; Fri, 22 Apr 2011 19:14:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>

Lenovo is now including a key for muting the microphone on all Thinkpad
models & peripheral keyboards. Currently there is no way to deal with
this key being handled in a common fashion under Linux. This patch
defines a key code for microphone mute so that this key can be mapped
for Thinkpad models & peripheral keyboards.

By having a set keycode this key can be remapped to the common keycode
and userspace can then listen and take some action once the key is
pressed. A common action would be to mute the microphone mixer. 

Thinkpad keyboard pic: http://bit.ly/hLxXL1
Thinkpad usb keyboard pic: http://bit.ly/gfNaQz

Signed-off-by: Jerone Young <jerone.young@gmail.com>

diff --git a/include/linux/input.h b/include/linux/input.h
index 771d6d8..4d8a8ae 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -673,6 +673,8 @@ struct input_keymap_entry {
 #define KEY_CAMERA_LEFT		0x219
 #define KEY_CAMERA_RIGHT	0x21a
 
+#define KEY_MICROPHONE_MUTE	0x21b	/* microphone mute key */
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1



