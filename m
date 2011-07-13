From: chris.hudson.comp.eng@gmail.com
Subject: [PATCH] kxtj9: fix input device allocation sequence
Date: Wed, 13 Jul 2011 10:48:39 -0400
Message-ID: <1310568519-28103-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kionix.com ([66.152.113.154]:59637 "EHLO mail.kionix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab1GMOsF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2011 10:48:05 -0400
Received: from mail1.kionix.com (localhost [127.0.0.1])
	by mail.kionix.com (Spam Firewall) with ESMTP id 287871F1D83
	for <linux-input@vger.kernel.org>; Wed, 13 Jul 2011 10:48:02 -0400 (EDT)
Received: from mail1.kionix.com ([10.0.0.125]) by mail.kionix.com with ESMTP id gRVR9PksMESRZn9p for <linux-input@vger.kernel.org>; Wed, 13 Jul 2011 10:48:02 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

Small bug fix patch against the driver version in Dmitry's queue.  Resulting
driver tested on hardware in both polled and IRQ modes.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 drivers/input/misc/kxtj9.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 1788390..1799430 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -426,7 +426,7 @@ static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *tj9)
 	struct input_polled_dev *poll_dev;
 	poll_dev = input_allocate_polled_device();
 
-	if (!tj9->poll_dev) {
+	if (!poll_dev) {
 		dev_err(&tj9->client->dev,
 			"Failed to allocate polled device\n");
 		return -ENOMEM;
-- 
1.5.4.3

