From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] Input: sidewinder - mark expected switch fall-throughs
Date: Wed, 8 Nov 2017 21:02:50 -0600
Message-ID: <20171109030250.GA13692@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114763
Addresses-Coverity-ID: 114764
Addresses-Coverity-ID: 114765
Addresses-Coverity-ID: 114766
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/input/joystick/sidewinder.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 4a95b22..5e602a6 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -672,16 +672,16 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 
 			switch (i * m) {
 				case 60:
-					sw->number++;
+					sw->number++;			/* fall through */
 				case 45:				/* Ambiguous packet length */
 					if (j <= 40) {			/* ID length less or eq 40 -> FSP */
 				case 43:
 						sw->type = SW_ID_FSP;
 						break;
 					}
-					sw->number++;
+					sw->number++;			/* fall through */
 				case 30:
-					sw->number++;
+					sw->number++;			/* fall through */
 				case 15:
 					sw->type = SW_ID_GP;
 					break;
@@ -697,9 +697,9 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
 						sw->type = SW_ID_PP;
 					break;
 				case 66:
-					sw->bits = 3;
+					sw->bits = 3;			/* fall through */
 				case 198:
-					sw->length = 22;
+					sw->length = 22;		/* fall through */
 				case 64:
 					sw->type = SW_ID_3DP;
 					if (j == 160)
-- 
2.7.4
