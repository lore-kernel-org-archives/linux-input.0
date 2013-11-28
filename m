From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] Input: pcips2 - use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 11:21:12 +0900
Message-ID: <001b01ceebe0$82141940$863c4bc0$%han@samsung.com>
References: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9791 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab3K1CVO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 21:21:14 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00CV0BVDGF60@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 28 Nov 2013 11:21:13 +0900 (KST)
In-reply-to: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/serio/pcips2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index 13062f6..2fff5d4 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -186,7 +186,7 @@ static void pcips2_remove(struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
-static const struct pci_device_id pcips2_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(pcips2_ids) = {
 	{
 		.vendor		= 0x14f2,	/* MOBILITY */
 		.device		= 0x0123,	/* Keyboard */
-- 
1.7.10.4


