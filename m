From: Allen Hung <allen_hung@dell.com>
Subject: [PATCH 1/1] HID: multitouch: enable palm rejection if device implements confidence usage
Date: Wed, 18 Nov 2015 17:41:46 +0800
Message-ID: <1447839706-3192-1-git-send-email-allen_hung@dell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:4710 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbbKRJvb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2015 04:51:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Allen Hung <allen_hung@dell.com>

The usage Confidence is mandary to Windows Precision Touchpad devices. The
appearance of this usage is checked in hidinput_connect but the quirk
MT_QUIRK_VALID_IS_CONFIDENCE is not applied to the device accordingly.
Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable the
palm rejection for the devices which implement the usage confidence in its
input reports.

Tested on Dell XPS 13 laptop.

Signed-off-by: Allen Hung <allen_hung@dell.com>
---
 drivers/hid/hid-multitouch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 426b2f1..661de1d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -448,6 +448,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_CONFIDENCE:
+			cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
+			cls->quirks |= MT_QUIRK_VALID_IS_CONFIDENCE;
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_TIPSWITCH:
-- 
1.9.1

