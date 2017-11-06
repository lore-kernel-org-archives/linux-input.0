From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/3] HID: multitouch: Properly deal with reports with 0 touches
Date: Mon,  6 Nov 2017 16:01:48 +0100
Message-ID: <20171106150149.13986-2-hdegoede@redhat.com>
References: <20171106150149.13986-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbdKFPBz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 10:01:55 -0500
In-Reply-To: <20171106150149.13986-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The Windows Precision Touchpad spec "Figure 4 Button Only Down and Up"
and "Table 9 Report Sequence for Button Only Down and Up" indicate
that the first packet of a (possibly hybrid mode multi-packet) report
may contain a contact-count of 0 if only a button is pressed and no
fingers are detected.

This means that a value of 0 for contact-count is a valid value and
should be used as expected contact count when num_received == 0.

The only other case where we may get a contact count value of 0
when num_received == 0 is when we're somehow out of sync and in
that case setting num_expected to 0 so that we ignore contacts
until we're back in sync again also is the right thing to do.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index bb939f6990f1..76a3e9e074ba 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -827,7 +827,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	if (td->cc_index >= 0) {
 		struct hid_field *field = report->field[td->cc_index];
 		int value = field->value[td->cc_value_index];
-		if (value)
+		if (value || td->num_received == 0)
 			td->num_expected = value;
 	}
 
-- 
2.14.3

