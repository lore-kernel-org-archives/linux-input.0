From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [rft]suspend/resume support for yealink
Date: Mon, 30 Jun 2008 16:08:03 +0200
Message-ID: <200806301608.03788.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Alfred E. Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henk.Vergonet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

This implements basic suspend/resume support for yealink.
Could somebody test it?

	Regards
		Oliver

---

--- linux-2.6.26-sierra/drivers/input/misc/yealink.alt2.c	2008-06-30 14:13:58.000000000 +0200
+++ linux-2.6.26-sierra/drivers/input/misc/yealink.c	2008-06-30 16:02:30.000000000 +0200
@@ -120,6 +120,7 @@ struct yealink_dev {
 	u8 lcdMap[ARRAY_SIZE(lcdMap)];	/* state of LCD, LED ... */
 	int key_code;			/* last reported key	 */
 	int shutdown:1;
+	int open:1;
 
 	int	stat_ix;
 	union {
@@ -128,6 +129,7 @@ struct yealink_dev {
 	} master, copy;
 };
 
+static DECLARE_RWSEM(sysfs_rwsema);
 
 /*******************************************************************************
  * Yealink lcd interface
@@ -530,12 +532,16 @@ static int input_open(struct input_dev *
 	yld->ctl_data->cmd	= CMD_INIT;
 	yld->ctl_data->size	= 10;
 	yld->ctl_data->sum	= 0x100-CMD_INIT-10;
-	if ((ret = usb_submit_urb(yld->urb_ctl, GFP_KERNEL)) != 0) {
+	down_write(&sysfs_rwsema);
+	if ((ret = usb_submit_urb(yld->urb_ctl, GFP_KERNEL)) != 0)
 		dbg("%s - usb_submit_urb failed with result %d",
 		     __FUNCTION__, ret);
-		return ret;
-	}
-	return 0;
+	else
+		yld->open = 1;
+
+	up_write(&sysfs_rwsema);
+
+	return ret;
 }
 
 static void stop_traffic(struct yealink_dev *yld)
@@ -556,6 +562,9 @@ static void input_close(struct input_dev
 {
 	struct yealink_dev *yld = input_get_drvdata(dev);
 
+	down_write(&sysfs_rwsema);
+	yld->open = 0;
+	up_write(&sysfs_rwsema);
 	stop_traffic(yld);
 }
 
@@ -563,8 +572,6 @@ static void input_close(struct input_dev
  * sysfs interface
  ******************************************************************************/
 
-static DECLARE_RWSEM(sysfs_rwsema);
-
 /* Interface to the 7-segments translation table aka. char set.
  */
 static ssize_t show_map(struct device *dev, struct device_attribute *attr,
@@ -856,6 +863,25 @@ static int usb_cleanup(struct yealink_de
 	return err;
 }
 
+static int usb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct yealink_dev *yld = usb_get_intfdata(intf);
+
+	stop_traffic(yld);
+	return 0;
+}
+
+static int usb_resume(struct usb_interface *intf)
+{
+	struct yealink_dev *yld = usb_get_intfdata(intf);
+	int rv = 0;
+
+	down_read(&sysfs_rwsema);
+	if (yld->open)
+		rv = usb_submit_urb(yld->urb_ctl, GFP_NOIO);
+	up_read(&sysfs_rwsema);
+	return rv;
+}
 static void usb_disconnect(struct usb_interface *intf)
 {
 	struct yealink_dev *yld;
@@ -1002,6 +1028,8 @@ static struct usb_driver yealink_driver
 	.name		= "yealink",
 	.probe		= usb_probe,
 	.disconnect	= usb_disconnect,
+	.suspend	= usb_suspend,
+	.resume		= usb_resume,
 	.id_table	= usb_table,
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
