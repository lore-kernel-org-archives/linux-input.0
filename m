From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] input: wacom: Fix 3rd-gen Bamboo MT when 4+ fingers are in use
Date: Mon,  5 Mar 2012 18:21:37 -0800
Message-ID: <1331000497-10439-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35279 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066Ab2CFCVr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Mar 2012 21:21:47 -0500
Received: by dadp12 with SMTP id p12so5940661dad.11
        for <linux-input@vger.kernel.org>; Mon, 05 Mar 2012 18:21:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

The message count field uses three bits of storage, not two.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9283507..d0b0fc4 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -938,7 +938,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
 	unsigned char *data = wacom->data;
-	int count = data[1] & 0x03;
+	int count = data[1] & 0x07;
 	int i;
 
 	if (data[0] != 0x02)
-- 
1.7.9.1

