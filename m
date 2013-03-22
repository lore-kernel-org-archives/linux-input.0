From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/7] HID: multitouch: do not map usage from non used reports
Date: Fri, 22 Mar 2013 18:38:30 +0100
Message-ID: <1363973914-5661-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hid-multitouch only handles touch events, so there is no point in
mapping other kind of events.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 35b6025..611c88cb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -741,7 +741,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	* such as Mouse that might have the same GenericDesktop usages. */
 	if (field->application != HID_DG_TOUCHSCREEN &&
 	    field->application != HID_DG_TOUCHPAD)
-		return 0;
+		return -1;
 
 	/* eGalax devices provide a Digitizer.Stylus input which overrides
 	 * the correct Digitizers.Finger X/Y ranges.
-- 
1.8.1.4
