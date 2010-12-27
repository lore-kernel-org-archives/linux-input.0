From: David Sterba <dsterba@suse.cz>
Subject: [PATCH] Input: bu21013_ts: fix misuse of logical operation in place of bitop
Date: Mon, 27 Dec 2010 16:36:50 +0100
Message-ID: <1293464210-21649-1-git-send-email-dsterba@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

CC: Linus Walleij <linus.walleij@stericsson.com>
CC: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
CC: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: David Sterba <dsterba@suse.cz>
---
 drivers/input/touchscreen/bu21013_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 2ca9e5d..f7fa9ef 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -365,7 +365,7 @@ static int bu21013_init_chip(struct bu21013_ts_data *data)
 	}
 
 	retval = i2c_smbus_write_byte_data(i2c, BU21013_TH_OFF_REG,
-				BU21013_TH_OFF_4 || BU21013_TH_OFF_3);
+				BU21013_TH_OFF_4 | BU21013_TH_OFF_3);
 	if (retval < 0) {
 		dev_err(&i2c->dev, "BU21013_TH_OFF reg write failed\n");
 		return retval;
-- 
1.7.3.4.578.g6068a
