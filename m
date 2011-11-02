From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv5 5/5] input/cma3000_d0x: Match comment to name of struct
Date: Wed,  2 Nov 2011 15:49:13 +0100
Message-ID: <1320245353-32125-6-git-send-email-ricardo.ribalda__47716.1034163602$1320245426$gmane$org@gmail.com>
References: <1320245353-32125-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64630 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab1KBOtl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 10:49:41 -0400
In-Reply-To: <1320245353-32125-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rdunlap@xenotime.net, dmitry.torokhov@gmail.com, jic23@cam.ac.uk, aghayal@codeaurora.org, sameo@linux.intel.com, peter.ujfalusi@ti.
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---

v4: Add ACKs to patch

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/input/cma3000.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/input/cma3000.h b/include/linux/input/cma3000.h
index cbbaac2..e8c28e8 100644
--- a/include/linux/input/cma3000.h
+++ b/include/linux/input/cma3000.h
@@ -33,7 +33,7 @@
 #define CMARANGE_8G   8000
 
 /**
- * struct cma3000_i2c_platform_data - CMA3000 Platform data
+ * struct cma3000_platform_data - CMA3000 Platform data
  * @fuzz_x: Noise on X Axis
  * @fuzz_y: Noise on Y Axis
  * @fuzz_z: Noise on Z Axis
-- 
1.7.7.1

