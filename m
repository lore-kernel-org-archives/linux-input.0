From: James C Boyd <jcboyd.dev@gmail.com>
Subject: [PATCH 1/3] HID: hid-input: Add parentheses to quell gcc warning
Date: Wed, 27 May 2015 17:09:06 -0500
Message-ID: <52701fbbd735e63de07c162b236726fb78bce02f.1432761541.git.jcboyd.dev@gmail.com>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

GCC reports a -Wlogical-not-parentheses warning here; therefore
add parentheses to shut it up and to express our intent more.

Signed-off-by: James C Boyd <jcboyd.dev@gmail.com>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 008e89b..714b758 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,7 +1157,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	/* report the usage code as scancode if the key status has changed */
-	if (usage->type == EV_KEY && !!test_bit(usage->code, input->key) != value)
+	if (usage->type == EV_KEY && (!!test_bit(usage->code, input->key)) != value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
 
 	input_event(input, usage->type, usage->code, value);
--
