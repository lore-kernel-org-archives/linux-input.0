From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH RFC 4/4] hid-logitech-hidpp: add support for ratchet switch
Date: Sat, 25 Mar 2017 19:49:42 -0300
Message-ID: <9c21f1c0527613a64edc2b3e0b7a8d8861f6e0fb.1490481944.git.mchehab@s-opensource.com>
References: <cover.1490481944.git.mchehab@s-opensource.com>
 <cf7b2e1587f2986abfa7252f9e8d2799b20911cc.1490481944.git.mchehab@s-opensource.com>
 <2529a55b0477cc638f1104a423cb67de1628a96d.1490481944.git.mchehab@s-opensource.com>
 <c48652786b1e139503834f67b1a5037ff677a174.1490481944.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdCYWu3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 18:50:29 -0400
In-Reply-To: <c48652786b1e139503834f67b1a5037ff677a174.1490481944.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1490481944.git.mchehab@s-opensource.com>
References: <cover.1490481944.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>

Logitech Anywhere MX2 and MX master produce events for
the wheel ratchet/free wheel button. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/hid/hid-logitech-hidpp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ee3f544bda4f..72f80869633f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1406,6 +1406,19 @@ static int hidpp_mouse_set_wheel_mode(struct hidpp_device *hidpp,
 			return ret;
 	}
 
+	ret = hidpp_send_fap_command_sync(hidpp, hrd->feature_index,
+					  CMD_MOUSE_GET_WHEEL_RATCHET,
+					  params, 16, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	hrd->ratchet = response.fap.params[0] & 0x01;
+
 	params[0] = invert     ? 0x4 : 0  |
 		    high_res   ? 0x2 : 0  |
 		    hidpp_mode ? 0x1 : 0;
@@ -1945,10 +1958,11 @@ static int high_res_raw_event(struct hid_device *hdev, u8 *data, int size)
 			input_report_rel(hrd->input, REL_HIRES_WHEEL, delta);
 		else
 			input_report_rel(hrd->input, REL_WHEEL, delta);
+	} else if (data[3] == 0x10) {
+		hrd->ratchet = data[4] & 0x01;
+		input_report_switch(hrd->input, SW_RATCHET, hrd->ratchet);
 	}
 
-	/* FIXME: also report ratchet events to userspace */
-
 	return 1;
 }
 
@@ -1961,6 +1975,11 @@ static void high_res_populate_input(struct hidpp_device *hidpp,
 
 	__set_bit(REL_WHEEL, hrd->input->relbit);
 	__set_bit(REL_HIRES_WHEEL, hrd->input->relbit);
+	__set_bit(EV_SW, hrd->input->evbit);
+	__set_bit(SW_RATCHET, hrd->input->swbit);
+
+	/* Report current state of the ratchet switch */
+	input_report_switch(hrd->input, SW_RATCHET, hrd->ratchet);
 }
 
 
-- 
2.9.3


