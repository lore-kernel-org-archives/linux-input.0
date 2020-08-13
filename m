Return-Path: <SRS0=1ZjA=BX=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F9C433DF
	for <linux-input@archiver.kernel.org>; Thu, 13 Aug 2020 03:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6C0206A4
	for <linux-input@archiver.kernel.org>; Thu, 13 Aug 2020 03:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMDtr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:49:47 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:14552 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHMDtr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Aug 2020 23:49:47 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 23:49:47 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id CFD1D4E1871;
        Thu, 13 Aug 2020 11:43:47 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wang Qing <wangqing@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/input/misc: Use kobj_to_dev() instead
Date:   Thu, 13 Aug 2020 11:43:25 +0800
Message-Id: <1597290219-26151-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkNMGUJCS0JNTUwdVkpOQkxJQktJSUNLQkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6CSo6DT8dC0MSQxEMPxEZ
        AgEwCj5VSlVKTkJMSUJLSUlDTkhCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKT0JNNwY+
X-HM-Tid: 0a73e5eaa9119376kuwscfd1d4e1871
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index d8dbfc0..0879d96
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1228,7 +1228,7 @@ static struct attribute *ims_pcu_attrs[] = {
 static umode_t ims_pcu_is_attr_visible(struct kobject *kobj,
 				       struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct ims_pcu *pcu = usb_get_intfdata(intf);
 	umode_t mode = attr->mode;
-- 
2.7.4

