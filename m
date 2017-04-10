From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v2] input: misc: yealink: define packet offset __be16 instead of u16
Date: Mon, 10 Apr 2017 17:00:22 +0200
Message-ID: <1491836422-22309-1-git-send-email-martin.kepplinger@ginzinger.com>
References: <1491814577-26408-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:7142 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdDJPAf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 11:00:35 -0400
In-Reply-To: <1491814577-26408-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henk.Vergonet@gmail.com, dmitry.torokhov@gmail.com
Cc: usbb2k-api-dev@nongnu.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>

sparse says

 warning: incorrect type in assignment (different base types)
    expected unsigned short [unsigned] [usertype] offset
    got restricted __be16 [usertype] <noident>

for every usage of cpu_to_be16 in yealink.c. Defining it __be16 in the
first place shouldn't hurt.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Signed-off-by: Henk.Vergonet@gmail.com
---
revision history
----------------
v2: add privately received Signed-off-by


 drivers/input/misc/yealink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/yealink.h b/drivers/input/misc/yealink.h
index 1e0f523..934c247 100644
--- a/drivers/input/misc/yealink.h
+++ b/drivers/input/misc/yealink.h
@@ -28,7 +28,7 @@
 struct yld_ctl_packet {
 	u8	cmd;		/* command code, see below */
 	u8	size;		/* 1-11, size of used data bytes. */
-	u16	offset;		/* internal packet offset */
+	__be16	offset;		/* internal packet offset */
 	u8	data[11];
 	s8	sum;		/* negative sum of 15 preceding bytes */
 } __attribute__ ((packed));
-- 
2.1.4

