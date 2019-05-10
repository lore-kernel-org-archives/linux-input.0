From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 3/4] HID: wacom: correct touch resolution x/y typo
Date: Fri, 10 May 2019 15:34:18 -0700
Message-ID: <1557527659-9417-2-git-send-email-aaron.skomra@wacom.com>
References: <1557527659-9417-1-git-send-email-aaron.skomra@wacom.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1557527659-9417-1-git-send-email-aaron.skomra@wacom.com>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, pinglinux@gmail.com, jason.gerecke@wacom.com
Cc: Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 11+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

This affects the 2nd-gen Intuos Pro Medium and Large
when using their Bluetooth connection.

Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e172c7dda68c..447394cc4222 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3716,7 +3716,7 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 					     0, 5920, 4, 0);
 		}
 		input_abs_set_res(input_dev, ABS_MT_POSITION_X, 40);
-		input_abs_set_res(input_dev, ABS_MT_POSITION_X, 40);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_Y, 40);
 
 		/* fall through */
 
-- 
2.7.4
