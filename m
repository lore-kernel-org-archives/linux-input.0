From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 09/11] HID: hid-multitouch: check if ContactCount is given for default quirk
Date: Fri, 23 Nov 2012 16:31:32 +0100
Message-ID: <1353684694-5723-10-git-send-email-benjamin.tissoires@gmail.com>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

By testing the new MT_CLS_DEFAULT against the collection of device
I have[1], I noticed that eGalax ones do not work because they don't
provide the field ContactCount in their report descriptor.

Removing this quirk for this kind of device allows them to work.

[1] https://github.com/bentiss/hid-devices -> all these devices can be
reinjected in the hid subsystem through uhid (kernel > 3.6) and
hid-replay here: https://github.com/bentiss/hid-replay

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 36cf346..5e0a4d7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -263,6 +263,9 @@ static ssize_t mt_set_quirks(struct device *dev,
 
 	td->mtclass.quirks = val;
 
+	if (!td->contactcount)
+		td->mtclass.quirks &= ~MT_QUIRK_CONTACT_COUNT_ACCURATE;
+
 	return count;
 }
 
@@ -856,6 +859,9 @@ static void mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
 
+	if (!td->contactcount)
+		cls->quirks &= ~MT_QUIRK_CONTACT_COUNT_ACCURATE;
+
 	td->mt_flags = 0;
 }
 
-- 
1.8.0
