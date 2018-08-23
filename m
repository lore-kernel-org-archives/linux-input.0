From: Harry Cutts <hcutts@chromium.org>
Subject: [PATCH 2/3] Create a utility class for counting scroll events
Date: Thu, 23 Aug 2018 11:30:56 -0700
Message-ID: <20180823183057.247630-3-hcutts@chromium.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823183057.247630-1-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jiri.kosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Harry Cutts <hcutts@chromium.org>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

To avoid code duplication, this class counts high-resolution scroll
movements and emits the legacy low-resolution events when appropriate.
Drivers should create one instance for each scroll wheel that they
need to handle.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

 drivers/hid/hid-input.c | 44 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h     | 28 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 4e94ea3e280a..4ee23b297472 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1826,3 +1826,47 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
+/**
+ * hid_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
+ *                                      events given a high-resolution wheel
+ *                                      movement.
+ * @counter: a hid_scroll_counter struct describing the wheel.
+ * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
+ *                units.
+ *
+ * Given a high-resolution movement, this function converts the movement into
+ * 256ths of a millimeter and emits high-resolution scroll events for the input
+ * device. It also uses the multiplier from &struct hid_scroll_counter to emit
+ * low-resolution scroll events when appropriate for backwards-compatibility
+ * with userspace input libraries.
+ */
+void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
+				      int hi_res_value)
+{
+	int low_res_scroll_amount;
+	/* Some wheels often rest 7/8ths of a notch from the previous notch
+	 * after slow movement, so we want the threshold for low-res events in
+	 * between the notches (e.g. after 4/8ths) as opposed to on the notches
+	 * themselves (8/8ths).
+	 */
+	int threshold = counter->resolution_multiplier / 2;
+
+	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
+			 hi_res_value * counter->mm256_per_hi_res_unit);
+
+	counter->remainder += hi_res_value;
+	if (abs(counter->remainder) >= threshold) {
+		/* Add (or subtract) 1 because we want to trigger when half-way
+		 * to the next notch (i.e. scroll 1 notch after a 1/2 notch
+		 * movement, 2 notches after a 1 1/2 notch movement, etc.).
+		 */
+		low_res_scroll_amount =
+			counter->remainder / counter->resolution_multiplier
+			+ (hi_res_value > 0 ? 1 : -1);
+		input_report_rel(counter->dev, REL_WHEEL,
+				 low_res_scroll_amount);
+		counter->remainder -=
+			low_res_scroll_amount * counter->resolution_multiplier;
+	}
+}
+EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 834e6461a690..b7bc0b2faf4f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1138,6 +1138,34 @@ static inline u32 hid_report_len(struct hid_report *report)
 int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
+
+/**
+ * struct hid_scroll_counter - Utility class for processing high-resolution
+ *                             scroll events.
+ * @dev: the input device for which events should be reported.
+ * @mm256_per_hi_res_unit: the amount moved by the user's finger for each
+ *                         high-resolution unit reported by the mouse, in 256ths
+ *                         of a millimetre.
+ * @resolution_multiplier: the wheel's resolution in high-resolution mode as a
+ *                         multiple of its lower resolution. For example, if
+ *                         moving the wheel by one "notch" would result in a
+ *                         value of 1 in low-resolution mode but 8 in
+ *                         high-resolution, the multiplier is 8.
+ * @remainder: counts the number of high-resolution units moved since the last
+ *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
+ *             only be used by class methods.
+ */
+struct hid_scroll_counter {
+	struct input_dev *dev;
+	int mm256_per_hi_res_unit;
+	int resolution_multiplier;
+
+	int remainder;
+};
+
+void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
+				      int hi_res_value);
+
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
 int hid_quirks_init(char **quirks_param, __u16 bus, int count);
-- 
2.18.0.1017.ga543ac7ca45-goog
