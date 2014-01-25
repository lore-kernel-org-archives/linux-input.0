From: Raghu Gandham <raghu.gandham@imgtec.com>
Subject: [PATCH] Input: i8042-io - Exclude mips platforms when allocating/deallocating IO regions.
Date: Sat, 25 Jan 2014 11:01:54 -0800
Message-ID: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: dmitry.torokhov@gmail.com, aaro.koskinen@iki.fi, linux-input@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
List-Id: linux-input@vger.kernel.org

The standard IO regions are already reserved by the platform code on most MIPS
devices(malta, cobalt, sni). The Commit 197a1e96c8be5b6005145af3a4c0e45e2d651444
("Input: i8042-io - fix up region handling on MIPS") introduced a bug on these
MIPS platforms causing i8042 driver to fail when trying to reserve IO ports.
Prior to the above mentioned commit request_region is skipped on MIPS but
release_region is called.

This patch reverts commit 197a1e96c8be5b6005145af3a4c0e45e2d651444 and also
avoids calling release_region for MIPS.

Signed-off-by: Raghu Gandham <raghu.gandham@imgtec.com>
Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 drivers/input/serio/i8042-io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index a5eed2a..a09bb72 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -76,7 +76,7 @@ static inline int i8042_platform_init(void)
 	if (check_legacy_ioport(I8042_DATA_REG))
 		return -ENODEV;
 #endif
-#if !defined(__sh__) && !defined(__alpha__)
+#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
 		return -EBUSY;
 #endif
@@ -87,7 +87,7 @@ static inline int i8042_platform_init(void)
 
 static inline void i8042_platform_exit(void)
 {
-#if !defined(__sh__) && !defined(__alpha__)
+#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
 	release_region(I8042_DATA_REG, 16);
 #endif
 }
-- 
1.8.5.2
