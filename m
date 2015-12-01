From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT macros
Date: Tue,  1 Dec 2015 14:18:49 -0800
Message-ID: <1449008332-9394-3-git-send-email-syeh@vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449008332-9394-1-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sinclair Yeh <syeh@vmware.com>, pv-drivers@vmware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

v2:
Instead of replacing existing VMMOUSE defines, only modify enough
to use the new VMW_PORT define.

v3:
Use updated VMWARE_PORT() which requires hypervisor magic as an added
parameter

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
 drivers/input/mouse/vmmouse.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index e272f06..d34e3e4 100644
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
+#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)		   \
+({								   \
+	unsigned long __dummy1 = 0, __dummy2 = 0;		   \
+	VMW_PORT(in1, VMMOUSE_PROTO_CMD_##cmd, VMMOUSE_PROTO_PORT, \
+		 VMMOUSE_PROTO_MAGIC,				   \
+		 out1, out2, out3, out4, __dummy1, __dummy2);      \
 })
 
 /**
-- 
1.9.1
