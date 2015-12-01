From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: lg: restrict filtering out of first interface to G29 only
Date: Tue,  1 Dec 2015 10:26:24 +0100
Message-ID: <1448961984-27413-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755834AbbLAJ03 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Dec 2015 04:26:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Looks like 29fae1c85 ("HID: logitech: Add support for G29") was a little
bit aggressive and broke other devices.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=108121

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Jiri,

as reported in #108121, this is 4.4-rc material. At least 2 people already
started complaining about it on the mailing list, so it should definitively
be fixed before 4.4 is out.

Cheers,
Benjamin

 drivers/hid/hid-lg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c20ac76..c690fae 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -665,8 +665,9 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct lg_drv_data *drv_data;
 	int ret;
 
-	/* Only work with the 1st interface (G29 presents multiple) */
-	if (iface_num != 0) {
+	/* G29 only work with the 1st interface */
+	if ((hdev->product == USB_DEVICE_ID_LOGITECH_G29_WHEEL) &&
+	    (iface_num != 0)) {
 		dbg_hid("%s: ignoring ifnum %d\n", __func__, iface_num);
 		return -ENODEV;
 	}
-- 
2.5.0

