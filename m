Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A5221FCD
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112684; cv=none; b=qiAUtmIykABzUc9JcEmOaQVLHSMw9rWpU2jS5HF8IiTpxLq1LWsWGr/sIEQHeyfGgPbfXja48wovcpnUllWy75jLSaIdV42NzGOSXaPafn11l62CeElbRxhToY4gbzm1xIsJDrZGzWGVRXhQRuugqcrb/6tCdlggVWcnlYq9T58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112684; c=relaxed/simple;
	bh=CFbS1EHpimalLgG3Gb675zA5golDUNn1TxzJLtF6jKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bsfo1/JC+4FLVlB1hQgBBmCxa4qjuOv1/itrf0EZC00UbPuA9sC+mUKArlxYjpzxI//Uqbv+bI9gApzY5uKbUG1+kbOzitU6Tocn+o8jIQiLPOEvv+33BIjv83KBbRRn4/WPHQKXkKSWx4RCgG4nkm8Ki+gr5Cu0yFu8d96rxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh+XaWJr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh+XaWJr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2869406b3a.1
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785112681; x=1785717481; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crWoGk6a2nyOeanrrIAaE3c9U5QAi76eR9/Temfhkro=;
        b=Rh+XaWJrMFOS+mwIoR+3xGIrsxDrx/cKQNz3GrmwwWUJwu3Za23k8W80ROWlulTlHL
         zQUlogKZ44YHgxlsME8kRofNel6AadZfZOSFG9115Ns8j7yLwRiNX9tZWmnWSrVoySNv
         ZGuj31HoBDqtdFE5dCEkl7P3xZQMsGOe2O8SJ/RFnWXliU+6fLlhdwfPHNyrDlhYfBk/
         7gRDBSGPtW78fImxw17sKP7vl/0lBmww0rYSikIvbK+8W5tCA+jwSQd8DCQ56GDzFAPj
         eDA/ytlnWP938HjkaXpWspO2yH5qB6Afz5qrYQd2RXLvFw80S/BqDBULz/Zk8CDkIOdd
         JhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112681; x=1785717481;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crWoGk6a2nyOeanrrIAaE3c9U5QAi76eR9/Temfhkro=;
        b=jfG8GSvmGRsuKWvAJoYwLahWEGLX8o+dOCcZGw1Zk9d1DW3F+hXHcw11QiwODvEav9
         JVkiRib/C3PoYqEZJfZ+N3Hd7N4fW2lWfsHVeMudFd/VGANspeATocuD1KrhPr/+CEw6
         S1XJJ1e7FDcMyGh+PCNIJmCDzRq3LptYcyCXQQebZN6TjsGiEqxtMml0UcJXRH3xzChd
         JcyoWA0amvRD5sCGbFkqLRbQtL+VnBJVUy+F1u0k2JH3XpGSaCR33fRdI/MGWuvYzsrF
         cnQFuFzlcqx+VHnf1xnqRbMqsuXdtpEWDbZOI7Zy35HpG/rNP5J/pNh4dX7HEqC94lBu
         ptBw==
X-Forwarded-Encrypted: i=1; AHgh+RrRXbCaauuCWAc31/wE2H1JIqCtKYTZmx/AxVD7eOMZwQYPO8hzGl/Y8PduP7VlmIT1tCDpELH/UCWYgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVlGf2lrra2dUyE1qZlqr2duOhpTL2YIV5Qq5qOj4BByQ7YMQ
	ki6khcoLe5keq2VBjQrp6r5WaP3ah++joQHeLaXQzKO1tPGTcZGLpON8
X-Gm-Gg: AR+sD12YJpv1i2/m3sRDFQQqAtlDH/ENVVU8KINIrPjUOoUI5pdP192PelOZrC3XUFS
	ntx/F6lHboiYvabqKHUyOEmpz2Q+d6VjGJjWdPPPLYPzs+cW+NI4L4yOhQo0sPPRQtQQhM3SZdq
	5E2KPBBUVlibPHH7IpzBIRFczWBXodfKtit0kZREcDMcA1+n+zy+ijW6qbmY4zD0MzlsfR3VN7g
	4IfvYoe6hnXDqD81chWhSp+MG7x9HrTaCnDQWBJ0C4phqwwTGsuUlVsglyAtCiNuqi1GcVe6nuE
	R2BmqRRkfMGp0wWsEaZ4f/h1vycm93Kh74ah1ozIlVUhzkWitWl1NUIrNr1aiTtoJ9IAgNNH3ER
	R2eVrdRt6hAhiV5l4bvxZU6BwLTUOI2KuWnGQEjim8uWYZBzIt926OI1Mhd85eCaWPvwMF9J6Oo
	X7fpS+sNWZZkPqvpWpm/d0islNSbYbwgyh3GCkE/SoAHI=
