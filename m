From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] Input: serio: remove unnecessary pci_set_drvdata()
Date: Mon, 25 Nov 2013 11:13:46 +0900
Message-ID: <001b01cee983$f894c510$e9be4f30$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14704 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab3KYCNz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Nov 2013 21:13:55 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWS0085ARIY4K00@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 25 Nov 2013 11:13:46 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/serio/pcips2.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index 76f8383..13062f6 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -181,7 +181,6 @@ static void pcips2_remove(struct pci_dev *dev)
 	struct pcips2_data *ps2if = pci_get_drvdata(dev);
 
 	serio_unregister_port(ps2if->io);
-	pci_set_drvdata(dev, NULL);
 	kfree(ps2if);
 	pci_release_regions(dev);
 	pci_disable_device(dev);
-- 
1.7.10.4


