From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/5] HID:hid-lg4ff: Switch autocentering off when strength is set to zero.
Date: Wed,  6 Nov 2013 12:30:41 -0700
Message-ID: <1383766244-2336-2-git-send-email-simon@mungewell.org>
References: <1383766244-2336-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383766244-2336-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, Elias Vanderstuyft <elias.vds@gmail.com>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@prifuk.cz>
List-Id: linux-input@vger.kernel.org

When the autocenter is set to zero, this patch issues a command to
totally disable the autocenter - this results in less resistance
in the wheel.

Reported-by: Elias Vanderstuyft <elias.vds@gmail.com>
Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 530fcd19..49f6cc0 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -220,6 +220,20 @@ static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u16 magnitud
 	__s32 *value = report->field[0]->value;
 	__u32 expand_a, expand_b;
 
+	/* De-activate Auto-Center */
+	if (magnitude == 0) {
+		value[0] = 0xf5;
+		value[1] = 0x00;
+		value[2] = 0x00;
+		value[3] = 0x00;
+		value[4] = 0x00;
+		value[5] = 0x00;
+		value[6] = 0x00;
+
+		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		return;
+	}
+
 	if (magnitude <= 0xaaaa) {
 		expand_a = 0x0c * magnitude;
 		expand_b = 0x80 * magnitude;
@@ -237,6 +251,17 @@ static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u16 magnitud
 	value[6] = 0x00;
 
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+
+	/* Activate Auto-Center */
+	value[0] = 0x14;
+	value[1] = 0x00;
+	value[2] = 0x00;
+	value[3] = 0x00;
+	value[4] = 0x00;
+	value[5] = 0x00;
+	value[6] = 0x00;
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 }
 
 /* Sends autocentering command compatible with Formula Force EX */
-- 
1.8.1.2