X-Received: by 2002:a05:6a21:2d4b:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3c6723e0acbmr8486529637.12.1785112680591;
        Sun, 26 Jul 2026 17:38:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm40536951eec.13.2026.07.26.17.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 17:37:59 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:37:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-parisc@vger.kernel.org
Subject: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via device
 property
Message-ID: <amaJEXxiKjghv0F0@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Instead of hardcoding PA-RISC specific keycode tables into atkbd via
compile-time inclusion, have the gscps2 PS/2 port driver attach a
"linux,keymap" software node device property to the serio device when
a keyboard port is registered. This allows atkbd to dynamically fetch
and apply the custom keymap when probing the port using generic
firmware property helpers, removing architecture-specific hacks from
generic keyboard driver code.

Co-locate the keymap definitions with the serio port driver by moving
hpps2atkbd.h from drivers/input/keyboard/ to drivers/input/serio/.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/Kconfig      |  38 ----------
 drivers/input/keyboard/atkbd.c      |   8 --
 drivers/input/keyboard/hpps2atkbd.h | 110 ----------------------------
 drivers/input/serio/Kconfig         |  27 +++++++
 drivers/input/serio/gscps2.c        |  27 +++++--
 drivers/input/serio/hpps2atkbd.h    | 108 +++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 164 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 9d1019ba0245..d8c64f333462 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -119,44 +119,6 @@ config KEYBOARD_ATKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called atkbd.
 
