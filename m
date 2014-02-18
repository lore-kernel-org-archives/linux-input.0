From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: cp2112: fix incorrect error propagation in
 cp2112_xfer()
Date: Tue, 18 Feb 2014 09:56:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402180955030.1192@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56303 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030AbaBRI4K (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 03:56:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Barksdale <dbarksdale@uplogix.com>
Cc: linux-input@vger.kernel.org, fengguang.wu@intel.com

Both cp2112_read_req() and cp2112_write_req() are returning negative
value in cases of error, but cp2112_xfer() is storing the return
value into unsigned size_t-typed 'count'.

Fix this by making 'count' signed type.

Reported-by: fengguang.wu@intel.com
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-cp2112.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 6d679f1..1025982 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -428,7 +428,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 	struct hid_device *hdev = dev->hdev;
 	u8 buf[64];
 	__be16 word;
-	size_t count;
+	ssize_t count;
 	size_t read_length = 0;
 	unsigned int retries;
 	int ret;
-- 
Jiri Kosina
SUSE Labs
