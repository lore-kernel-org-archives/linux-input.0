From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: input: Finish TransducerSerialNumber implementation
Date: Mon, 22 Sep 2014 09:58:50 -0700
Message-ID: <1411405130-1663-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41485 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbaIVQ64 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Sep 2014 12:58:56 -0400
Received: by mail-pa0-f49.google.com with SMTP id lf10so4925199pab.36
        for <linux-input@vger.kernel.org>; Mon, 22 Sep 2014 09:58:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The commit which introduced TransducerSerialNumber (368c966) is missing
two crucial implementation details. Firstly, the commit does not set the
type/code/bit/max fields as expected later down the code which can cause
the driver to crash when a tablet with this usage is connected. Secondly,
the code to send a MSC_SERIAL event to userspace when this usage is seen
in a report is nowhere to be found. This commit addresses both issues.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/hid-input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2619f7f..abed624 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -690,6 +690,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		case 0x5b: /* TransducerSerialNumber */
 			set_bit(MSC_SERIAL, input->mscbit);
+			usage->type = EV_MSC;
+			usage->code = MSC_SERIAL;
+			bit = input->mscbit;
+			max = MSC_MAX;
 			break;
 
 		default:  goto unknown;
@@ -1041,6 +1045,11 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
 	}
 
+	if (usage->hid == (HID_UP_DIGITIZER | 0x005b)) { /* TransducerSerialNumber */
+		input_event(input, EV_MSC, MSC_SERIAL, value);
+		return;
+	}
+
 	if (usage->hid == (HID_UP_PID | 0x83UL)) { /* Simultaneous Effects Max */
 		dbg_hid("Maximum Effects - %d\n",value);
 		return;
-- 
2.1.0

