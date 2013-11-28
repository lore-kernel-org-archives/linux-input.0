From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] Input: emu10k1 - use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 11:19:33 +0900
Message-ID: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9417 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758477Ab3K1CTf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 21:19:35 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00DE6BSL0P50@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 28 Nov 2013 11:19:33 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/gameport/emu10k1-gp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
index fa7a95c..72a7213 100644
--- a/drivers/input/gameport/emu10k1-gp.c
+++ b/drivers/input/gameport/emu10k1-gp.c
@@ -46,7 +46,7 @@ struct emu {
 	int size;
 };
 
-static const struct pci_device_id emu_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(emu_tbl) = {
 
 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID }, /* SB Live gameport */
 	{ 0x1102, 0x7003, PCI_ANY_ID, PCI_ANY_ID }, /* Audigy gameport */
-- 
1.7.10.4


