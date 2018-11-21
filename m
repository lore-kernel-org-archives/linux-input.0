From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/7] Revert "HID: input: simplify/fix high-res scroll event handling"
Date: Wed, 21 Nov 2018 16:27:06 +0100
Message-ID: <20181121152712.6770-2-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, torvalds@linux-foundation.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit 044ee890286153a1aefb40cb8b6659921aecb38b.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 44ea8e7c71a9..28ee2ed88a1a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1858,30 +1858,31 @@ EXPORT_SYMBOL_GPL(hidinput_disconnect);
 void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
 				      int hi_res_value)
 {
-	int low_res_value, remainder, multiplier;
+	int low_res_scroll_amount;
+	/* Some wheels will rest 7/8ths of a notch from the previous notch
+	 * after slow movement, so we want the threshold for low-res events to
+	 * be in the middle of the notches (e.g. after 4/8ths) as opposed to on
+	 * the notches themselves (8/8ths).
+	 */
+	int threshold = counter->resolution_multiplier / 2;
 
 	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
 			 hi_res_value * counter->microns_per_hi_res_unit);
 
-	/*
-	 * Update the low-res remainder with the high-res value,
-	 * but reset if the direction has changed.
-	 */
-	remainder = counter->remainder;
-	if ((remainder ^ hi_res_value) < 0)
-		remainder = 0;
-	remainder += hi_res_value;
-
-	/*
-	 * Then just use the resolution multiplier to see if
-	 * we should send a low-res (aka regular wheel) event.
-	 */
-	multiplier = counter->resolution_multiplier;
-	low_res_value = remainder / multiplier;
-	remainder -= low_res_value * multiplier;
-	counter->remainder = remainder;
-
-	if (low_res_value)
-		input_report_rel(counter->dev, REL_WHEEL, low_res_value);
+	counter->remainder += hi_res_value;
+	if (abs(counter->remainder) >= threshold) {
+		/* Add (or subtract) 1 because we want to trigger when the wheel
+		 * is half-way to the next notch (i.e. scroll 1 notch after a
+		 * 1/2 notch movement, 2 notches after a 1 1/2 notch movement,
+		 * etc.).
+		 */
+		low_res_scroll_amount =
+			counter->remainder / counter->resolution_multiplier
+			+ (hi_res_value > 0 ? 1 : -1);
+		input_report_rel(counter->dev, REL_WHEEL,
+				 low_res_scroll_amount);
+		counter->remainder -=
+			low_res_scroll_amount * counter->resolution_multiplier;
+	}
 }
 EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
-- 
2.19.1
