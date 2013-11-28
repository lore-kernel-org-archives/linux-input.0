From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] Input: fm801-gp - use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 11:20:30 +0900
Message-ID: <001a01ceebe0$68d60060$3a820120$%han@samsung.com>
References: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9656 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab3K1CUn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 21:20:43 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00CENBU6IE60@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 28 Nov 2013 11:20:30 +0900 (KST)
In-reply-to: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/gameport/fm801-gp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index ae912d3..5ace35bf 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -140,7 +140,7 @@ static void fm801_gp_remove(struct pci_dev *pci)
 	pci_disable_device(pci);
 }
 
-static const struct pci_device_id fm801_gp_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(fm801_gp_id_table) = {
 	{ PCI_VENDOR_ID_FORTEMEDIA, PCI_DEVICE_ID_FM801_GP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0  },
 	{ 0 }
 };
-- 
1.7.10.4


