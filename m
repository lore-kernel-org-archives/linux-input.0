From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: gpio_keys - fix a memory leak
Date: Tue, 28 Jun 2011 10:46:21 +0800
Message-ID: <1309229181.5235.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53545 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab1F1Cqa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 22:46:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Phil Blundell <pb@handhelds.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6d0e2f6..cc4bdec 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -569,6 +569,7 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	}
 
 	input_unregister_device(input);
+	kfree(ddata);
 
 	return 0;
 }
-- 
1.7.4.1



