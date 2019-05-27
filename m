From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: qt1050 - remove unnecessary comparison of unsigned
 integer with < 0
Date: Mon, 27 May 2019 09:10:33 -0500
Message-ID: <20190527141033.GA19251@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

There is no need to compare button.num with < 0 because such comparison
of an unsigned value is always false.

Fix this by removing such comparison.

Addresses-Coverity-ID: 1445492 ("Unsigned compared against 0")
Fixes: cbebf5addec1 ("Input: qt1050 - add Microchip AT42QT1050 support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/keyboard/qt1050.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index 403060d05c3b..a9ac99f62e39 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -368,7 +368,7 @@ static int qt1050_parse_fw(struct qt1050_priv *ts)
 			dev_err(dev, "Button without pad number\n");
 			goto err;
 		}
-		if (button.num < 0 || button.num > QT1050_MAX_KEYS - 1)
+		if (button.num > QT1050_MAX_KEYS - 1)
 			goto err;
 
 		ts->reg_keys |= BIT(button.num);
-- 
2.21.0
