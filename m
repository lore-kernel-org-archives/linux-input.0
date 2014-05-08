From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] input: fix ps2/serio module dependency
Date: Thu,  8 May 2014 16:56:26 +0200
Message-ID: <1399560990-1402858-15-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55831 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbaEHO5F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 10:57:05 -0400
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The ps2 mouse and keyboard drivers use the "serio" framework that
they correctly select in Kconfig, and that in turn depends on the
i8042 driver, which is also allowed to be disabled for architectures
that don't have an i8042.

However, Kconfig also allows i8042 to be built as a module while
the serio framework is built-in, which causes this link error:

drivers/built-in.o: In function `ps2_begin_command':
:(.text+0x26b6cc): undefined reference to `i8042_check_port_owner'
:(.text+0x26b6d4): undefined reference to `i8042_lock_chip'
drivers/built-in.o: In function `ps2_end_command':
:(.text+0x26b734): undefined reference to `i8042_check_port_owner'
:(.text+0x26b73c): undefined reference to `i8042_unlock_chip'

On x86, a specific 'select SERIO_I8042' takes care of it, but
not on the other architecture that potentially have a u8042.

This patch changes the Kconfig logic to ensure that whenever
there is an i8042, it does get used for the serio driver, avoiding
the link error above.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/keyboard/Kconfig | 2 +-
 drivers/input/mouse/Kconfig    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4f115db..dd2435a 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -71,7 +71,7 @@ config KEYBOARD_ATKBD
 	default y
 	select SERIO
 	select SERIO_LIBPS2
-	select SERIO_I8042 if X86
+	select SERIO_I8042 if X86 || ARCH_MIGHT_HAVE_PC_SERIO
 	select SERIO_GSCPS2 if GSC
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index effa9c5..cf534ee 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -17,7 +17,7 @@ config MOUSE_PS2
 	default y
 	select SERIO
 	select SERIO_LIBPS2
-	select SERIO_I8042 if X86
+	select SERIO_I8042 if X86 || ARCH_MIGHT_HAVE_PC_SERIO
 	select SERIO_GSCPS2 if GSC
 	help
 	  Say Y here if you have a PS/2 mouse connected to your system. This
-- 
1.8.3.2

