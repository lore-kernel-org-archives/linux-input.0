From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] staging: Fix wrong Makefile config for mrst-touchscreen driver
Date: Wed, 25 Aug 2010 15:24:14 +0100
Message-ID: <20100825142408.3108.90472.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39065 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab0HYPDy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Aug 2010 11:03:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, greg@kroah.com

From: Alek Du <alek.du@intel.com>

The config name is wrong in drivers/staging/Makefile...
The object name is wrong in drivers/staging/mrst-touchscreen/Makefile...

Signed-off-by: Alek Du <alek.du@intel.com>
---

 drivers/staging/Makefile                  |    2 +-
 drivers/staging/mrst-touchscreen/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 7ca47ac..03e7818 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_CXT1E1)		+= cxt1e1/
 obj-$(CONFIG_TI_ST)		+= ti-st/
 obj-$(CONFIG_ADIS16255)		+= adis16255/
 obj-$(CONFIG_FB_XGI)		+= xgifb/
-obj-$(CONFIG_TOUCHSCREEN_MRSTOUCH)	+= mrst-touchscreen/
+obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= mrst-touchscreen/
 obj-$(CONFIG_MSM_STAGING)	+= msm/
 obj-$(CONFIG_EASYCAP)		+= easycap/
 obj-$(CONFIG_SOLO6X10)		+= solo6x10/
diff --git a/drivers/staging/mrst-touchscreen/Makefile b/drivers/staging/mrst-touchscreen/Makefile
index 2d638b0..155f58b 100644
--- a/drivers/staging/mrst-touchscreen/Makefile
+++ b/drivers/staging/mrst-touchscreen/Makefile
@@ -1,3 +1,3 @@
-obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) := intel_mid_touch.o
+obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) := intel-mid-touch.o
 
 

