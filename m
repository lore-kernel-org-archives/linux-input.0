From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 06/13] Input: rotary_encoder - Make of_device_id array const
Date: Wed, 07 May 2014 18:19:38 +0900
Message-ID: <023301cf69d5$78a87450$69f95cf0$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26614 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaEGJTk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:19:40 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700G5K5WRHZA0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:19:39 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Daniel Mack' <zonque@gmail.com>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/rotary_encoder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 99b9e42..93558a1c 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -143,7 +143,7 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id rotary_encoder_of_match[] = {
+static const struct of_device_id rotary_encoder_of_match[] = {
 	{ .compatible = "rotary-encoder", },
 	{ },
 };
-- 
1.7.10.4