-config KEYBOARD_ATKBD_HP_KEYCODES
-	bool "Use HP keyboard scancodes"
-	depends on PARISC && KEYBOARD_ATKBD
-	default y
-	help
-	  Say Y here if you have a PA-RISC machine and want to use an AT or
-	  PS/2 keyboard, and your keyboard uses keycodes that are specific to
-	  PA-RISC keyboards.
-
-	  Say N if you use a standard keyboard.
-
-config KEYBOARD_ATKBD_RDI_KEYCODES
-	bool "Use PrecisionBook keyboard scancodes"
-	depends on KEYBOARD_ATKBD_HP_KEYCODES
-	default n
-	help
-	  If you have an RDI PrecisionBook, say Y here if you want to use its
-	  built-in keyboard (as opposed to an external keyboard).
-
-	  The PrecisionBook has five keys that conflict with those used by most
-	  AT and PS/2 keyboards. These are as follows:
-
-	    PrecisionBook    Standard AT or PS/2
-
-	    F1               F12
-	    Left Ctrl        Left Alt
-	    Caps Lock        Left Ctrl
-	    Right Ctrl       Caps Lock
-	    Left             102nd key (the key to the right of Left Shift)
-
-	  If you say N here, and use the PrecisionBook keyboard, then each key
-	  in the left-hand column will be interpreted as the corresponding key
-	  in the right-hand column.
-
-	  If you say Y here, and use an external keyboard, then each key in the
-	  right-hand column will be interpreted as the key shown in the
-	  left-hand column.
-
 config KEYBOARD_QT1050
 	tristate "Microchip AT42QT1050 Touch Sensor Chip"
 	depends on I2C
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 8cb4dc6fb165..3509b58e6492 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -73,13 +73,6 @@ MODULE_PARM_DESC(terminal, "Enable break codes on an IBM Terminal keyboard conne
 #define ATKBD_KEYMAP_SIZE	512
 
 static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
-#ifdef CONFIG_KEYBOARD_ATKBD_HP_KEYCODES
-
-/* XXX: need a more general approach */
-
-#include "hpps2atkbd.h"	/* include the keyboard scancodes */
-
-#else
 	  0, 67, 65, 63, 61, 59, 60, 88,183, 68, 66, 64, 62, 15, 41,117,
 	184, 56, 42, 93, 29, 16,  2,  0,185,  0, 44, 31, 30, 17,  3,  0,
 	186, 46, 45, 32, 18,  5,  4, 95,187, 57, 47, 33, 20, 19,  6,183,
@@ -99,7 +92,6 @@ static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
 	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
 
 	  0,  0,  0, 65, 99,
-#endif
 };
 
 static const unsigned short atkbd_set3_keycode[ATKBD_KEYMAP_SIZE] = {
diff --git a/drivers/input/keyboard/hpps2atkbd.h b/drivers/input/keyboard/hpps2atkbd.h
deleted file mode 100644
index dc33f6945222..000000000000
--- a/drivers/input/keyboard/hpps2atkbd.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * drivers/input/keyboard/hpps2atkbd.h
- *
- * Copyright (c) 2004 Helge Deller <deller@gmx.de>
- * Copyright (c) 2002 Laurent Canet <canetl@esiee.fr>
- * Copyright (c) 2002 Thibaut Varene <varenet@parisc-linux.org>
- * Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
- *
- * HP PS/2 AT-compatible Keyboard, found in PA/RISC Workstations & Laptops
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-
-/* Is the keyboard an RDI PrecisionBook? */
-#ifndef CONFIG_KEYBOARD_ATKBD_RDI_KEYCODES
-# define CONFLICT(x,y) x
-#else
-# define CONFLICT(x,y) y
-#endif
-
-/* sadly RDI (Tadpole) decided to ship a different keyboard layout
-   than HP for their PS/2 laptop keyboard which leads to conflicting
-   keycodes between a normal HP PS/2 keyboard and a RDI Precisionbook.
-                                HP:		RDI:            */
-#define C_07	CONFLICT(	KEY_F12,	KEY_F1		)
-#define C_11	CONFLICT(	KEY_LEFTALT,	KEY_LEFTCTRL	)
-#define C_14	CONFLICT(	KEY_LEFTCTRL,	KEY_CAPSLOCK	)
-#define C_58	CONFLICT(	KEY_CAPSLOCK,	KEY_RIGHTCTRL	)
-#define C_61	CONFLICT(	KEY_102ND,	KEY_LEFT	)
-
-/* Raw SET 2 scancode table */
-
-/* 00 */  KEY_RESERVED, KEY_F9,        KEY_RESERVED,  KEY_F5,        KEY_F3,        KEY_F1,       KEY_F2,        C_07,
-/* 08 */  KEY_ESC,      KEY_F10,       KEY_F8,        KEY_F6,        KEY_F4,        KEY_TAB,      KEY_GRAVE,     KEY_F2,
-/* 10 */  KEY_RESERVED, C_11,          KEY_LEFTSHIFT, KEY_RESERVED,  C_14,          KEY_Q,        KEY_1,         KEY_F3,
-/* 18 */  KEY_RESERVED, KEY_LEFTALT,   KEY_Z,         KEY_S,         KEY_A,         KEY_W,        KEY_2,         KEY_F4,
-/* 20 */  KEY_RESERVED, KEY_C,         KEY_X,         KEY_D,         KEY_E,         KEY_4,        KEY_3,         KEY_F5,
-/* 28 */  KEY_RESERVED, KEY_SPACE,     KEY_V,         KEY_F,         KEY_T,         KEY_R,        KEY_5,         KEY_F6,
-/* 30 */  KEY_RESERVED, KEY_N,         KEY_B,         KEY_H,         KEY_G,         KEY_Y,        KEY_6,         KEY_F7,
-/* 38 */  KEY_RESERVED, KEY_RIGHTALT,  KEY_M,         KEY_J,         KEY_U,         KEY_7,        KEY_8,         KEY_F8,
-/* 40 */  KEY_RESERVED, KEY_COMMA,     KEY_K,         KEY_I,         KEY_O,         KEY_0,        KEY_9,         KEY_F9,
-/* 48 */  KEY_RESERVED, KEY_DOT,       KEY_SLASH,     KEY_L,         KEY_SEMICOLON, KEY_P,        KEY_MINUS,     KEY_F10,
-/* 50 */  KEY_RESERVED, KEY_RESERVED,  KEY_APOSTROPHE,KEY_RESERVED,  KEY_LEFTBRACE, KEY_EQUAL,    KEY_F11,       KEY_SYSRQ,
-/* 58 */  C_58,         KEY_RIGHTSHIFT,KEY_ENTER,     KEY_RIGHTBRACE,KEY_BACKSLASH, KEY_BACKSLASH,KEY_F12,       KEY_SCROLLLOCK,
-/* 60 */  KEY_DOWN,     C_61,          KEY_PAUSE,     KEY_UP,        KEY_DELETE,    KEY_END,      KEY_BACKSPACE, KEY_INSERT,
-/* 68 */  KEY_RESERVED, KEY_KP1,       KEY_RIGHT,     KEY_KP4,       KEY_KP7,       KEY_PAGEDOWN, KEY_HOME,      KEY_PAGEUP,
-/* 70 */  KEY_KP0,      KEY_KPDOT,     KEY_KP2,       KEY_KP5,       KEY_KP6,       KEY_KP8,      KEY_ESC,       KEY_NUMLOCK,
-/* 78 */  KEY_F11,      KEY_KPPLUS,    KEY_KP3,       KEY_KPMINUS,   KEY_KPASTERISK,KEY_KP9,      KEY_SCROLLLOCK,KEY_102ND,
-/* 80 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 88 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 90 */  KEY_RESERVED, KEY_RIGHTALT,  255,           KEY_RESERVED,  KEY_RIGHTCTRL, KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 98 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_CAPSLOCK, KEY_RESERVED,  KEY_LEFTMETA,
-/* a0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RIGHTMETA,
-/* a8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_COMPOSE,
-/* b0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* b8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* c0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* c8 */  KEY_RESERVED, KEY_RESERVED,  KEY_KPSLASH,   KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* d0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* d8 */  KEY_RESERVED, KEY_RESERVED,  KEY_KPENTER,   KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* e0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* e8 */  KEY_RESERVED, KEY_END,       KEY_RESERVED,  KEY_LEFT,      KEY_HOME,      KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* f0 */  KEY_INSERT,   KEY_DELETE,    KEY_DOWN,      KEY_RESERVED,  KEY_RIGHT,     KEY_UP,       KEY_RESERVED,  KEY_PAUSE,
-/* f8 */  KEY_RESERVED, KEY_RESERVED,  KEY_PAGEDOWN,  KEY_RESERVED,  KEY_SYSRQ,     KEY_PAGEUP,   KEY_RESERVED,  KEY_RESERVED,
-
-/* These are offset for escaped keycodes: */
-
-/* 00 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_F7,        KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 08 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_LEFTMETA,  KEY_RIGHTMETA, KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 10 */  KEY_RESERVED, KEY_RIGHTALT,  KEY_RESERVED,  KEY_RESERVED,  KEY_RIGHTCTRL, KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 18 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 20 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 28 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 30 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 38 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 40 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 48 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 50 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 58 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 60 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 68 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 70 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 78 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 80 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 88 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 90 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* 98 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* a0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* a8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* b0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* b8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* c0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* c8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* d0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* d8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* e0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* e8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* f0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
-/* f8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED
-
-#undef CONFLICT
-#undef C_07
-#undef C_11
-#undef C_14
-#undef C_58
-#undef C_61
-
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index bacab1f58400..087f0203fff9 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -106,6 +106,33 @@ config SERIO_GSCPS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called gscps2.
 
+config SERIO_GSCPS2_RDI_KEYCODES
+	bool "Use PrecisionBook keyboard scancodes"
+	depends on SERIO_GSCPS2
+	default n
+	help
+	  If you have an RDI PrecisionBook, say Y here if you want to use its
+	  built-in keyboard (as opposed to an external keyboard).
+
+	  The PrecisionBook has five keys that conflict with those used by most
+	  AT and PS/2 keyboards. These are as follows:
+
+	    PrecisionBook    Standard AT or PS/2
+
+	    F1               F12
+	    Left Ctrl        Left Alt
+	    Caps Lock        Left Ctrl
+	    Right Ctrl       Caps Lock
+	    Left             102nd key (the key to the right of Left Shift)
+
+	  If you say N here, and use the PrecisionBook keyboard, then each key
+	  in the left-hand column will be interpreted as the corresponding key
+	  in the right-hand column.
+
+	  If you say Y here, and use an external keyboard, then each key in the
+	  right-hand column will be interpreted as the key shown in the
+	  left-hand column.
+
 config HP_SDC
 	tristate "HP System Device Controller i8042 Support"
 	depends on (GSC || HP300) && SERIO
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index bf9b993f5733..f4a4afde35c9 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -22,20 +22,19 @@
  *                 was usable/enabled ?)
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/serio.h>
+#include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/property.h>
+#include <linux/serio.h>
 
 #include <asm/irq.h>
-#include <asm/io.h>
 #include <asm/parisc-device.h>
 
+#include "hpps2atkbd.h"
+
 MODULE_AUTHOR("Laurent Canet <canetl@esiee.fr>, Thibaut Varene <varenet@parisc-linux.org>, Helge Deller <deller@gmx.de>");
 MODULE_DESCRIPTION("HP GSC PS2 port driver");
 MODULE_LICENSE("GPL");
@@ -398,6 +397,17 @@ static int __init gscps2_probe(struct parisc_device *dev)
 		goto fail;
 #endif
 
+	if (ps2port->id == GSC_ID_KEYBOARD) {
+		ret = device_create_managed_software_node(&serio->dev,
+							  gscps2_props, NULL);
+		if (ret) {
+			dev_err(&dev->dev,
+				"failed to add software node for keyboard: %d\n",
+				ret);
+			goto fail;
+		}
+	}
+
 	pr_info("serio: %s port at 0x%08lx irq %d @ %s\n",
 		ps2port->port->name,
 		hpa,
@@ -415,7 +425,9 @@ static int __init gscps2_probe(struct parisc_device *dev)
 
 fail_miserably:
 	iounmap(ps2port->addr);
+#if 0
 	release_mem_region(dev->hpa.start, GSC_STATUS + 4);
+#endif
 
 fail_nomem:
 	kfree(ps2port);
@@ -477,4 +489,3 @@ static void __exit gscps2_exit(void)
 
 module_init(gscps2_init);
 module_exit(gscps2_exit);
-
diff --git a/drivers/input/serio/hpps2atkbd.h b/drivers/input/serio/hpps2atkbd.h
new file mode 100644
index 000000000000..d110070693b6
--- /dev/null
+++ b/drivers/input/serio/hpps2atkbd.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * HP PS/2 AT-compatible Keyboard, found in PA/RISC Workstations & Laptops
+ *
+ * Copyright (c) 2004 Helge Deller <deller@gmx.de>
+ * Copyright (c) 2002 Laurent Canet <canetl@esiee.fr>
+ * Copyright (c) 2002 Thibaut Varene <varenet@parisc-linux.org>
+ * Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
+ */
+
+#ifndef CONFIG_SERIO_GSCPS2_RDI_KEYCODES
+# define CONFLICT(x, y) x
+#else
+# define CONFLICT(x, y) y
+#endif
+
+/*
+ * Sadly RDI (Tadpole) decided to ship a different keyboard layout
+ * than HP for their PS/2 laptop keyboard which leads to conflicting
+ * keycodes between a normal HP PS/2 keyboard and a RDI PrecisionBook.
+ *                             HP:           RDI:
+ */
+#define C_07	CONFLICT(	KEY_F12,	KEY_F1		)
+#define C_11	CONFLICT(	KEY_LEFTALT,	KEY_LEFTCTRL	)
+#define C_14	CONFLICT(	KEY_LEFTCTRL,	KEY_CAPSLOCK	)
+#define C_58	CONFLICT(	KEY_CAPSLOCK,	KEY_RIGHTCTRL	)
+#define C_61	CONFLICT(	KEY_102ND,	KEY_LEFT	)
+
+#define KEYMAP_ENTRY(scancode, keycode) (((scancode) << 16) | (keycode))
+
+static const u32 gscps2_keymap[] = {
+	KEYMAP_ENTRY(0x01, KEY_F9),		KEYMAP_ENTRY(0x03, KEY_F5),
+	KEYMAP_ENTRY(0x04, KEY_F3),		KEYMAP_ENTRY(0x05, KEY_F1),
+	KEYMAP_ENTRY(0x06, KEY_F2),		KEYMAP_ENTRY(0x07, C_07),
+	KEYMAP_ENTRY(0x08, KEY_ESC),		KEYMAP_ENTRY(0x09, KEY_F10),
+	KEYMAP_ENTRY(0x0a, KEY_F8),		KEYMAP_ENTRY(0x0b, KEY_F6),
+	KEYMAP_ENTRY(0x0c, KEY_F4),		KEYMAP_ENTRY(0x0d, KEY_TAB),
+	KEYMAP_ENTRY(0x0e, KEY_GRAVE),		KEYMAP_ENTRY(0x0f, KEY_F2),
+	KEYMAP_ENTRY(0x11, C_11),		KEYMAP_ENTRY(0x12, KEY_LEFTSHIFT),
+	KEYMAP_ENTRY(0x14, C_14),		KEYMAP_ENTRY(0x15, KEY_Q),
+	KEYMAP_ENTRY(0x16, KEY_1),		KEYMAP_ENTRY(0x17, KEY_F3),
+	KEYMAP_ENTRY(0x19, KEY_LEFTALT),	KEYMAP_ENTRY(0x1a, KEY_Z),
+	KEYMAP_ENTRY(0x1b, KEY_S),		KEYMAP_ENTRY(0x1c, KEY_A),
+	KEYMAP_ENTRY(0x1d, KEY_W),		KEYMAP_ENTRY(0x1e, KEY_2),
+	KEYMAP_ENTRY(0x1f, KEY_F4),		KEYMAP_ENTRY(0x21, KEY_C),
+	KEYMAP_ENTRY(0x22, KEY_X),		KEYMAP_ENTRY(0x23, KEY_D),
+	KEYMAP_ENTRY(0x24, KEY_E),		KEYMAP_ENTRY(0x25, KEY_4),
+	KEYMAP_ENTRY(0x26, KEY_3),		KEYMAP_ENTRY(0x27, KEY_F5),
+	KEYMAP_ENTRY(0x29, KEY_SPACE),		KEYMAP_ENTRY(0x2a, KEY_V),
+	KEYMAP_ENTRY(0x2b, KEY_F),		KEYMAP_ENTRY(0x2c, KEY_T),
+	KEYMAP_ENTRY(0x2d, KEY_R),		KEYMAP_ENTRY(0x2e, KEY_5),
+	KEYMAP_ENTRY(0x2f, KEY_F6),		KEYMAP_ENTRY(0x31, KEY_N),
+	KEYMAP_ENTRY(0x32, KEY_B),		KEYMAP_ENTRY(0x33, KEY_H),
+	KEYMAP_ENTRY(0x34, KEY_G),		KEYMAP_ENTRY(0x35, KEY_Y),
+	KEYMAP_ENTRY(0x36, KEY_6),		KEYMAP_ENTRY(0x37, KEY_F7),
+	KEYMAP_ENTRY(0x39, KEY_RIGHTALT),	KEYMAP_ENTRY(0x3a, KEY_M),
+	KEYMAP_ENTRY(0x3b, KEY_J),		KEYMAP_ENTRY(0x3c, KEY_U),
+	KEYMAP_ENTRY(0x3d, KEY_7),		KEYMAP_ENTRY(0x3e, KEY_8),
+	KEYMAP_ENTRY(0x3f, KEY_F8),		KEYMAP_ENTRY(0x41, KEY_COMMA),
+	KEYMAP_ENTRY(0x42, KEY_K),		KEYMAP_ENTRY(0x43, KEY_I),
+	KEYMAP_ENTRY(0x44, KEY_O),		KEYMAP_ENTRY(0x45, KEY_0),
+	KEYMAP_ENTRY(0x46, KEY_9),		KEYMAP_ENTRY(0x47, KEY_F9),
+	KEYMAP_ENTRY(0x49, KEY_DOT),		KEYMAP_ENTRY(0x4a, KEY_SLASH),
+	KEYMAP_ENTRY(0x4b, KEY_L),		KEYMAP_ENTRY(0x4c, KEY_SEMICOLON),
+	KEYMAP_ENTRY(0x4d, KEY_P),		KEYMAP_ENTRY(0x4e, KEY_MINUS),
+	KEYMAP_ENTRY(0x4f, KEY_F10),		KEYMAP_ENTRY(0x52, KEY_APOSTROPHE),
+	KEYMAP_ENTRY(0x54, KEY_LEFTBRACE),	KEYMAP_ENTRY(0x55, KEY_EQUAL),
+	KEYMAP_ENTRY(0x56, KEY_F11),		KEYMAP_ENTRY(0x57, KEY_SYSRQ),
+	KEYMAP_ENTRY(0x58, C_58),		KEYMAP_ENTRY(0x59, KEY_RIGHTSHIFT),
+	KEYMAP_ENTRY(0x5a, KEY_ENTER),		KEYMAP_ENTRY(0x5b, KEY_RIGHTBRACE),
+	KEYMAP_ENTRY(0x5c, KEY_BACKSLASH),	KEYMAP_ENTRY(0x5d, KEY_BACKSLASH),
+	KEYMAP_ENTRY(0x5e, KEY_F12),		KEYMAP_ENTRY(0x5f, KEY_SCROLLLOCK),
+	KEYMAP_ENTRY(0x60, KEY_DOWN),		KEYMAP_ENTRY(0x61, C_61),
+	KEYMAP_ENTRY(0x62, KEY_PAUSE),		KEYMAP_ENTRY(0x63, KEY_UP),
+	KEYMAP_ENTRY(0x64, KEY_DELETE),		KEYMAP_ENTRY(0x65, KEY_END),
+	KEYMAP_ENTRY(0x66, KEY_BACKSPACE),	KEYMAP_ENTRY(0x67, KEY_INSERT),
+	KEYMAP_ENTRY(0x69, KEY_KP1),		KEYMAP_ENTRY(0x6a, KEY_RIGHT),
+	KEYMAP_ENTRY(0x6b, KEY_KP4),		KEYMAP_ENTRY(0x6c, KEY_KP7),
+	KEYMAP_ENTRY(0x6d, KEY_PAGEDOWN),	KEYMAP_ENTRY(0x6e, KEY_HOME),
+	KEYMAP_ENTRY(0x6f, KEY_PAGEUP),		KEYMAP_ENTRY(0x70, KEY_KP0),
+	KEYMAP_ENTRY(0x71, KEY_KPDOT),		KEYMAP_ENTRY(0x72, KEY_KP2),
+	KEYMAP_ENTRY(0x73, KEY_KP5),		KEYMAP_ENTRY(0x74, KEY_KP6),
+	KEYMAP_ENTRY(0x75, KEY_KP8),		KEYMAP_ENTRY(0x76, KEY_ESC),
+	KEYMAP_ENTRY(0x77, KEY_NUMLOCK),	KEYMAP_ENTRY(0x78, KEY_F11),
+	KEYMAP_ENTRY(0x79, KEY_KPPLUS),		KEYMAP_ENTRY(0x7a, KEY_KP3),
+	KEYMAP_ENTRY(0x7b, KEY_KPMINUS),	KEYMAP_ENTRY(0x7c, KEY_KPASTERISK),
+	KEYMAP_ENTRY(0x7d, KEY_KP9),		KEYMAP_ENTRY(0x7e, KEY_SCROLLLOCK),
+	KEYMAP_ENTRY(0x7f, KEY_102ND),		KEYMAP_ENTRY(0x91, KEY_RIGHTALT),
+	KEYMAP_ENTRY(0x94, KEY_RIGHTCTRL),	KEYMAP_ENTRY(0x9d, KEY_CAPSLOCK),
+	KEYMAP_ENTRY(0x9f, KEY_LEFTMETA),	KEYMAP_ENTRY(0xa7, KEY_RIGHTMETA),
+	KEYMAP_ENTRY(0xaf, KEY_COMPOSE),	KEYMAP_ENTRY(0xe9, KEY_END),
+	KEYMAP_ENTRY(0xeb, KEY_LEFT),		KEYMAP_ENTRY(0xec, KEY_HOME),
+	KEYMAP_ENTRY(0xf0, KEY_INSERT),		KEYMAP_ENTRY(0xf1, KEY_DELETE),
+	KEYMAP_ENTRY(0xf2, KEY_DOWN),		KEYMAP_ENTRY(0xf4, KEY_RIGHT),
+	KEYMAP_ENTRY(0xf5, KEY_UP),		KEYMAP_ENTRY(0xf7, KEY_PAUSE),
+	KEYMAP_ENTRY(0xfa, KEY_PAGEDOWN),	KEYMAP_ENTRY(0xfc, KEY_SYSRQ),
+	KEYMAP_ENTRY(0xfd, KEY_PAGEUP),
+
+	/* Escaped keycodes */
+	KEYMAP_ENTRY(0x103, KEY_F7),		KEYMAP_ENTRY(0x10b, KEY_LEFTMETA),
+	KEYMAP_ENTRY(0x10c, KEY_RIGHTMETA),	KEYMAP_ENTRY(0x111, KEY_RIGHTALT),
+	KEYMAP_ENTRY(0x114, KEY_RIGHTCTRL),
+};
+
+static const struct property_entry gscps2_props[] = {
+	PROPERTY_ENTRY_U32_ARRAY("linux,keymap", gscps2_keymap),
+	{ }
+};
-- 
2.55.0.229.g6434b31f56-goog


-- 
Dmitry
