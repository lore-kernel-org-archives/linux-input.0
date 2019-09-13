From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH 2/3] HID: google: whiskers: signal tablet mode switch on disconnect
Date: Fri, 13 Sep 2019 15:03:16 -0700
Message-ID: <20190913220317.58289-2-dtor@chromium.org>
References: <20190913220317.58289-1-dtor@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913220317.58289-1-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Currently, the tablet mode switch that takes two signals as its input:
base attached switch from the EC and some GMR signal from whiskers when
it's folded over. This tablet mode switch is then sent to Chrome, which
changes the UI.

However, there are some units which have a lot of leakage on the ADC
pins that the EC uses to determine whether or not a base is attached.
This can result in the base being physically detached, but the EC
thinking that it's still attached. The user would then be stuck in
laptop mode and wouldn't be able to rotate their display.

To work around this let's send "tablet mode" signal when we remove HID
interface, which normally happens when we physically disconnect
whiskers.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 4f64f93ddfcb..3dc6116c8f76 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -498,11 +498,33 @@ static int hammer_probe(struct hid_device *hdev,
 
 static void hammer_remove(struct hid_device *hdev)
 {
+	unsigned long flags;
+
 	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
-			hammer_is_keyboard_interface(hdev))
+			hammer_is_keyboard_interface(hdev)) {
 		hid_hw_close(hdev);
 
+		/*
+		 * If we are disconnecting then most likely Whiskers is
+		 * being removed. Even if it is not removed, without proper
+		 * keyboard we should not stay in clamshell mode.
+		 *
+		 * The reason for doing it here and not waiting for signal
+		 * from EC, is that on some devices there are high leakage
+		 * on Whiskers pins and we do not detect disconnect reliably,
+		 * resulting in devices being stuck in clamshell mode.
+		 */
+		spin_lock_irqsave(&cbas_ec_lock, flags);
+		if (cbas_ec.input && cbas_ec.base_present) {
+			input_report_switch(cbas_ec.input, SW_TABLET_MODE, 1);
+			input_sync(cbas_ec.input);
+		}
+		cbas_ec.base_present = false;
+		spin_unlock_irqrestore(&cbas_ec_lock, flags);
+	}
+
 	hammer_unregister_leds(hdev);
+
 	hid_hw_stop(hdev);
 }
 
-- 
2.23.0.237.gc6a4ce50a0-goog
