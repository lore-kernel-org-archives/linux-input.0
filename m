From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: hidraw: fix power sequence when closing device
Date: Tue, 19 Sep 2017 18:37:46 -0700
Message-ID: <20170920013746.GA33367@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34342 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdITBhu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 21:37:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Oliver Neukum <oneukum@suse.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We should not try to bring HID device out of full power state before
calling hid_hw_close(), so that transport driver operates on powered up
device (making this inverse of the opening sequence).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hidraw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index ec530454e6f6..5fbe0f81ab2e 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -337,8 +337,8 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
 			kfree(hidraw);
 		} else {
 			/* close device for last reader */
-			hid_hw_power(hidraw->hid, PM_HINT_NORMAL);
 			hid_hw_close(hidraw->hid);
+			hid_hw_power(hidraw->hid, PM_HINT_NORMAL);
 		}
 	}
 }
-- 
2.14.1.821.g8fa685d3b7-goog


-- 
Dmitry
