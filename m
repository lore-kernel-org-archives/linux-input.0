From: James C Boyd <jcboyd.dev@gmail.com>
Subject: [PATCH 2/3] HID: hid-input: Simplify conditional expression
Date: Wed, 27 May 2015 17:09:07 -0500
Message-ID: <d4025bf32f5aed21214e21cb715ad5bc539e1b01.1432761541.git.jcboyd.dev@gmail.com>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35357 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbE0WJN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 18:09:13 -0400
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

There are too many bangs in this conditional; therefore
remove them while still maintaining the same logic.

Signed-off-by: James C Boyd <jcboyd.dev@gmail.com>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 714b758..abf4fc6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,7 +1157,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	/* report the usage code as scancode if the key status has changed */
-	if (usage->type == EV_KEY && (!!test_bit(usage->code, input->key)) != value)
+	if (usage->type == EV_KEY && (!test_bit(usage->code, input->key)) == value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
 
 	input_event(input, usage->type, usage->code, value);
-- 
