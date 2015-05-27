From: James C Boyd <jcboyd.dev@gmail.com>
Subject: [PATCH 3/3] HID: hid-input: Fix coding style issue
Date: Wed, 27 May 2015 17:09:08 -0500
Message-ID: <6ef471e95d8de89ee4cce5182ff4785d0a67fdc4.1432761541.git.jcboyd.dev@gmail.com>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This line is too long; split it up.

Signed-off-by: James C Boyd <jcboyd.dev@gmail.com>
---
 drivers/hid/hid-input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index abf4fc6..3511bbab 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,7 +1157,8 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	/* report the usage code as scancode if the key status has changed */
-	if (usage->type == EV_KEY && (!test_bit(usage->code, input->key)) == value)
+	if (usage->type == EV_KEY &&
+	    (!test_bit(usage->code, input->key)) == value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
 
 	input_event(input, usage->type, usage->code, value);
-- 
