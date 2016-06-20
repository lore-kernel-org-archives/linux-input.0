From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: alps: pass correct sizes to hid_hw_raw_request()
Date: Mon, 20 Jun 2016 11:24:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606201122090.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49414 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbcFTJYU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 05:24:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>

From: Jiri Kosina <jkosina@suse.cz>

Calculating size of the report as sizeof(pointer) always passess the 
length corresponding to the pointer type, not the underlying data report.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-alps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 098bce6..ff64c929 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -136,7 +136,8 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 
 	input[7] = check_sum;
 	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
-			sizeof(input), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+			sizeof(u8)*U1_FEATURE_REPORT_LEN, HID_FEATURE_REPORT,
+			HID_REQ_SET_REPORT);
 
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed to read command (%d)\n", ret);
@@ -145,8 +146,8 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 
 	if (read_flag) {
 		ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, readbuf,
-				sizeof(readbuf), HID_FEATURE_REPORT,
-				HID_REQ_GET_REPORT);
+				sizeof(u8)*U1_FEATURE_REPORT_LEN,
+				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 		if (ret < 0) {
 			dev_err(&hdev->dev, "failed read register (%d)\n", ret);
-- 
Jiri Kosina
SUSE Labs

