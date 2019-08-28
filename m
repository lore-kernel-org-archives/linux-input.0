From: "tip-bot2 for Thomas Hellstrom" <tip-bot2@linutronix.de>
Subject: [tip: x86/vmware] input/vmmouse: Update the backdoor call with
 support for new instructions
Date: Wed, 28 Aug 2019 13:30:56 -0000
Message-ID: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2>
References: <20190828080353.12658-5-thomas_os@shipmail.org>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828080353.12658-5-thomas_os@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Hellstrom <thellstrom@vmware.com>, Borislav Petkov <bp@suse.de>, Doug Covelli <dcovelli@vmware.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, VMware Graphics <linux-graphics-maintainer@vmware.com>, pv-drivers@vmware.com, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     f7b15c74cffd760ec9959078982d8268a38456c4
Gitweb:        https://git.kernel.org/tip/f7b15c74cffd760ec9959078982d8268a38456c4
Author:        Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate:    Wed, 28 Aug 2019 10:03:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Aug 2019 13:43:01 +02:00

input/vmmouse: Update the backdoor call with support for new instructions

Use the definition provided by include/asm/vmware.h.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: <pv-drivers@vmware.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190828080353.12658-5-thomas_os@shipmail.org
---
 drivers/input/mouse/vmmouse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index 871e5b5..148245c 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -16,12 +16,12 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 #include "psmouse.h"
 #include "vmmouse.h"
 
 #define VMMOUSE_PROTO_MAGIC			0x564D5868U
-#define VMMOUSE_PROTO_PORT			0x5658
 
 /*
  * Main commands supported by the vmmouse hypervisor port.
@@ -84,7 +84,7 @@ struct vmmouse_data {
 #define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
 ({							\
 	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ ("inl %%dx" :		\
+	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
 		"=a"(out1),				\
 		"=b"(out2),				\
 		"=c"(out3),				\
@@ -94,7 +94,7 @@ struct vmmouse_data {
 		"a"(VMMOUSE_PROTO_MAGIC),		\
 		"b"(in1),				\
 		"c"(VMMOUSE_PROTO_CMD_##cmd),		\
-		"d"(VMMOUSE_PROTO_PORT) :		\
+		"d"(0) :			        \
 		"memory");		                \
 })
 
