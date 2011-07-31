From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: PATCH [5/6] HID: lg4ff - Fix misleading info in Kconfig
Date: Sun, 31 Jul 2011 03:16:35 +0200
Message-ID: <1673772.0oVoeiCyg0@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54910 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1GaBQi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 21:16:38 -0400
Received: by fxh19 with SMTP id 19so3416332fxh.19
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2011 18:16:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, simon@mungewell.org

The description of lg4ff driver has to be changed to reflect the fact t=
hat the driver now handles a lot more Logitech wheel than just=20
the Wii. Entry in Kconfig has been renamed to LOGIWHEELS_FF.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 306b15f..6ae234f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -278,13 +278,20 @@ config LOGIG940_FF
 	  Say Y here if you want to enable force feedback support for Logitec=
h
 	  Flight System G940 devices.
=20
-config LOGIWII_FF
-	bool "Logitech Speed Force Wireless force feedback support"
+config LOGIWHEELS_FF
+	bool "Logitech wheels configuration and force feedback support"
 	depends on HID_LOGITECH
 	select INPUT_FF_MEMLESS
 	help
-	  Say Y here if you want to enable force feedback support for Logitec=
h
-	  Speed Force Wireless (Wii) devices.
+	  Say Y here if you want to enable force feedback and range setting
+	  support for following Logitech wheels:
+	  - Logitech Driving Force
+	  - Logitech Driving Force Pro
+	  - Logitech Driving Force GT
+	  - Logitech G25
+	  - Logitech G27
+	  - Logitech MOMO/MOMO 2
+	  - Logitech Formula Force EX
=20
 config HID_MAGICMOUSE
 	tristate "Apple MagicMouse multi-touch support"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0a0a38e..77c9e5d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -21,7 +21,7 @@ endif
 ifdef CONFIG_LOGIG940_FF
 	hid-logitech-y	+=3D hid-lg3ff.o
 endif
-ifdef CONFIG_LOGIWII_FF
+ifdef CONFIG_LOGIWHEELS_FF
 	hid-logitech-y	+=3D hid-lg4ff.o
 endif
=20
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index 3a32959..4b09728 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -19,7 +19,7 @@ int lg3ff_init(struct hid_device *hdev);
 static inline int lg3ff_init(struct hid_device *hdev) { return -1; }
 #endif
=20
-#ifdef CONFIG_LOGIWII_FF
+#ifdef CONFIG_LOGIWHEELS_FF
 int lg4ff_init(struct hid_device *hdev);
 int lg4ff_deinit(struct hid_device *hdev);
 #else

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
