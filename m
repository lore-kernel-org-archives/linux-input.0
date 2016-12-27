From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics-rmi4 - fix F03 build error when serio is
 module
Date: Tue, 27 Dec 2016 11:34:56 -0800
Message-ID: <20161227193456.GA36223@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35327 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbcL0TfA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2016 14:35:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nick Dyer <nick@shmanahar.org>, Guenter Roeck <linux@roeck-us.net>, Lyude Paul <thatslyude@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org

Since F03 is a boolean, "depends" on symbols that can be modules
do not work quite right. We can enable F03 if SERIO is built-in or
if both RMI core and SERIO core are modules. If SERIO core is module,
but RMI is built-in, we'll get:

drivers/built-in.o: In function `rmi_f03_attention':
rmi_f03.c:(.text+0xf8ef8): undefined reference to `serio_interrupt'
rmi_f03.c:(.text+0xf8fbd): undefined reference to `serio_interrupt'
drivers/built-in.o: In function `rmi_f03_remove':
rmi_f03.c:(.text+0xf9082): undefined reference to `serio_unregister_port'
drivers/built-in.o: In function `rmi_f03_probe':
rmi_f03.c:(.text+0xf9260): undefined reference to `__serio_register_port'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 30cc627..8993983 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -41,7 +41,8 @@ config RMI4_SMB
 
 config RMI4_F03
         bool "RMI4 Function 03 (PS2 Guest)"
-        depends on RMI4_CORE && SERIO
+	depends on RMI4_CORE
+	depends on SERIO=y || RMI4_CORE=SERIO
         help
           Say Y here if you want to add support for RMI4 function 03.
 
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
