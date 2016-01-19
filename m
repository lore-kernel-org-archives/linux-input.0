From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT macros
Date: Tue, 19 Jan 2016 13:46:02 -0800
Message-ID: <1453239965-1466-4-git-send-email-syeh@vmware.com>
References: <1449271183-1746-1-git-send-email-syeh@vmware.com>
 <1453239965-1466-1-git-send-email-syeh@vmware.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:33662 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757521AbcASVo5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 16:44:57 -0500
In-Reply-To: <1453239965-1466-1-git-send-email-syeh@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Sinclair Yeh <syeh@vmware.com>, pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org, linux-input@vger.kernel.org

Updated the VMMOUSE macro to use the new VMW_PORT macro. Doing
this instead of replacing all existing instances of VMWMOUSE
to minimize code change.

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Alok N Kataria <akataria@vmware.com>
Cc: pv-drivers@vmware.com
Cc: linux-graphics-maintainer@vmware.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-input@vger.kernel.org

---

v2:
Instead of replacing existing VMMOUSE defines, only modify enough
to use the new VMW_PORT define.

v3:
Use updated VMWARE_PORT() which requires hypervisor magic as an added
parameter

v4:
Swapped parameters 1 and 2 when calling VMW_PORT because the macro
has been updated

v5:
Updated VMW_PORT() usage since the macro has been updated
---
 drivers/input/mouse/vmmouse.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index e272f06..d06daf6 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 #include "psmouse.h"
 #include "vmmouse.h"
@@ -84,21 +85,12 @@ struct vmmouse_data {
  * implementing the vmmouse protocol. Should never execute on
  * bare metal hardware.
  */
-#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
-({							\
-	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ ("inl %%dx" :		\
-		"=a"(out1),				\
-		"=b"(out2),				\
-		"=c"(out3),				\
-		"=d"(out4),				\
-		"=S"(__dummy1),				\
-		"=D"(__dummy2) :			\
-		"a"(VMMOUSE_PROTO_MAGIC),		\
-		"b"(in1),				\
-		"c"(VMMOUSE_PROTO_CMD_##cmd),		\
-		"d"(VMMOUSE_PROTO_PORT) :		\
-		"memory");		                \
+#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)		\
+({								\
+	unsigned long __dummy1, __dummy2;			\
+	VMW_PORT(VMMOUSE_PROTO_CMD_##cmd, in1, 0, 0,		\
+		 VMMOUSE_PROTO_PORT, VMMOUSE_PROTO_MAGIC,	\
+		 out1, out2, out3, out4, __dummy1, __dummy2);   \
 })
 
 /**
-- 
1.9.1

