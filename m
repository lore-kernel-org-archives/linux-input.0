From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] HID: multitouch: Synchronize MT frame on reset_resume
Date: Tue, 29 Mar 2016 22:10:41 +0200
Message-ID: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36845 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbcC2UKx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 16:10:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bleung@chromium.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>

input_mt_get_slot_by_key() requires input_mt_sync_frame() to be called
at each frame. Do it when releasing the touches, or else we won't get
a proper slot number after mt_reset_resume().

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/hid/hid-multitouch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 25d3c43..c741f5e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1169,6 +1169,7 @@ static void mt_release_contacts(struct hid_device *hid)
 							   MT_TOOL_FINGER,
 							   false);
 			}
+			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
 		}
 	}
-- 
2.8.0.rc3

