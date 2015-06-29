From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add hover event for ST format
Date: Mon, 29 Jun 2015 09:19:09 +0800
Message-ID: <C24448D4-9078-4EE9-8E40-A2C8DC6115A6@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:46671 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbF2BTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2015 21:19:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: dusonlin@emc.com.tw

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 62641f2..ce97e28 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -847,6 +847,7 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	}
 
 	input_report_key(input, BTN_LEFT, tp_info & 0x01);
+	input_report_abs(input, ABS_DISTANCE, hover_event != 0);
 	input_mt_report_pointer_emulation(input, true);
 	input_sync(input);
 }
@@ -922,6 +923,7 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 	input_abs_set_res(input, ABS_Y, data->y_res);
 	input_set_abs_params(input, ABS_PRESSURE, 0, ETP_MAX_PRESSURE, 0, 0);
 	input_set_abs_params(input, ABS_TOOL_WIDTH, 0, ETP_FINGER_WIDTH, 0, 0);
+	input_set_abs_params(input, ABS_DISTANCE, 0, 1, 0, 0);
 
 	/* And MT parameters */
 	input_set_abs_params(input, ABS_MT_POSITION_X, 0, data->max_x, 0, 0);




