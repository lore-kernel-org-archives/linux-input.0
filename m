From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH] HID: i2c-hid: Limit reads to wMaxInputLength bytes for input events
Date: Fri, 20 Feb 2015 11:45:11 -0600
Message-ID: <1424454311-70750-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:47889 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbbBTRpd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 12:45:33 -0500
Received: by mail-oi0-f52.google.com with SMTP id u20so3802436oif.11
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2015 09:45:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

d1c7e29e8d27 (HID: i2c-hid: prevent buffer overflow in early IRQ)
changed hid_get_input() to read ihid->bufsize bytes, which can be
more than wMaxInputLength. This is the case with the Dell XPS 13
9343, and it is causing events to be missed. In some cases the
missed events are releases, which can cause the cursor to jump or
freeze, among other problems. Limit the number of bytes read to
min(wMaxInputLength, ihid->bufsize) to prevent such problems.

Fixes: d1c7e29e8d27 "HID: i2c-hid: prevent buffer overflow in early IRQ"
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index d43e967..5e72fc2 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -370,7 +370,10 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
 	int ret, ret_size;
-	int size = ihid->bufsize;
+	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
+
+	if (size > ihid->bufsize)
+		size = ihid->bufsize;
 
 	ret = i2c_master_recv(ihid->client, ihid->inbuf, size);
 	if (ret != size) {
-- 
1.9.1

