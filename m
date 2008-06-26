From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]reliably killing urbs in yealink driver
Date: Thu, 26 Jun 2008 13:44:30 +0200
Message-ID: <200806261344.32326.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Alfred E. Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henk.Vergonet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

yealink uses two URBs that submit each other. This arrangement cannot
be reliably killed with usb_kill_urb() alone, as there's a window during which
the wrong URB may be killed. The fix is to introduce a flag.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

---

--- linux-2.6.26-sierra/drivers/input/misc/yealink.alt.c	2008-06-24 10:17:14.000000000 +0200
+++ linux-2.6.26-sierra/drivers/input/misc/yealink.c	2008-06-26 13:34:35.000000000 +0200
@@ -424,10 +424,10 @@ send_update:
 static void urb_irq_callback(struct urb *urb)
 {
 	struct yealink_dev *yld = urb->context;
-	int ret;
+	int ret, status = urb->status;
 
-	if (urb->status)
-		err("%s - urb status %d", __FUNCTION__, urb->status);
+	if (status)
+		err("%s - urb status %d", __func__, status);
 
 	switch (yld->irq_data->cmd) {
 	case CMD_KEYPRESS:
@@ -446,34 +446,43 @@ static void urb_irq_callback(struct urb
 	}
 
 	yealink_do_idle_tasks(yld);
-
-	ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
-	if (ret)
-		err("%s - usb_submit_urb failed %d", __FUNCTION__, ret);
+	spin_lock(&yld->spin);
+	if (!yld->shutdown) {
+		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
+		if (ret && ret != -EPERM)
+			err("%s - usb_submit_urb failed %d", __func__, ret);
+	}
+	spin_unlock(&yld->spin);
 }
 
 static void urb_ctl_callback(struct urb *urb)
 {
 	struct yealink_dev *yld = urb->context;
-	int ret;
+	int ret = 0, status = urb->status;
 
-	if (urb->status)
-		err("%s - urb status %d", __FUNCTION__, urb->status);
+	if (status)
+		err("%s - urb status %d", __func__, status);
 
 	switch (yld->ctl_data->cmd) {
 	case CMD_KEYPRESS:
 	case CMD_SCANCODE:
 		/* ask for a response */
-		ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
+		spin_lock(&yld->spin);
+		if (!yld->shutdown)
+			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
+		spin_unlock(&yld->spin);
 		break;
 	default:
 		/* send new command */
 		yealink_do_idle_tasks(yld);
-		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
+		spin_lock(&yld->spin);
+		if (!yld->shutdown)
+			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
+		spin_unlock(&yld->spin);
 	}
 
-	if (ret)
-		err("%s - usb_submit_urb failed %d", __FUNCTION__, ret);
+	if (ret && ret != -EPERM)
+		err("%s - usb_submit_urb failed %d", __func__, ret);
 }
 
 /*******************************************************************************
@@ -527,12 +536,25 @@ static int input_open(struct input_dev *
 	return 0;
 }
 
-static void input_close(struct input_dev *dev)
+static void stop_traffic(struct yealink_dev *yld)
 {
-	struct yealink_dev *yld = input_get_drvdata(dev);
+	spin_lock_irq(&yld->spin);
+	yld->shutdown = 1;
+	spin_unlock_irq(&yld->spin);
 
 	usb_kill_urb(yld->urb_ctl);
 	usb_kill_urb(yld->urb_irq);
+
+	spin_lock_irq(&yld->spin);
+	yld->shutdown = 0;
+	spin_unlock_irq(&yld->spin);
+}
+
+static void input_close(struct input_dev *dev)
+{
+	struct yealink_dev *yld = input_get_drvdata(dev);
+
+	stop_traffic(yld);
 }
 
 /*******************************************************************************
@@ -809,8 +831,7 @@ static int usb_cleanup(struct yealink_de
 	if (yld == NULL)
 		return err;
 
-	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
-	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
+	stop_traffic(yld);
 
         if (yld->idev) {
 		if (err)
@@ -866,6 +887,7 @@ static int usb_probe(struct usb_interfac
 		return -ENOMEM;
 
 	yld->udev = udev;
+	spin_lock_init(&yld->spin);
 
 	yld->idev = input_dev = input_allocate_device();
 	if (!input_dev)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
