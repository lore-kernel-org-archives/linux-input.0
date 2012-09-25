From: Jesse Sung <jesse.sung@canonical.com>
Subject: [PATCH resend] N-Trig: change default value of logical/physical width/height to 1
Date: Tue, 25 Sep 2012 18:51:07 +0800
Message-ID: <1348570267-15322-1-git-send-email-jesse.sung@canonical.com>
References: <1347956828-5967-1-git-send-email-jesse.sung@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39199 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab2IYKvx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 06:51:53 -0400
In-Reply-To: <1347956828-5967-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Jiri Kosina <jkosina@suse.cz>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

Since something will be divided by these variables in
show_min_width()/show_min_height() and show_activate_width()/
show_activate_height(), a divided error would be triggered if
they are zero.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/hid/hid-ntrig.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 9fae2eb..86a969f 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -882,10 +882,10 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	nd->activate_slack = activate_slack;
 	nd->act_state = activate_slack;
 	nd->deactivate_slack = -deactivate_slack;
-	nd->sensor_logical_width = 0;
-	nd->sensor_logical_height = 0;
-	nd->sensor_physical_width = 0;
-	nd->sensor_physical_height = 0;
+	nd->sensor_logical_width = 1;
+	nd->sensor_logical_height = 1;
+	nd->sensor_physical_width = 1;
+	nd->sensor_physical_height = 1;
 
 	hid_set_drvdata(hdev, nd);
 
-- 
1.7.9.5

