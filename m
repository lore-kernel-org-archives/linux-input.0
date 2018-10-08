From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: atmel_mxt_ts - mark expected switch fall-through
Date: Mon, 8 Oct 2018 19:03:55 +0200
Message-ID: <20181008170355.GA18107@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index bbc122f..d3aacd5 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -488,7 +488,7 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data, bool retry)
 			bootloader = appmode - 0x24;
 			break;
 		}
-		/* Fall through for normal case */
+		/* Fall through - for normal case */
 	case 0x4c:
 	case 0x4d:
 	case 0x5a:
-- 
2.7.4
