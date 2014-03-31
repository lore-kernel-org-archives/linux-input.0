From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: core: do not scan constant input report
Date: Mon, 31 Mar 2014 13:27:10 -0400
Message-ID: <1396286830-2795-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1396286830-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396286830-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>, Derya <derya.kiran@yahoo.de>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Microsoft Surface Type/Touch Cover 2 is a fancy device which advertised
itself as a multitouch device but with constant input reports.
This way, hid_scan_report() gives the group MULTITOUCH to it, but
hid-multitouch can not handle it due to the constant collection ignored
by hid-input.

To prevent such crap in the future, and while we do not fix this particular
device, make the scan_report coherent with hid-input.c, and ignore constant
input reports.

CC: stable@vger.kernel.org # 3.12+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bb5c494..8a5384c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -718,6 +718,9 @@ static int hid_scan_main(struct hid_parser *parser, struct hid_item *item)
 	case HID_MAIN_ITEM_TAG_END_COLLECTION:
 		break;
 	case HID_MAIN_ITEM_TAG_INPUT:
+		/* ignore constant inputs, they will be ignored by hid-input */
+		if (data & HID_MAIN_ITEM_CONSTANT)
+			break;
 		for (i = 0; i < parser->local.usage_index; i++)
 			hid_scan_input_usage(parser, parser->local.usage[i]);
 		break;
-- 
1.9.0
