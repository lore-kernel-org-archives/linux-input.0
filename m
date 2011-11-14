From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: ucb1400_ts - set driver owner
Date: Mon, 14 Nov 2011 00:36:07 -0800
Message-ID: <1321259771-10925-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60140 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1KNIgP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:36:15 -0500
Received: by pzk36 with SMTP id 36so11695322pzk.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:36:15 -0800 (PST)
In-Reply-To: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>

So that it has proper symlink to the containing module in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index ead7123..550249b 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -453,6 +453,7 @@ static struct platform_driver ucb1400_ts_driver = {
 	.remove	= ucb1400_ts_remove,
 	.driver	= {
 		.name	= "ucb1400_ts",
+		.owner	= THIS_MODULE,
 		.pm	= &ucb1400_ts_pm_ops,
 	},
 };
-- 
1.7.6.4

