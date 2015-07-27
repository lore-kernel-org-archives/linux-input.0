From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: zforce_ts - fix playload length check
Date: Mon, 27 Jul 2015 14:06:19 -0700
Message-ID: <20150727210619.GA2825@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34253 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbbG0VGY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 17:06:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Heiko Stuebner <heiko.stuebner@bq.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, linux-kernel@vger.kernel.org

Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce - don't
overwrite the stack") attempted to add a check for payload size being too
large for the supplied buffer. Unfortunately with the currently selected
buffer size the comparison is always false as buffer size is larger than
the value a single byte can hold, and that results in compiler warnings.
Additionally the check was incorrect as it was not accounting for the
already read 2 bytes of data stored in the buffer.

Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This seems to shut up my GCC, I wonder if it is going to work gfor
everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
comment and remove check.

 drivers/input/touchscreen/zforce_ts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 2554efd..542ff02 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -441,7 +441,9 @@ static int zforce_read_packet(struct zforce_ts *ts, u8 *buf)
 		goto unlock;
 	}
 
-	if (buf[PAYLOAD_LENGTH] == 0 || buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE) {
+	if (buf[PAYLOAD_LENGTH] == 0 ||
+	    (FRAME_MAXSIZE - 2 < 255 &&
+	     buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE - 2)) {
 		dev_err(&client->dev, "invalid payload length: %d\n",
 			buf[PAYLOAD_LENGTH]);
 		ret = -EIO;
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
