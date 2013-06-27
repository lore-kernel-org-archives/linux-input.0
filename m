From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 22/51] Input: atmel_mxt_ts - Add shutdown function
Date: Thu, 27 Jun 2013 13:48:57 +0100
Message-ID: <1372337366-9286-23-git-send-email-nick.dyer@itdev.co.uk>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ee1e866..76f1c20 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1897,6 +1897,13 @@ static int mxt_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
 
+static void mxt_shutdown(struct i2c_client *client)
+{
+	struct mxt_data *data = i2c_get_clientdata(client);
+
+	disable_irq(data->irq);
+}
+
 static const struct i2c_device_id mxt_id[] = {
 	{ "qt602240_ts", 0 },
 	{ "atmel_mxt_ts", 0 },
@@ -1914,6 +1921,7 @@ static struct i2c_driver mxt_driver = {
 	},
 	.probe		= mxt_probe,
 	.remove		= mxt_remove,
+	.shutdown	= mxt_shutdown,
 	.id_table	= mxt_id,
 };
 
-- 
1.7.10.4
