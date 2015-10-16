From: Vincent Wan <Vincent.Wan@amd.com>
Subject: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Fri, 16 Oct 2015 09:27:00 -0400
Message-ID: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ray.Huang@amd.com, mcuos.com@gmail.com, Vincent Wan <Vincent.Wan@amd.com>
List-Id: linux-input@vger.kernel.org

Detecting platform supports i8042 or not, AMD resorted to
BIOS's FADT i8042 flag.

Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index c115565..bf3a605 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -9,6 +9,7 @@
 
 #ifdef CONFIG_X86
 #include <asm/x86_init.h>
+#include <linux/acpi.h>
 #endif
 
 /*
@@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
 	/* Just return if pre-detection shows no i8042 controller exist */
 	if (!x86_platform.i8042_detect())
 		return -ENODEV;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042))
+			return -ENODEV;
+	}
 #endif
 
 /*
-- 
1.9.1
