From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] input: da9052: fix mem leak in da9052_onkey_probe()
Date: Wed, 11 Apr 2012 22:56:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204112249110.2137@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from swampdragon.chaosbits.net ([90.184.90.115]:17192 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758740Ab2DKU4L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Apr 2012 16:56:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Dajun Chen <dchen@diasemi.com>, linux-input@vger.kernel.org, Ashish Jangam <ashish.jangam@kpitcummins.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

If, in drivers/input/misc/da9052_onkey.c::da9052_onkey_probe(), the
call to either kzalloc() or input_allocate_device() fails then we will
return -ENOMEM from the function without freeing the other allocation
that may have succeeded, thus we leak either the memory allocated for
'onkey' or the memory allocated for 'input_dev' if one succeeds and
the other fails.
Fix that by jumping to the 'err_free_mem' label at the end of the
function that properly cleans up rather than returning directly.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/input/misc/da9052_onkey.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/da9052_onkey.c b/drivers/input/misc/da9052_onkey.c
index 34aebb8..3c843cd 100644
--- a/drivers/input/misc/da9052_onkey.c
+++ b/drivers/input/misc/da9052_onkey.c
@@ -95,7 +95,8 @@ static int __devinit da9052_onkey_probe(struct platform_device *pdev)
 	input_dev = input_allocate_device();
 	if (!onkey || !input_dev) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
 	onkey->input = input_dev;
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

