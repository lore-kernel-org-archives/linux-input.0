From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 31/36]  [Driver][Qualcomm 1070][VERSION] 0.1.1
Date: Mon, 26 Jul 2010 16:30:40 +0800
Message-ID: <1280133045-25945-31-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52463 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab0GZIdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:35 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so4321295pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:34 -0700 (PDT)
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
index c683fe1..a594164 100755
--- a/arch/arm/mach-msm/version.c
+++ b/arch/arm/mach-msm/version.c
@@ -12,7 +12,7 @@
 #include "smd_private.h"
 
 #define KERNEL_VERSION UTS_RELEASE
-#define IMAGE_VERSION "0.1.0"
+#define IMAGE_VERSION "0.1.1"
 
 static int version_proc_show(struct seq_file *m, void *v)
 {
-- 
1.7.0.4

