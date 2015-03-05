From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: wacom: check for wacom->shared before following the pointer
Date: Thu,  5 Mar 2015 17:36:35 -0500
Message-ID: <1425594995-22958-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbbCEWgm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Mar 2015 17:36:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

486b908 (HID: wacom: do not send pen events before touch is up/forced out)
introduces a kernel oops when plugging a tablet without touch.

wacom->shared is null for these devices so this leads to a null pointer
exception.

Change the condition to make it clear that what we need is wacom->shared
not NULL.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Jiri,

this one should be pulled in 4.0. Or we will have surprised users :)

Cheers,
Benjamin

 drivers/hid/wacom_wac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ff9a7ab..9739a4c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -564,11 +564,12 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	   (features->type == CINTIQ && !(data[1] & 0x40)))
 		return 1;
 
-	if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
+	if (wacom->shared) {
 		wacom->shared->stylus_in_proximity = true;
 
-	if (wacom->shared->touch_down)
-		return 1;
+		if (wacom->shared->touch_down)
+			return 1;
+	}
 
 	/* in Range while exiting */
 	if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
-- 
2.1.0

