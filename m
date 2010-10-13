From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 4/6] hid: egalax: Report zero as minimum pressure
Date: Wed, 13 Oct 2010 15:58:20 +0200
Message-ID: <1286978302-30034-5-git-send-email-rydberg@euromail.se>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
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
index 3b490a3..2aba897 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -93,6 +93,7 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			input_set_events_per_packet(input, MAX_EVENTS);
 			return 1;
 		case HID_DG_TIPPRESSURE:
+			field->logical_minimum = 0;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
 			set_abs(input, ABS_MT_PRESSURE, field, 0);
-- 
1.7.1
