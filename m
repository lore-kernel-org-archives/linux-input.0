From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4/4] hid-logitech-hidpp: add support for ratchet switch
Date: Mon,  3 Apr 2017 16:35:32 -0300
Message-ID: <e36e3e5264d97057ecd5f9dee661d93c869bc749.1491247515.git.mchehab@s-opensource.com>
References: <cover.1491247515.git.mchehab@s-opensource.com>
 <61af20504c6b06adfb523ae4d734cbda6b6ff545.1491247515.git.mchehab@s-opensource.com>
 <d97a4e2f927e36a29d3f41c5e19f87e26db90509.1491247515.git.mchehab@s-opensource.com>
 <beaf4d8c0c84335b7323a5cf1754cc8cbdf694cf.1491247515.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54449 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbdDCTfy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 15:35:54 -0400
In-Reply-To: <beaf4d8c0c84335b7323a5cf1754cc8cbdf694cf.1491247515.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491247515.git.mchehab@s-opensource.com>
References: <cover.1491247515.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Logitech Anywhere MX2 and MX master produce events for
the wheel ratchet/free wheel button. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/hid/hid-logitech-hidpp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c208a5107511..6177087ffaca 100644
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


