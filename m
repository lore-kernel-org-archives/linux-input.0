From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH] HID: cp2112: fix to force single data-report reply
Date: Sun, 21 Jun 2015 14:20:25 +0800
Message-ID: <1434867625-3062-1-git-send-email-borneo.antonio@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35077 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbFUGUq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Jun 2015 02:20:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Antonio Borneo <borneo.antonio@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ellen Wang <ellen@cumulusnetworks.com>

Current implementation of cp2112_raw_event() only accepts one data
report at a time. If last received data report is not fully handled
yet, a new incoming data report will overwrite it. In such case we
don't guaranteed to propagate the correct incoming data.

The trivial fix implemented here forces a single report at a time
by requesting in cp2112_read() no more than 61 byte of data, which
is the payload size of a single data report.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---

Hi Jiri,

I think this should go through linux-stable.

Thanks,
Antonio

 drivers/hid/hid-cp2112.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3318de6..a2dbbbe 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -356,6 +356,8 @@ static int cp2112_read(struct cp2112_device *dev, u8 *data, size_t size)
 	struct cp2112_force_read_report report;
 	int ret;
 
+	if (size > sizeof(dev->read_data))
+		size = sizeof(dev->read_data);
 	report.report = CP2112_DATA_READ_FORCE_SEND;
 	report.length = cpu_to_be16(size);
 
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
