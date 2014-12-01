From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [RFC] Input: Remove unused BUS IDs
Date: Mon,  1 Dec 2014 12:51:27 +0200
Message-ID: <1417431087-30330-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44808 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbaLAKwE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Dec 2014 05:52:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

There are a few BUS IDs that are not used anywhere in kernel tree:

- BUS_ISAPNP
  Has no changes or use in kernel git history
- BUS_GSC
  Was added by commit 6ab0f5cd3644 ("[PARISC] Update parisc specific input
  code from parisc tree") but never used
- BUS_ATARI
  Became unused after commit 6615c5b25e0b ("m68k: Atari input drivers
  cleanup")

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I'm not familiar with the input and don't know is there use for these in
userspace. Therefore I didn't sort these IDs after removal.
---
 include/uapi/linux/input.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 1874ebe9ac1e..39d535034169 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -940,7 +940,6 @@ struct input_keymap_entry {
 #define ID_VERSION		3
 
 #define BUS_PCI			0x01
-#define BUS_ISAPNP		0x02
 #define BUS_USB			0x03
 #define BUS_HIL			0x04
 #define BUS_BLUETOOTH		0x05
@@ -956,8 +955,6 @@ struct input_keymap_entry {
 #define BUS_ADB			0x17
 #define BUS_I2C			0x18
 #define BUS_HOST		0x19
-#define BUS_GSC			0x1A
-#define BUS_ATARI		0x1B
 #define BUS_SPI			0x1C
 
 /*
-- 
2.1.3

