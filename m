From: Wan Zongshun <Vincent.Wan@amd.com>
Subject: [PATCH v2] Implement i8042 detect by BIOS FADT i8042 flag
Date: Wed, 2 Dec 2015 14:07:18 -0500
Message-ID: <1449083238-13179-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0071.outbound.protection.outlook.com ([65.55.169.71]:41760
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756697AbbLBLoT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 06:44:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.coom, bp@alien8.de, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mcuos.com@gmail.com, Wan Zongshun <Vincent.Wan@amd.com>

Detecting x86 platform supporting i8042 or not, we should resort
to BIOS's FADT i8042 flag per ACPI spec.

Currently, Windows is conforming to this spec, and request this
flag to detect i8042 supporting.

Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index c115565..73686bd 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -9,6 +9,7 @@
 
 #ifdef CONFIG_X86
 #include <asm/x86_init.h>
+#include <linux/acpi.h>
 #endif
 
 /*
@@ -1047,6 +1048,9 @@ static int __init i8042_platform_init(void)
 	/* Just return if pre-detection shows no i8042 controller exist */
 	if (!x86_platform.i8042_detect())
 		return -ENODEV;
+
+	if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042))
+		return -ENODEV;
 #endif
 
 /*
-- 
1.9.1

