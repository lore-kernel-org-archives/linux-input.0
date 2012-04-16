From: George Pantalos <gpantalos@gmail.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Mon, 16 Apr 2012 17:24:55 +0300
Message-ID: <1492453.bjpWEAk9kj@vaio>
References: <1364401.K99JIOKFyb@vaio> <20120410152113.GC21994@thinkpad-t410> <20120410215939.GE21994@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48113 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab2DPOXK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Apr 2012 10:23:10 -0400
Received: by bkcik5 with SMTP id ik5so3690886bkc.19
        for <linux-input@vger.kernel.org>; Mon, 16 Apr 2012 07:23:08 -0700 (PDT)
In-Reply-To: <20120410215939.GE21994@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org

> On Tue, Apr 10, 2012 at 10:21:13AM -0500, Seth Forshee wrote:
> > I definitely think your state processing could be improved. My
> > suggestion would be to treat multi_packet as a counter. Reset it to 0
> > when you see the sync bit is set, and increment it for each packet until
> > you have a full set of MT data. That way you know for sure which section
> > of the MT data you're working with for any given packet. But be prepared
> > to handle an incomplete packet sequence as well (I'm pretty sure I saw
> > some of these when I was working with a v4 touchpad).
> 
> I found an old patch I had from working on the semi-MT support
> previously that demonstrates the multi_packet-as-counter approach. I
> ported the relevant code on top of 3.4-rc2, cleaned it up, compile
> tested it, and pasted the resulting patch below.
> 
> Note that this is ignoring the ST coordinates except from the final
> packet of the MT sequence, which isn't ideal. A better approach might be
> to stash the ST data from each packet in alps_data, then when you have
> all three packets process the bitmaps and report all three ST points
> with the same set of MT data.

Hello Seth,

First of all, sorry for answering so late, I had no internet access for the 
past week.

Thank you for your comments and for posting your patch. You are of course 
correct in your remarks.

 I decided to try and improve upon your patch which has superior state 
processing. I followed your proposal initially and stashed the first and 
second packet ST data in alps_data and if bitmap fingers < 2 report all the ST 
data.
The problem with this approach is that it introduces a noticeable delay/lag in 
mouse pointer movement.

I then tried using the last_fingers approach.  This way we report ST data as 
they come but only if the last MT report had 1 finger present and we always 
(as far as I can tell) must have calculated bitmap finger count before 
reporting ST events. I have posted this patch below. I also observed jumpy 
behavior with the xf86-input-multitouch driver when the MT report had 1 
finger, so if bitmap fingers are 1 , it uses x,y instead of x1,y1.
This approach has the benefit of producing smooth pointer movement and 
accurately reporting MT events like the other approach.

To handle inconsistent data I used your patch to dump raw packets.  I noticed 
,as your documentation also states, that the condition (packet[6] & 0x40) 
could also be triggered by the second MT packet and then reset 
multi_packet to 0.
So I used the fact that byte 5 of the MT data, priv->multi_data [4] must 
always be 0x00. A kind of second sync byte to ensure we have correct MT 
reports. Unless the MT data is consistent we report nothing.

Thanks for your help and guidance.

--- linux-3.3/drivers/input/mouse/alps.c.orig	2012-04-15 21:45:18.083826446 
+0300
+++ linux-3.3/drivers/input/mouse/alps.c	2012-04-16 16:33:11.412181964 
+0300
@@ -604,10 +604,39 @@
 
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
+	if ((packet[6] & 0x40) && (priv->multi_data[4] == 0x00)) {
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
+	/*
+	 * The 5th byte of the MT data must always be 0x00.
+	 * Try to re-sync our position if MT data is inconsistent.
+	 */
+	if (priv->multi_data[4] != 0x00)
+		return;
 
 	left = packet[4] & 0x01;
 	right = packet[4] & 0x02;
@@ -617,22 +646,78 @@
 	y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
 	z = packet[5] & 0x7f;
 
-	if (z >= 64)
-		input_report_key(dev, BTN_TOUCH, 1);
-	else
-		input_report_key(dev, BTN_TOUCH, 0);
 
-	if (z > 0) {
-		input_report_abs(dev, ABS_X, x);
-		input_report_abs(dev, ABS_Y, y);
-	}
-	input_report_abs(dev, ABS_PRESSURE, z);
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
 
-	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
+		/*
+		 * If there were no contacts in the bitmap, use ST
+		 * points in MT reports.
+		 */
+		if (fingers < 2) {
+			x1 = x;
+			y1 = y;
+			fingers = z > 0 ? 1 : 0;
+		}
+
+		priv->last_fingers = fingers;
+
+		if (z >= 64)
+			input_report_key(dev, BTN_TOUCH, 1);
+		else
+			input_report_key(dev, BTN_TOUCH, 0);
+
+		alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+
+		input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
+		input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
+		input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
+		input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
+
+		input_report_key(dev, BTN_LEFT, left);
+		input_report_key(dev, BTN_RIGHT, right);
+
+		if (z > 0) {
+			input_report_abs(dev, ABS_X, x);
+			input_report_abs(dev, ABS_Y, y);
+		}
+		input_report_abs(dev, ABS_PRESSURE, z);
+
+		input_sync(dev);
+	} else {
+		if (priv->last_fingers == 1) {
+			if (z >= 64)
+				input_report_key(dev, BTN_TOUCH, 1);
+			else
+				input_report_key(dev, BTN_TOUCH, 0);
+
+			alps_report_semi_mt_data(dev, 1, x, y, 0, 0);
+
+			input_report_key(dev, BTN_TOOL_FINGER, z > 0);
+
+			input_report_key(dev, BTN_LEFT, left);
+			input_report_key(dev, BTN_RIGHT, right);
+
+			if (z > 0) {
+				input_report_abs(dev, ABS_X, x);
+				input_report_abs(dev, ABS_Y, y);
+			}
+			input_report_abs(dev, ABS_PRESSURE, z);
 
-	input_sync(dev);
+			input_sync(dev);
+		}
+	}
 }
 
 static void alps_process_packet(struct psmouse *psmouse)
@@ -1557,6 +1642,7 @@
 		input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
 		break;
 	case ALPS_PROTO_V3:
+	case ALPS_PROTO_V4:
 		set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
 		input_mt_init_slots(dev1, 2);
 		input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, 
ALPS_V3_X_MAX, 0, 0);
@@ -1565,8 +1651,7 @@
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
+++ linux-3.3/drivers/input/mouse/alps.h	2012-04-16 16:41:28.228817760 
+0300
@@ -39,6 +39,7 @@
 	int prev_fin;			/* Finger bit from previous packet */
 	int multi_packet;		/* Multi-packet data in progress */
 	unsigned char multi_data[6];	/* Saved multi-packet data */
+	int last_fingers;		/* Number of fingers from MT report*/
 	u8 quirks;
 	struct timer_list timer;
 };


