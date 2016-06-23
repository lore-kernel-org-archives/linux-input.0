From: Allen Hung <allen_hung@dell.com>
Subject: [PATCH 1/2] Revert "HID: multitouch: enable palm rejection if device implements confidence usage"
Date: Thu, 23 Jun 2016 16:31:29 +0800
Message-ID: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:27575 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcFWIbr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 04:31:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Allen Hung <allen_hung@dell.com>

This reverts commit 25a84db15b3f ("HID: multitouch: enable palm rejection
if device implements confidence usage")

The commit enables palm rejection for Win8 Precision Touchpad devices but
the quirk MT_QUIRK_VALID_IS_CONFIDENCE it is using is not working very
properly. This quirk is originally designed for some WIn7 touchscreens. Use
of this for a Win8 Precision Touchpad will cause unexpected pointer jumping
problem.

Signed-off-by: Allen Hung <allen_hung@dell.com>
---
 drivers/hid/hid-multitouch.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 95b7d61..4ef7006 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -502,11 +502,6 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_CONFIDENCE:
-			if (cls->name == MT_CLS_WIN_8 &&
-				field->application == HID_DG_TOUCHPAD) {
-				cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
-				cls->quirks |= MT_QUIRK_VALID_IS_CONFIDENCE;
-			}
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_TIPSWITCH:
-- 
2.7.4

