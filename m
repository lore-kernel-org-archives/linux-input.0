From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 1/6] Input: pm8xxx-vib: reorder header alphabetically
Date: Fri, 31 Mar 2017 12:15:33 -0400
Message-ID: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36818 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbdCaQQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 12:16:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 5113877153d7..580448170342 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -10,13 +10,13 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/platform_device.h>
 #include <linux/input.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 
 #define VIB_DRV			0x4A
 
-- 
2.12.0

