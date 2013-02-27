From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/7] HID: multitouch: do not map usage from non used reports
Date: Wed, 27 Feb 2013 17:55:23 +0100
Message-ID: <1361984127-912-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hid-multitouch only handles touch events, so there is no point in
mapping other kind of events.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6314473..315500c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -726,7 +726,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	* such as Mouse that might have the same GenericDesktop usages. */
 	if (field->application != HID_DG_TOUCHSCREEN &&
 	    field->application != HID_DG_TOUCHPAD)
-		return 0;
+		return -1;
 
 	/* eGalax devices provide a Digitizer.Stylus input which overrides
 	 * the correct Digitizers.Finger X/Y ranges.
-- 
1.8.1.2
