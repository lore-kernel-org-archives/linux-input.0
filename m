From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 36/36]  [Driver][Qualcomm 1070][VERSION] 0.2.0
Date: Mon, 26 Jul 2010 16:30:45 +0800
Message-ID: <1280133045-25945-36-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39717 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab0GZIdp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:45 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so4323268pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:45 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/mach-msm/version.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/version.c b/arch/arm/mach-msm/version.c
index f665d9f..be21aae 100755
--- a/arch/arm/mach-msm/version.c
+++ b/arch/arm/mach-msm/version.c
@@ -12,7 +12,7 @@
 #include "smd_private.h"
 
 #define KERNEL_VERSION UTS_RELEASE
-#define IMAGE_VERSION "0.1.2"
+#define IMAGE_VERSION "0.2.0"
 
 static int version_proc_show(struct seq_file *m, void *v)
 {
-- 
1.7.0.4

