From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH] input:kxtj9:check the return value of kxtj9_enable()
Date: Wed, 20 Jul 2011 14:48:22 +0800
Message-ID: <1311144502-16932-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:49398 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab1GTGt2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 02:49:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, chudson@kionix.com, Wanlong Gao <gaowanlong@cn.fujitsu.com>

If don't check the return value of kxtj9_enable(), the kxtj9_resume()
will always return 0 instead.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/kxtj9.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index a416f7f..b835c29 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -627,7 +627,7 @@ static int kxtj9_resume(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		kxtj9_enable(tj9);
+		retval = kxtj9_enable(tj9);
 
 	mutex_unlock(&input_dev->mutex);
 	return retval;
-- 
1.7.6

