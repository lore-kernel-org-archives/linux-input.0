From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 7/7] HID: multitouch: force BTN_STYLUS for pen devices
Date: Fri, 22 Mar 2013 18:38:34 +0100
Message-ID: <1363973914-5661-8-git-send-email-benjamin.tissoires@redhat.com>
References: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The "tablet" udev rule relies on BTN_STYLUS to be set.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5555174..aceaf6c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -418,6 +418,9 @@ static void mt_pen_input_configured(struct hid_device *hdev,
 		mt_free_input_name(hi);
 		hi->input->name = name;
 	}
+
+	/* force BTN_STYLUS to allow tablet matching in udev */
+	__set_bit(BTN_STYLUS, hi->input->keybit);
 }
 
 static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-- 
1.8.1.4
