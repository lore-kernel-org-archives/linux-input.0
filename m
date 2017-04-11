From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v4 5/5] hid-logitech-hidpp: add support for ratchet switch
Date: Tue, 11 Apr 2017 10:29:42 -0300
Message-ID: <42d4c04d292c6788695036b77d8c0e3517e816ec.1491917052.git.mchehab@s-opensource.com>
References: <cover.1491917052.git.mchehab@s-opensource.com>
 <34b4f3e6baedde818516ceb1d009f6568b953345.1491917052.git.mchehab@s-opensource.com>
 <5656f59d7fb0590dd139c5e6b597bd56e823bd94.1491917052.git.mchehab@s-opensource.com>
 <ac259b5cece918d6f01d45b55fb0135f64f9c6a1.1491917052.git.mchehab@s-opensource.com>
 <d7625d213eb7bd81799443437f7424162799d664.1491917052.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59413
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751390AbdDKNaK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 09:30:10 -0400
In-Reply-To: <d7625d213eb7bd81799443437f7424162799d664.1491917052.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491917052.git.mchehab@s-opensource.com>
References: <cover.1491917052.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jiri Kosina <jikos@kernel.org>

Logitech Anywhere MX2 and MX master produce events for
the wheel ratchet/free wheel button. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/hid/hid-logitech-hidpp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 20ced3f519ae..fa5a28cc77ca 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2031,6 +2031,19 @@ static int hidpp_mouse_set_wheel_mode(struct hidpp_device *hidpp,
 			return ret;
 	}
 
+	ret = hidpp_send_fap_command_sync(hidpp, hrd->feature_index,
+					  CMD_MOUSE_GET_WHEEL_RATCHET,
+					  params, 0, &response);
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
 	params[0] = (invert     ? BIT(2) : 0)  |
 		    (high_res   ? BIT(1) : 0)  |
 		    (hidpp_mode ? BIT(0) : 0);
@@ -2564,10 +2577,11 @@ static int high_res_raw_event(struct hid_device *hdev, u8 *data, int size)
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
 
@@ -2580,6 +2594,11 @@ static void high_res_populate_input(struct hidpp_device *hidpp,
 
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

