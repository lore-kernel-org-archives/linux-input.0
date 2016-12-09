From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: i8042 - trust firmware a bit more when probing on X86
Date: Fri,  9 Dec 2016 12:57:39 -0800
Message-ID: <1481317061-31486-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36834 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbcLIU5q (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 15:57:46 -0500
In-Reply-To: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>

The error message "Can't read CTR while initializing i8042" appears on
Cherry Trail-based devices at each boot time:

  i8042: PNP: No PS/2 controller found. Probing ports directly.
  i8042: Can't read CTR while initializing i8042
  i8042: probe of i8042 failed with error -5

This happens because we historically do not trust firmware on X86 and,
while noting that PNP does not show keyboard or mouse devices, we still
charge ahead and try to probe the controller. Let's relax this a bit and if
results of PNP probe agree with the results of platform
initialization/quirks conclude that there is, in fact, no i8042.

While at it, let's avoid using x86_platform.i8042_detect() and instead
abort execution early if platform indicates that it can not possibly have
i8042 (x86_platform.legacy.i8042 equals X86_LEGACY_I8042_PLATFORM_ABSENT).

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 2e6a938..6ecb214 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -991,7 +991,11 @@ static int __init i8042_pnp_init(void)
 #if defined(__ia64__)
 		return -ENODEV;
 #else
-		pr_info("PNP: No PS/2 controller found. Probing ports directly.\n");
+		pr_info("PNP: No PS/2 controller found.\n");
+		if (x86_platform.legacy.i8042 !=
+				X86_LEGACY_I8042_EXPECTED_PRESENT)
+			return -ENODEV;
+		pr_info("Probing ports directly.\n");
 		return 0;
 #endif
 	}
@@ -1078,8 +1082,8 @@ static int __init i8042_platform_init(void)
 
 #ifdef CONFIG_X86
 	u8 a20_on = 0xdf;
-	/* Just return if pre-detection shows no i8042 controller exist */
-	if (!x86_platform.i8042_detect())
+	/* Just return if platform does not have i8042 controller */
+	if (x86_platform.legacy.i8042 == X86_LEGACY_I8042_PLATFORM_ABSENT)
 		return -ENODEV;
 #endif
 
-- 
2.8.0.rc3.226.g39d4020

