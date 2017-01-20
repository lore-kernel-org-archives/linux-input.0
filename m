From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] HID: wacom: do not shout an error on LED control
Date: Fri, 20 Jan 2017 16:20:14 +0100
Message-ID: <20170120152014.19775-5-benjamin.tissoires@redhat.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

At plug, the tablet seems to output a -EPIPE when first accessing the
LED. The weird part is that the command is taken into account by the
tablet, but we shout an error in the dmesg.

Cut off the error so that users are happier.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 6acb422..6acf3a3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -803,8 +803,12 @@ static int wacom_led_control(struct wacom *wacom)
 		buf[4] = wacom->led.img_lum;
 	}
 
-	retval = wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf, buf_size,
-				  WAC_CMD_RETRIES);
+	/*
+	 * we do not use wacom_set_report because -EPIPE happens but is
+	 * not fatal, so do not shout something at the user.
+	 */
+	retval = hid_hw_raw_request(wacom->hdev, buf[0], buf, buf_size,
+				    HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	kfree(buf);
 
 	return retval;
-- 
2.9.3
