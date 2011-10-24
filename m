From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv4 6/6] input/cma3000_d0x: Match comment to name of struct
Date: Mon, 24 Oct 2011 22:21:16 +0200
Message-ID: <1319487676-27181-7-git-send-email-ricardo.ribalda@gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59894 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab1JXUVm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Oct 2011 16:21:42 -0400
In-Reply-To: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.comsa
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
1.7.7

