From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Wed, 20 Jul 2011 23:34:28 +0800
Message-ID: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44987 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab1GTPhl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 11:37:41 -0400
Received: by iyb12 with SMTP id 12so287315iyb.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 08:37:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Wanlong Gao <wanlong.gao@gmail.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

It's better to set the device's driver data to NULL
when remove it.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/pcap_keys.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/pcap_keys.c b/drivers/input/misc/pcap_keys.c
index 99335c2..6c670f5 100644
--- a/drivers/input/misc/pcap_keys.c
+++ b/drivers/input/misc/pcap_keys.c
@@ -114,6 +114,8 @@ static int __devexit pcap_keys_remove(struct platform_device *pdev)
 	input_unregister_device(pcap_keys->input);
 	kfree(pcap_keys);
 
+	platform_set_drvdata(pdev, NULL);
+
 	return 0;
 }
 
-- 
1.7.4.1

