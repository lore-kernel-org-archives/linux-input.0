From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: mousedev - rename mixdev_open to opened_by_mixdev
Date: Wed,  3 Oct 2012 14:03:01 -0700
Message-ID: <1349298182-22452-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36181 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab2JCVDJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Oct 2012 17:03:09 -0400
Received: by padhz1 with SMTP id hz1so6733386pad.19
        for <linux-input@vger.kernel.org>; Wed, 03 Oct 2012 14:03:09 -0700 (PDT)
In-Reply-To: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Do the rename to make the logic more clear and also change it to bool
while at it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mousedev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 91f6220..2baf32d 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -68,7 +68,7 @@ struct mousedev {
 	bool exist;
 
 	struct list_head mixdev_node;
-	int mixdev_open;
+	bool opened_by_mixdev;
 
 	struct mousedev_hw_data packet;
 	unsigned int pkt_count;
@@ -469,11 +469,11 @@ static void mixdev_open_devices(void)
 		return;
 
 	list_for_each_entry(mousedev, &mousedev_mix_list, mixdev_node) {
-		if (!mousedev->mixdev_open) {
+		if (!mousedev->opened_by_mixdev) {
 			if (mousedev_open_device(mousedev))
 				continue;
 
-			mousedev->mixdev_open = 1;
+			mousedev->opened_by_mixdev = true;
 		}
 	}
 }
@@ -491,8 +491,8 @@ static void mixdev_close_devices(void)
 		return;
 
 	list_for_each_entry(mousedev, &mousedev_mix_list, mixdev_node) {
-		if (mousedev->mixdev_open) {
-			mousedev->mixdev_open = 0;
+		if (mousedev->opened_by_mixdev) {
+			mousedev->opened_by_mixdev = false;
 			mousedev_close_device(mousedev);
 		}
 	}
@@ -935,7 +935,7 @@ static int mixdev_add_device(struct mousedev *mousedev)
 		if (retval)
 			goto out;
 
-		mousedev->mixdev_open = 1;
+		mousedev->opened_by_mixdev = true;
 	}
 
 	get_device(&mousedev->dev);
@@ -950,8 +950,8 @@ static void mixdev_remove_device(struct mousedev *mousedev)
 {
 	mutex_lock(&mousedev_mix->mutex);
 
-	if (mousedev->mixdev_open) {
-		mousedev->mixdev_open = 0;
+	if (mousedev->opened_by_mixdev) {
+		mousedev->opened_by_mixdev = false;
 		mousedev_close_device(mousedev);
 	}
 
-- 
1.7.11.4

