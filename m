From: George Pantalos <gpantalos@gmail.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Tue, 17 Apr 2012 03:52:34 +0300
Message-ID: <1708752.SgOWjWFNqk@vaio>
References: <1364401.K99JIOKFyb@vaio> <1492453.bjpWEAk9kj@vaio> <20120416212407.GE3959@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64043 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2DQAug (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Apr 2012 20:50:36 -0400
Received: by wibhq7 with SMTP id hq7so73789wib.1
        for <linux-input@vger.kernel.org>; Mon, 16 Apr 2012 17:50:35 -0700 (PDT)
In-Reply-To: <20120416212407.GE3959@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org

On Monday 16 of April 2012 16:24:07 Seth Forshee wrote:
> If the latency really is noticible when you stash the ST points, here's
> what I'd suggest trying instead. Stash away the last set of MT data you
> saw and repeat it with each of the next two ST coordinates. I suspect
> that will probably work well enough, and will allow every ST point to
> still be reported. And it should significantly simplify the code as
> well.

I tried your suggestion and I have to say that it works great. 
Thank you, Seth.
I hope my execution is ok. 

--- linux-3.3/drivers/input/mouse/alps.c.orig	2012-04-15 21:45:18.083826446 
+0300
+++ linux-3.3/drivers/input/mouse/alps.c	2012-04-17 03:18:51.806595048 
+0300
@@ -604,10 +604,56 @@
 
 static void alps_process_packet_v4(struct psmouse *psmouse)
 {
+	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
+	int offset;
 	int x, y, z;
 	int left, right;
+	int x1, y1, x2, y2;
+	int fingers = 0;
+	unsigned int x_bitmap, y_bitmap;
+
+	/*
+	 * v4 has a 6-byte encoding for bitmap data, but this data is
+	 * broken up between 3 normal packets. Use priv->multi_packet to
+	 * track our position in the bitmap packet.
+	 */
+	if (packet[6] & 0x40) {
+		/* sync, reset position */
+		priv->multi_packet = 0;
+	}
+
+	if (WARN_ON_ONCE(priv->multi_packet > 2))
+		return;
+
+	offset = 2 * priv->multi_packet;
+	priv->multi_data[offset] = packet[6];
+	priv->multi_data[offset + 1] = packet[7];
+
+	if (++priv->multi_packet > 2) {
+		priv->multi_packet = 0;
+
+		x_bitmap = ((priv->multi_data[2] & 0x1f) << 10) |
+			   ((priv->multi_data[3] & 0x60) << 3) |
+			   ((priv->multi_data[0] & 0x3f) << 2) |
+			   ((priv->multi_data[1] & 0x60) >> 5);
+		y_bitmap = ((priv->multi_data[5] & 0x01) << 10) |
+			   ((priv->multi_data[3] & 0x1f) << 5) |
+			   (priv->multi_data[1] & 0x1f);
+
+		fingers = alps_process_bitmap(x_bitmap, y_bitmap,
+					      &x1, &y1, &x2, &y2);
+
+		/*
+		 * Store MT data.
+		 */
+		priv->fingers = fingers;
+		priv->x1 = x1;
+		priv->x2 = x2;
+		priv->y1 = y1;
+		priv->y2 = y2;
+	}
 
 	left = packet[4] & 0x01;
 	right = packet[4] & 0x02;
@@ -617,21 +663,44 @@
 	y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
 	z = packet[5] & 0x7f;
 
+	/*
+	 * If there were no contacts in the bitmap, use ST
+	 * points in MT reports.
+	 * If there were two contacts or more, report MT data.
+	 */
+	if (priv->fingers < 2) {
+		x1 = x;
+		y1 = y;
+		fingers = z > 0 ? 1 : 0;
+	} else {
+		fingers = priv->fingers;
+		x1 = priv->x1;
+		x2 = priv->x2;
+		y1 = priv->y1;
+		y2 = priv->y2;
+	}
+
 	if (z >= 64)
 		input_report_key(dev, BTN_TOUCH, 1);
 	else
 		input_report_key(dev, BTN_TOUCH, 0);
 
+	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+
+	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
+	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
+	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
+	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
+
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
+
 	if (z > 0) {
 		input_report_abs(dev, ABS_X, x);
 		input_report_abs(dev, ABS_Y, y);
 	}
 	input_report_abs(dev, ABS_PRESSURE, z);
 
-	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-
 	input_sync(dev);
 }
 
@@ -1557,6 +1626,7 @@
 		input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
 		break;
 	case ALPS_PROTO_V3:
+	case ALPS_PROTO_V4:
 		set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
 		input_mt_init_slots(dev1, 2);
 		input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, 
ALPS_V3_X_MAX, 0, 0);
@@ -1565,8 +1635,7 @@
 		set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
 		set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
-		/* fall through */
-	case ALPS_PROTO_V4:
+
 		input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
 		input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
 		break;
--- linux-3.3/drivers/input/mouse/alps.h.orig	2012-04-16 
16:39:49.948823942 +0300
+++ linux-3.3/drivers/input/mouse/alps.h	2012-04-17 03:20:03.656594368 
+0300
@@ -39,6 +39,8 @@
 	int prev_fin;			/* Finger bit from previous packet */
 	int multi_packet;		/* Multi-packet data in progress */
 	unsigned char multi_data[6];	/* Saved multi-packet data */
+	int x1, x2, y1, y2;		/* Coordinates from last MT report */
+	int fingers;			/* Number of fingers from MT report */
 	u8 quirks;
 	struct timer_list timer;
 };

