From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: Wacom: switch Dell canvas into highres mode
Date: Fri,  3 Nov 2017 18:29:47 +0100
Message-ID: <20171103172947.15156-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbdKCR34 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 3 Nov 2017 13:29:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

The Dell Canvas exports 2 collections for the Pen part. The only
difference between the 2 is that the default one has half the resolution
of the second one.

The Windows driver switches the tablet into the second mode, so we should
behave the same.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

well, this is not the cleanest way of handling this mode set, but it is the
less intrusive AFAICT.

I was thinking that we might want to add a new field in struct wacom_feature,
but then it wouldn't make sense to keep the set mode specifics in
_wacom_query_tablet_data().

So I am open to any better suggestion, but this one works and the impact on
other HID generic tablets is null.

Cheers,
Benjamin

 drivers/hid/wacom_sys.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 906e654fb0ba..ee71ad9b6cc1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -196,6 +196,13 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 		kfree(data);
 		break;
 	}
+
+	if (hdev->vendor == USB_VENDOR_ID_WACOM &&
+	    hdev->product == 0x4200 /* Dell Canvas 27 */ &&
+	    field->application == HID_UP_MSVENDOR) {
+		wacom->wacom_wac.mode_report = field->report->id;
+		wacom->wacom_wac.mode_value = 2;
+	}
 }
 
 /*
-- 
2.14.3

