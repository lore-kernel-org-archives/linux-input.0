From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/1] hid: i2c-hid: move header file out of I2C realm
Date: Sun, 21 May 2017 22:30:33 +0200
Message-ID: <20170521203033.6146-2-wsa@the-dreams.de>
References: <20170521203033.6146-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170521203033.6146-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/hid/i2c-hid/i2c-hid.c                  | 2 +-
 include/linux/{i2c => platform_data}/i2c-hid.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data}/i2c-hid.h (100%)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 8daa8ce64ebba5..841aa43526eba4 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -40,7 +40,7 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#include <linux/i2c/i2c-hid.h>
+#include <linux/platform_data/i2c-hid.h>
 
 #include "../hid-ids.h"
 
diff --git a/include/linux/i2c/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
similarity index 100%
rename from include/linux/i2c/i2c-hid.h
rename to include/linux/platform_data/i2c-hid.h
-- 
2.11.0
