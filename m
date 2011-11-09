From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv6_input/next 5/5] input/cma3000_d0x: Match comment to name of struct
Date: Wed,  9 Nov 2011 22:37:32 +0100
Message-ID: <1320874652-18371-6-git-send-email-ricardo.ribalda__38797.8220977404$1320874712$gmane$org@gmail.com>
References: <1320874652-18371-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62281 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549Ab1KIVh7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Nov 2011 16:37:59 -0500
In-Reply-To: <1320874652-18371-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rdunlap@xenotime.net, dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, ricardo.ribalda@gmail.com, jic23@cam.ac.uk, aghayal@codeaurora.org, sameo@linux.intel.com, peter.ujfalusi@t

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
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
1.7.7.2

