From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] Input: cypress_ps2 - Remove casting the return value which is
 a void pointer
Date: Mon, 09 Sep 2013 14:37:03 +0900
Message-ID: <005401cead1e$9d3f7990$d7be6cb0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43113 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab3IIFhF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 01:37:05 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00IM9FKYTOO0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Mon, 09 Sep 2013 14:37:04 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Dudley Du' <dudl@cypress.com>, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/mouse/cypress_ps2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index f51765f..ef651cc 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -679,7 +679,7 @@ int cypress_init(struct psmouse *psmouse)
 {
 	struct cytp_data *cytp;
 
-	cytp = (struct cytp_data *)kzalloc(sizeof(struct cytp_data), GFP_KERNEL);
+	cytp = kzalloc(sizeof(struct cytp_data), GFP_KERNEL);
 	psmouse->private = (void *)cytp;
 	if (cytp == NULL)
 		return -ENOMEM;
-- 
1.7.10.4


