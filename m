From: Dudley Du <dudl@cypress.com>
Subject: [PATCH] input: cyapa: fix unaligned functions redefinition error
Date: Mon,  2 Mar 2015 14:04:38 +0800
Message-ID: <1425276278-12298-1-git-send-email-dudl@cypress.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, jmmahler@gmail.com, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use asm/unaligned.h instead of linux/unaligned/access_ok.h head file to
fix compiling issues such as following while doing cross platform compiling.
"include/linux/unaligned/access_ok.h:7:19: error: redefinition of
 'get_unaligned_le16'
...
include/linux/unaligned/le_struct.h:6:19: note: previous definition of
 'get_unaligned_le16' was here".

Reported-by: kbuild test robot <kbuild-all@01.org>
Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa_gen3.c | 2 +-
 drivers/input/mouse/cyapa_gen5.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 77e9d70..1e2291c 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -20,7 +20,7 @@
 #include <linux/input/mt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 #include "cyapa.h"
 
 
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index ddf5393..aa68edd 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -17,7 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/slab.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 #include <linux/crc-itu-t.h>
 #include "cyapa.h"
 
-- 
1.9.1
