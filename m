From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [PATCH] Input: atmel_mxt_ts: Fix random configuration load failure
Date: Mon, 09 Feb 2015 19:31:47 +0100
Message-ID: <20150209183147.26132.22331.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ip83.parkeon.com ([213.152.31.83]:47861 "EHLO mta2.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760210AbbBITML (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Feb 2015 14:12:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Sometimes configuration fails to load with:

	Bad format: failed to parse object

This can occur because the firmware loader does not ensure that
the configuration data is null terminated.

The scanf() therefore reads arbitrary garbage at the end of file.
If one item of garbage happens to be parsable the error occurs.

By skipping control characters (line endings) before scanning
each line rather than relying on the white space skipping of sscanf
we correctly detect end of file.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0666759..29f9b9d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1086,6 +1086,13 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 	u8 val;
 
 	while (data_pos < cfg->size) {
+		if (cfg->data[data_pos] < 0x20) {
+			/* firmware loading does not ensure null termination
+			 * which is required by scanf */
+			 data_pos++;
+			 continue;
+		}
+
 		/* Read type, instance, length */
 		ret = sscanf(cfg->data + data_pos, "%x %x %x%n",
 			     &type, &instance, &size, &offset);

