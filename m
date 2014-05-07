From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 04/13] Input: imx_keypad - Make of_device_id array const
Date: Wed, 07 May 2014 18:17:51 +0900
Message-ID: <023101cf69d5$38d000a0$aa7001e0$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:8869 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbaEGJRx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:17:53 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N57002V85TSQ2A0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:17:52 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Fabio Estevam' <fabio.estevam@freescale.com>, 'Alberto Panizzo' <alberto@amarulasolutions.com>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/keyboard/imx_keypad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 97ec335..8280cb1 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -415,7 +415,7 @@ open_err:
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id imx_keypad_of_match[] = {
+static const struct of_device_id imx_keypad_of_match[] = {
 	{ .compatible = "fsl,imx21-kpp", },
 	{ /* sentinel */ }
 };
-- 
1.7.10.4


