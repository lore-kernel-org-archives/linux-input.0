From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] Input: misc : Introduce the use of the managed version of
 kzalloc
Date: Tue, 20 May 2014 20:39:18 +0530
Message-ID: <20140520150918.GA6269@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42805 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbaETPJZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2014 11:09:25 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
functions.

The following Coccinelle semantic patch was used for making the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Would be better to add the definition of a
devm_input_allocate_polled_device, like there is a
devm_input_allocate_device defined?

 drivers/input/misc/sgi_btns.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
index f104749..e2dea37 100644
--- a/drivers/input/misc/sgi_btns.c
+++ b/drivers/input/misc/sgi_btns.c
@@ -97,7 +97,8 @@ static int sgi_buttons_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	int error, i;
 
-	bdev = kzalloc(sizeof(struct buttons_dev), GFP_KERNEL);
+	bdev = devm_kzalloc(&pdev->dev, sizeof(struct buttons_dev),
+			    GFP_KERNEL);
 	poll_dev = input_allocate_polled_device();
 	if (!bdev || !poll_dev) {
 		error = -ENOMEM;
@@ -137,7 +138,6 @@ static int sgi_buttons_probe(struct platform_device *pdev)
 
  err_free_mem:
 	input_free_polled_device(poll_dev);
-	kfree(bdev);
 	return error;
 }
 
@@ -147,7 +147,6 @@ static int sgi_buttons_remove(struct platform_device *pdev)
 
 	input_unregister_polled_device(bdev->poll_dev);
 	input_free_polled_device(bdev->poll_dev);
-	kfree(bdev);
 
 	return 0;
 }
-- 
1.9.1

