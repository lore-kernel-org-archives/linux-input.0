From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] HID: multitouch: manually send sync event for pen input report
Date: Wed, 27 Feb 2013 17:55:25 +0100
Message-ID: <1361984127-912-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Since hid-multitouch sets the quirk HID_QUIRK_NO_INPUT_SYNC, we need
to manually send SYN events for pen report too.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 77ba751..d89f0eb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -393,6 +393,9 @@ static int mt_pen_event(struct hid_device *hid, struct hid_field *field,
 
 static void mt_pen_report(struct hid_device *hid, struct hid_report *report)
 {
+	struct hid_field *field = report->field[0];
+
+	input_sync(field->hidinput->input);
 }
 
 static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-- 
1.8.1.2
