From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/14] HID: i2c-hid: remove extra .irq field in struct i2c_hid
Date: Tue,  4 Dec 2012 16:27:53 +0100
Message-ID: <1354634875-5182-13-git-send-email-benjamin.tissoires@gmail.com>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354634875-5182-1-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

There is no point in keeping the irq in i2c_hid as it's already
there in client.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 2b49929..bea4b13 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -136,8 +136,6 @@ struct i2c_hid {
 
 	unsigned long		flags;		/* device flags */
 
-	int			irq;		/* the interrupt line irq */
-
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
 };
 
@@ -737,8 +735,6 @@ static int __devinit i2c_hid_init_irq(struct i2c_client *client)
 		return ret;
 	}
 
-	ihid->irq = client->irq;
-
 	return 0;
 }
 
@@ -841,12 +837,12 @@ static int __devinit i2c_hid_probe(struct i2c_client *client,
 
 	ret = i2c_hid_init_irq(client);
 	if (ret < 0)
-		goto err;
+		goto err_irq;
 
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-		goto err;
+		goto err_irq;
 	}
 
 	ihid->hid = hid;
@@ -876,10 +872,10 @@ static int __devinit i2c_hid_probe(struct i2c_client *client,
 err_mem_free:
 	hid_destroy_device(hid);
 
-err:
-	if (ihid->irq)
-		free_irq(ihid->irq, ihid);
+err_irq:
+	free_irq(client->irq, ihid);
 
+err:
 	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
 	return ret;
@@ -904,10 +900,9 @@ static int __devexit i2c_hid_remove(struct i2c_client *client)
 static int i2c_hid_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(ihid->irq);
+		enable_irq_wake(client->irq);
 
 	/* Save some power */
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
-- 
1.8.0.1
