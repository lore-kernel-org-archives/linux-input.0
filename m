From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] input: goodix: Check the 'data ready' bit before reading data
Date: Sat, 25 Apr 2015 12:48:10 +0200
Message-ID: <1429958890-10366-1-git-send-email-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-input@vger.kernel.org

The MSB of the first byte read via I2C seems to indicate whether the
data is valid (or ready) when an interrupt is raised. Previously, this
bit was ignored, which resulted in a lot of incorrect detections of
"finger removed" events.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/input/touchscreen/goodix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index ca19668..9fa6c5f 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -98,6 +98,9 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 		return error;
 	}
 
+	if (!(data[0] & 0x80))
+		return -EAGAIN;
+
 	touch_num = data[0] & 0x0f;
 	if (touch_num > GOODIX_MAX_CONTACTS)
 		return -EPROTO;
-- 
2.1.4
