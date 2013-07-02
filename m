From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/3] Input: cyttsp4 - silence shift wrap warning
Date: Wed, 3 Jul 2013 00:40:19 +0300
Message-ID: <20130702214019.GA1598@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Ferruh Yigit <fery@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

"*max" is a size_t (long) type but "1" is an int so static checkers
complain that the shift could wrap.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 963da05..7aa4a34 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -153,7 +153,7 @@ static int cyttsp4_hw_reset(struct cyttsp4 *cd)
  */
 static int cyttsp4_bits_2_bytes(unsigned int nbits, size_t *max)
 {
-	*max = 1 << nbits;
+	*max = 1UL << nbits;
 	return (nbits + 7) / 8;
 }
 
