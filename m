From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] hid-elo: kill not flush the work
Date: Tue, 31 May 2016 14:48:15 +0200
Message-ID: <1464698895-6788-1-git-send-email-oneukum@suse.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbcEaMvy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 08:51:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jslaby@suse.com, jikos@kernel.org, linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>, Oliver Neukum <ONeukum@suse.com>, stable@vger.kernel.org

Flushing a work that reschedules itself is not a sensible
operation. It needs to be killed. Failure to do so leads
to a kernel panic in the timer code.

Signed-off-by: Oliver Neukum <ONeukum@suse.com>
CC: stable@vger.kernel.org
---
 drivers/hid/hid-elo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index aad8c16..0cd4f72 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -261,7 +261,7 @@ static void elo_remove(struct hid_device *hdev)
 	struct elo_priv *priv = hid_get_drvdata(hdev);
 
 	hid_hw_stop(hdev);
-	flush_workqueue(wq);
+	cancel_delayed_work_sync(&priv->work);
 	kfree(priv);
 }
 
-- 
2.1.4

