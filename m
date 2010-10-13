From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 3/6] hid: egalax: Correct for device resolution report error
Date: Wed, 13 Oct 2010 15:58:19 +0200
Message-ID: <1286978302-30034-4-git-send-email-rydberg@euromail.se>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:50636 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753547Ab0JMN7d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 09:59:33 -0400
In-Reply-To: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The firmware of both supported devices report a X/Y maximum of 4096,
whereas in reality, it is eight times larger. Fixed with this patch.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-egalax.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index 23f832b..3b490a3 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -56,6 +56,7 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_GENDESK:
 		switch (usage->hid) {
 		case HID_GD_X:
+			field->logical_maximum <<= 3;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_X);
 			set_abs(input, ABS_MT_POSITION_X, field, 0);
@@ -63,6 +64,7 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			set_abs(input, ABS_X, field, 0);
 			return 1;
 		case HID_GD_Y:
+			field->logical_maximum <<= 3;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_Y);
 			set_abs(input, ABS_MT_POSITION_Y, field, 0);
-- 
1.7.1

