From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 07/13] Input: olpc_apsp - Make of_device_id array const
Date: Wed, 07 May 2014 18:20:30 +0900
Message-ID: <023401cf69d5$973dbd30$c5b93790$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:9623 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaEGJUb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:20:31 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N57003O45Y6XV90@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:20:30 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Daniel Drake' <drake@endlessm.com>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/serio/olpc_apsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 5d2fe7e..d906f3e 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -262,7 +262,7 @@ static int olpc_apsp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id olpc_apsp_dt_ids[] = {
+static const struct of_device_id olpc_apsp_dt_ids[] = {
 	{ .compatible = "olpc,ap-sp", },
 	{}
 };
-- 
1.7.10.4


