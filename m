From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 4/7] HID: multitouch: change touch sensor detection in mt_input_configured()
Date: Fri, 22 Mar 2013 18:38:31 +0100
Message-ID: <1363973914-5661-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

To implement different methods for pen and touch, the previous
implementation has to be reworked.

This detection of the input attached to the touch sensor is the same
than the one used in mt_report().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 611c88cb..6a934de 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -857,13 +857,10 @@ static void mt_post_parse(struct mt_device *td)
 
 static void mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
-	struct input_dev *input = hi->input;
-
-	/* Only initialize slots for MT input devices */
-	if (!test_bit(ABS_MT_POSITION_X, input->absbit))
-		return;
+	struct mt_device *td = hid_get_drvdata(hdev);
 
-	mt_touch_input_configured(hdev, hi);
+	if (hi->report->id == td->mt_report_id)
+		mt_touch_input_configured(hdev, hi);
 }
 
 static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
-- 
1.8.1.4
