From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?=
        <thomas_os@shipmail.org>
Subject: [PATCH 4/4] input/vmmouse: Update the backdoor call with support for new instructions
Date: Sun, 18 Aug 2019 16:33:16 +0200
Message-ID: <20190818143316.4906-5-thomas_os@shipmail.org>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190818143316.4906-1-thomas_os@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, pv-drivers@vmware.com
Cc: Thomas Hellstrom <thellstrom@vmware.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Doug Covelli <dcovelli@vmware.com>
List-Id: linux-input@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Use the definition provided by include/asm/vmware.h

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 drivers/input/mouse/vmmouse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index 871e5b5ab129..0c7707c7bede 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 #include "psmouse.h"
 #include "vmmouse.h"
@@ -84,7 +85,7 @@ struct vmmouse_data {
 #define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
 ({							\
 	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ ("inl %%dx" :		\
+	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
 		"=a"(out1),				\
 		"=b"(out2),				\
 		"=c"(out3),				\
-- 
2.20.1
