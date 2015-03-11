From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: sx8654 - signedness bug in sx8654_irq()
Date: Wed, 11 Mar 2015 12:37:07 +0300
Message-ID: <20150311093707.GC3564@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

"irqsrc" needs to be signed for the error handling to work.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 8e531ac..aecb9ad 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -79,7 +79,7 @@ struct sx8654 {
 static irqreturn_t sx8654_irq(int irq, void *handle)
 {
 	struct sx8654 *sx8654 = handle;
-	u8 irqsrc;
+	int irqsrc;
 	u8 data[4];
 	unsigned int x, y;
 	int retval;
