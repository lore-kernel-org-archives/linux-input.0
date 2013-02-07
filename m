From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 1/2] Input: misc/bma150.c, fix checking pm_runtime_get_sync() return value
Date: Fri,  8 Feb 2013 00:58:24 +0100
Message-ID: <1360281506-13618-2-git-send-email-ospite@studenti.unina.it>
References: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:57996 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab3BGX7S (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 18:59:18 -0500
In-Reply-To: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Albert Zhang <xu.zhang@bosch-sensortec.com>, Eric Andersson <eric.andersson@unixphere.com>, Jonathan Cameron <jic23@cam.ac.uk>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>

From: Michael Trimarchi <michael@amarulasolutions.com>

When PM_RUNTIME is not defined, pm_runtime_get_sync() returns 1, see
include/linux/pm_runtime.c::__pm_runtime_resume(), and the check of the
return value was overlooking this, in this case bma150_open() would
return 1 which is not expected by upper layers.

Maybe the check for != -ENOSYS (Function not implemented) was meant to
cover this, but pm_runtime_get_sync() does not return this value.

For now fix the issue locally by checking explicitly for negative return
values.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 drivers/input/misc/bma150.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 08ffcab..e5d1894 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -372,7 +372,7 @@ static int bma150_open(struct bma150_data *bma150)
 	int error;
 
 	error = pm_runtime_get_sync(&bma150->client->dev);
-	if (error && error != -ENOSYS)
+	if (error < 0 && error != -ENOSYS)
 		return error;
 
 	/*
-- 
1.7.10.4

