From: =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: /input/input-mt.c Emit BTN_TOO_FINGER in function input_mt_report_pointer_emulation if touchpad meets hover condition Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Thu, 2 Jun 2016 19:57:27 +0800
Message-ID: <005701d1bcc5$ef2c92b0$cd85b810$@emc.com.tw>
References: <1464493153-2509-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464493153-2509-1-git-send-email-kt.liao@emc.com.tw>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, jeff.chung@emc.com.tw, charliemooney@google.com, agnescheng@google.com, 'jeff' <jeff.chuang@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I up-streamed the patch last Sunday, please let me know if you have other
concern.

Thanks your support   KT

-----Original Message-----
From: KT Liao [mailto:ktalex.liao@gmail.com] 
Sent: Sunday, May 29, 2016 11:39 AM
To: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw; kt.liao@emc.com.tw; jeff.chung@emc.com.tw;
charliemooney@google.com
Subject: [PATCH] Input: /input/input-mt.c Emit BTN_TOO_FINGER in function
input_mt_report_pointer_emulation if touchpad meets hover condition
Signed-off-by: KT Liao <kt.liao@emc.com.tw>

---
 drivers/input/input-mt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c index
54fce56..b89aaa7 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -218,8 +218,17 @@ void input_mt_report_pointer_emulation(struct input_dev
*dev, bool use_count)
 	}
 
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
-	if (use_count)
+
+	if (use_count) {
+		if (count == 0 &&
+		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&
+		    test_bit(ABS_DISTANCE, dev->absbit) &&
+		    input_abs_get_val(dev, ABS_DISTANCE) != 0) {
+			count = 1;
+		}
 		input_mt_report_finger_count(dev, count);
+	}
+
 
 	if (oldest) {
 		int x = input_mt_get_value(oldest, ABS_MT_POSITION_X);
