From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Tue, 10 Jan 2017 13:16:58 +0100
Message-ID: <20170110121718.2992211-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761015AbdAJMR2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Jan 2017 07:17:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

If CONFIG_INPUT=m, we get a build error for the rmi4-f03 driver,
added in linux-4.10:

drivers/input/built-in.o: In function `rmi_f03_attention':
rmi_f03.c:(.text+0xcfe0): undefined reference to `serio_interrupt'
rmi_f03.c:(.text+0xd055): undefined reference to `serio_interrupt'
drivers/input/built-in.o: In function `rmi_f03_remove':
rmi_f03.c:(.text+0xd115): undefined reference to `serio_unregister_port'
drivers/input/built-in.o: In function `rmi_f03_probe':
rmi_f03.c:(.text+0xd209): undefined reference to `__serio_register_port'

If we make the driver itself a 'tristate' instead of 'bool' symbol,
Kconfig ensures that it can only be a loadable module in this case,
which avoids the problem.

Fixes: c5e8848fc98e ("Input: synaptics-rmi4 - add support for F03")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/rmi4/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 30cc627a4f45..ad945b25722c 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -40,7 +40,7 @@ config RMI4_SMB
 	  called rmi_smbus.
 
 config RMI4_F03
-        bool "RMI4 Function 03 (PS2 Guest)"
+        tristate "RMI4 Function 03 (PS2 Guest)"
         depends on RMI4_CORE && SERIO
         help
           Say Y here if you want to add support for RMI4 function 03.
-- 
2.9.0

