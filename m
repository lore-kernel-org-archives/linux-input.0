From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] usbhid: replace inappropriate ENOSYS with ENODEV
Date: Wed, 20 Jan 2016 22:56:28 +0100
Message-ID: <56A0028C.9080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33342 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbcATV4l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2016 16:56:41 -0500
Received: by mail-wm0-f44.google.com with SMTP id 123so150677452wmz.0
        for <linux-input@vger.kernel.org>; Wed, 20 Jan 2016 13:56:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org

Primary meaning of ENOSYS is "system call not available" but it's also used
with meaning "function not implemented". Both are not applicable here.

Typically this error occurs when the device was unplugged.
usbhid_raw_request returns -ENODEV in such a case what seems to be more
reasonable. Therefore use -ENODEV also here.

Primary motivation for this change is a change in the LED subsystem to
ignore -ENODEV if the device was most likely unplugged.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ad71160..64a8d9c 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -928,7 +928,7 @@ static int usbhid_output_report(struct hid_device *hid, __u8 *buf, size_t count)
 	int actual_length, skipped_report_id = 0, ret;
 
 	if (!usbhid->urbout)
-		return -ENOSYS;
+		return -ENODEV;
 
 	if (buf[0] == 0x0) {
 		/* Don't send the Report ID */
-- 
2.7.0

