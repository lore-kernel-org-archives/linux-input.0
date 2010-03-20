From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 07/24] input/touchscreen: fix dangling pointers
Date: Sat, 20 Mar 2010 15:12:48 +0100
Message-ID: <1269094385-16114-8-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/input/touchscreen/mcs5000_ts.c |    2 +-
 drivers/input/touchscreen/tsc2007.c    |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 4c28b89..98689a7 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -254,8 +254,8 @@ static int __devexit mcs5000_ts_remove(struct i2c_client *client)
 
 	free_irq(client->irq, data);
 	input_unregister_device(data->input_dev);
-	kfree(data);
 	i2c_set_clientdata(client, NULL);
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index be23780..4c63fda 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -353,6 +353,7 @@ static int __devexit tsc2007_remove(struct i2c_client *client)
 		pdata->exit_platform_hw();
 
 	input_unregister_device(ts->input);
+	i2c_set_clientdata(client, NULL);
 	kfree(ts);
 
 	return 0;
-- 
1.7.0
