From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 2/2] HID: cp2112: use proper specifier for size_t
Date: Mon, 17 Feb 2014 23:48:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402172347410.1192@pobox.suse.cz>
References: <alpine.LNX.2.00.1402172346500.1192@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51609 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbaBQWsO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 17:48:14 -0500
In-Reply-To: <alpine.LNX.2.00.1402172346500.1192@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Barksdale <dbarksdale@uplogix.com>
Cc: linux-input@vger.kernel.org

%zd is a proper format string specifier for size_t

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-cp2112.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 57cf045..f326726 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -361,7 +361,7 @@ static int cp2112_read(struct cp2112_device *dev, u8 *data, size_t size)
 	if (ret)
 		return ret;
 
-	hid_dbg(hdev, "read %d of %d bytes requested\n",
+	hid_dbg(hdev, "read %d of %zd bytes requested\n",
 		dev->read_length, size);
 
 	if (size > dev->read_length)
@@ -552,7 +552,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 	if (ret < 0)
 		goto power_normal;
 	if (ret != read_length) {
-		hid_warn(hdev, "short read: %d < %d\n", ret, read_length);
+		hid_warn(hdev, "short read: %d < %zd\n", ret, read_length);
 		ret = -EIO;
 		goto power_normal;
 	}
-- 
Jiri Kosina
SUSE Labs
