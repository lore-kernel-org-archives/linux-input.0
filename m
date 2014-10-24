From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: vsxxxaa - fix code dropping bytes from queue
Date: Fri, 24 Oct 2014 15:38:46 -0700
Message-ID: <20141024223846.GA1914@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:62021 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbaJXWiu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 18:38:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org

I believe the intent of the code was to drop oldest bytes from the queue,
not the latest if we drop one byte and both latest and some oldest of we
are dropping more than one.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/vsxxxaa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
index 3829823..abd4944 100644
--- a/drivers/input/mouse/vsxxxaa.c
+++ b/drivers/input/mouse/vsxxxaa.c
@@ -128,7 +128,7 @@ static void vsxxxaa_drop_bytes(struct vsxxxaa *mouse, int num)
 	if (num >= mouse->count) {
 		mouse->count = 0;
 	} else {
-		memmove(mouse->buf, mouse->buf + num - 1, BUFLEN - num);
+		memmove(mouse->buf, mouse->buf + num, BUFLEN - num);
 		mouse->count -= num;
 	}
 }
-- 
2.1.0.rc2.206.gedb03e5


-- 
Dmitry
