From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] drivers/input: ab8500-ponkey: fix error path
Date: Sun, 24 Oct 2010 17:09:19 +0200
Message-ID: <20101024170919.18cf4372@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:37423 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932085Ab0JXPKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Oct 2010 11:10:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Looks like an obvious typo to me.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/input/misc/ab8500-ponkey.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 98f8ede..3d3288a 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -107,7 +107,7 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_dbr_irq:
-	free_irq(ponkey->irq_dbf, ponkey);
+	free_irq(ponkey->irq_dbr, ponkey);
 err_free_dbf_irq:
 	free_irq(ponkey->irq_dbf, ponkey);
 err_free_mem:
-- 
1.7.2.2
