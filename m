From: Tolga Cakir <tolga@cevel.net>
Subject: [PATCH 4/4] HID: microsoft: undefining ms_map_key_clear after usage
Date: Fri,  4 Apr 2014 19:07:17 +0200
Message-ID: <1396631237-11813-1-git-send-email-tolga@cevel.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp04.udag.de ([62.146.106.30]:34911 "EHLO smtp04.udag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbaDDRNZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Apr 2014 13:13:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Derya <derya.kiran@yahoo.de>, Jiri Kosina <jkosina@suse.cz>, Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tolga Cakir <tolga@cevel.net>

This is inspired by various other hid drivers.

Signed-off-by: Tolga Cakir <tolga@cevel.net>
---
 drivers/hid/hid-microsoft.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 5674c0c..5281d2d 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -211,6 +211,8 @@ static int ms_sidewinder_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
 	return 1;
 }
 
+#undef ms_map_key_clear
+
 static int ms_sidewinder_control(struct hid_device *hdev, __u8 setup)
 {
 	struct ms_data *sc = hid_get_drvdata(hdev);
-- 
1.9.1

