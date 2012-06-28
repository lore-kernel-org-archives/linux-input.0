From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 02/23 v6] Input: atmel_mxt_ts - use client name for irq
Date: Thu, 28 Jun 2012 21:08:03 +0800
Message-ID: <1340888904-15620-3-git-send-email-djkurtz@chromium.org>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

The atmel_mxt_ts driver can support multiple devices simultaneously.
Use the i2c_client name instead of the driver name when requesting an
interrupt to make the different interrupts distinguishable in
/proc/interrupts and top.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b1108ca..8b33f3a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1154,7 +1154,7 @@ static int __devinit mxt_probe(struct i2c_client *client,
 		goto err_free_object;
 
 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
-			pdata->irqflags, client->dev.driver->name, data);
+			pdata->irqflags, client->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_object;
-- 
1.7.7.3
