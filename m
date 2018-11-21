From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/7] Revert "HID: input: Create a utility class for counting scroll events"
Date: Wed, 21 Nov 2018 16:27:11 +0100
Message-ID: <20181121152712.6770-7-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, torvalds@linux-foundation.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit 1ff2e1a44e02d4bdbb9be67c7d9acc240a67141f.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 45 -----------------------------------------
 include/linux/hid.h     | 28 -------------------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 28ee2ed88a1a..d6fab5798487 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1841,48 +1841,3 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
-/**
- * hid_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
- *                                      events given a high-resolution wheel
- *                                      movement.
- * @counter: a hid_scroll_counter struct describing the wheel.
- * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
- *                units.
- *
- * Given a high-resolution movement, this function converts the movement into
- * microns and emits high-resolution scroll events for the input device. It also
- * uses the multiplier from &struct hid_scroll_counter to emit low-resolution
- * scroll events when appropriate for backwards-compatibility with userspace
- * input libraries.
- */
-void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
-				      int hi_res_value)
-{
-	int low_res_scroll_amount;
-	/* Some wheels will rest 7/8ths of a notch from the previous notch
-	 * after slow movement, so we want the threshold for low-res events to
-	 * be in the middle of the notches (e.g. after 4/8ths) as opposed to on
-	 * the notches themselves (8/8ths).
-	 */
-	int threshold = counter->resolution_multiplier / 2;
-
-	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
-			 hi_res_value * counter->microns_per_hi_res_unit);
-
-	counter->remainder += hi_res_value;
-	if (abs(counter->remainder) >= threshold) {
-		/* Add (or subtract) 1 because we want to trigger when the wheel
-		 * is half-way to the next notch (i.e. scroll 1 notch after a
-		 * 1/2 notch movement, 2 notches after a 1 1/2 notch movement,
-		 * etc.).
-		 */
-		low_res_scroll_amount =
-			counter->remainder / counter->resolution_multiplier
-			+ (hi_res_value > 0 ? 1 : -1);
-		input_report_rel(counter->dev, REL_WHEEL,
-				 low_res_scroll_amount);
-		counter->remainder -=
-			low_res_scroll_amount * counter->resolution_multiplier;
-	}
-}
-EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 387c70df6f29..a355d61940f2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1139,34 +1139,6 @@ static inline u32 hid_report_len(struct hid_report *report)
 int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
-
-/**
- * struct hid_scroll_counter - Utility class for processing high-resolution
- *                             scroll events.
- * @dev: the input device for which events should be reported.
- * @microns_per_hi_res_unit: the amount moved by the user's finger for each
- *                           high-resolution unit reported by the mouse, in
- *                           microns.
- * @resolution_multiplier: the wheel's resolution in high-resolution mode as a
- *                         multiple of its lower resolution. For example, if
- *                         moving the wheel by one "notch" would result in a
- *                         value of 1 in low-resolution mode but 8 in
- *                         high-resolution, the multiplier is 8.
- * @remainder: counts the number of high-resolution units moved since the last
- *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
- *             only be used by class methods.
- */
-struct hid_scroll_counter {
-	struct input_dev *dev;
-	int microns_per_hi_res_unit;
-	int resolution_multiplier;
-
-	int remainder;
-};
-
-void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
-				      int hi_res_value);
-
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
 int hid_quirks_init(char **quirks_param, __u16 bus, int count);
-- 
2.19.1
