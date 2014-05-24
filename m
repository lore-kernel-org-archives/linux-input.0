From: Andrew Pinski <apinski@cavium.com>
Subject: [PATCH 13/24] Drivers:input: Use is_compat_task for ARM64 also.
Date: Sat, 24 May 2014 00:02:08 -0700
Message-ID: <1400914939-9708-14-git-send-email-apinski__10008.6205559366$1400915112$gmane$org@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Andrew Pinski <apinski@cavium.com>
List-Id: linux-input@vger.kernel.org

Since TIF_32BIT in ARM64 (with ILP32 added) is not always says if this is a compat task, we need to have the input driver understand that and use is_compat_task instead.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 drivers/input/input-compat.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 148f66f..6656957 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -19,7 +19,7 @@
 
 /* Note to the author of this code: did it ever occur to
    you why the ifdefs are needed? Think about it again. -AK */
-#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
+#if defined(CONFIG_X86_64) || defined(CONFIG_TILE) || defined(CONFIG_ARM64)
 #  define INPUT_COMPAT_TEST is_compat_task()
 #elif defined(CONFIG_S390)
 #  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
-- 
1.7.2.5
