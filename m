From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Input: ambakmi: constify amba_id
Date: Wed, 23 Aug 2017 21:49:11 +0530
Message-ID: <ae4946316c52a224044aeb999d98409c7cd12763.1503505084.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33305 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932149AbdHWQTU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 12:19:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux@armlinux.org.uk, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/serio/ambakmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index c6606ca..ff3875c 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -187,7 +187,7 @@ static int __maybe_unused amba_kmi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(amba_kmi_dev_pm_ops, NULL, amba_kmi_resume);
 
-static struct amba_id amba_kmi_idtable[] = {
+static const struct amba_id amba_kmi_idtable[] = {
 	{
 		.id	= 0x00041050,
 		.mask	= 0x000fffff,
-- 
2.7.4

