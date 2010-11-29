From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 4/7] hid: egalax: Report zero as minimum pressure (rev2)
Date: Mon, 29 Nov 2010 08:43:29 +0100
Message-ID: <1291016612-25102-5-git-send-email-rydberg@euromail.se>
References: <1291016612-25102-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291016612-25102-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

The firmware reports a logical minimum of one, but in order for
userspace applications to correctly map all reported values to
non-zero pressure, the driver needs to report a logical minimum of
zero.  Fixed with this patch.

Tested-by: Philipp Merkel <mail@philmerk.de>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-egalax.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index b3a1139..a6ab617 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -90,6 +90,7 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			set_abs(input, ABS_MT_TRACKING_ID, field, 0);
 			return 1;
 		case HID_DG_TIPPRESSURE:
+			field->logical_minimum = 0;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
 			set_abs(input, ABS_MT_PRESSURE, field, 0);
-- 
1.7.1
