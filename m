From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 3/4] HID: multitouch: drop reports containing invalid values
Date: Sat, 30 Jun 2018 14:19:52 -1000
Message-ID: <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

Avoid processing reports containing invalid values to reduce
multitouch input stutter.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c0654db0b736543ca0..08b50e5908cecdda66 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -694,10 +694,19 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 {
 	if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
 	    td->num_received >= td->num_expected)
 		return;
 
+	/* drop invalid values after counting them */
+	if (td->curdata.x == 0xffff &&
+			td->curdata.y == 0xffff &&
+			td->curdata.w == 0xffff &&
+			td->curdata.h == 0xffff) {
+		td->num_received++;
+		return;
+	}
+
 	if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
 		int active;
 		int slotnum = mt_compute_slot(td, input);
 		struct mt_slot *s = &td->curdata;
 		struct input_mt *mt = input->mt;
-- 
2.18.0
