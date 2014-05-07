From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 08/13] Input: apbps2 - Make of_device_id array const
Date: Wed, 07 May 2014 18:21:29 +0900
Message-ID: <023501cf69d5$ba8df610$2fa9e230$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:10012 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaEGJVb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:21:31 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N57003TE5ZTXV90@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:21:29 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Daniel Hellstrom' <daniel@gaisler.com>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/serio/apbps2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 17e01a8..98be824 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -203,7 +203,7 @@ static int apbps2_of_remove(struct platform_device *of_dev)
 	return 0;
 }
 
-static struct of_device_id apbps2_of_match[] = {
+static const struct of_device_id apbps2_of_match[] = {
 	{ .name = "GAISLER_APBPS2", },
 	{ .name = "01_060", },
 	{}
-- 
1.7.10.4


