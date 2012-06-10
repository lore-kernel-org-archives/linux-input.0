From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 08/16] HID: uhid: forward hid report-descriptor to hid core
Date: Sun, 10 Jun 2012 15:16:20 +0200
Message-ID: <1339334188-21766-9-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33409 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2FJNQr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:47 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1506960wey.19
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:46 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

When the uhid_hid_parse callback is called we simply forward it to
hid_parse_report() with the data that we got in the UHID_CREATE event.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3d1ebda..0d011db 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -106,7 +106,9 @@ static int uhid_hid_input(struct input_dev *input, unsigned int type,
 
 static int uhid_hid_parse(struct hid_device *hid)
 {
-	return 0;
+	struct uhid_device *uhid = hid->driver_data;
+
+	return hid_parse_report(hid, uhid->rd_data, uhid->rd_size);
 }
 
 static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
-- 
1.7.10.4

