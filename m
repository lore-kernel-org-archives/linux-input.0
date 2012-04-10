From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Tue, 10 Apr 2012 16:59:39 -0500
Message-ID: <20120410215939.GE21994@thinkpad-t410>
References: <1364401.K99JIOKFyb@vaio>
 <20120410152113.GC21994@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45761 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab2DJV7n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Apr 2012 17:59:43 -0400
Content-Disposition: inline
In-Reply-To: <20120410152113.GC21994@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Pantalos <gpantalos@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 10, 2012 at 10:21:13AM -0500, Seth Forshee wrote:
> I definitely think your state processing could be improved. My
> suggestion would be to treat multi_packet as a counter. Reset it to 0
> when you see the sync bit is set, and increment it for each packet until
> you have a full set of MT data. That way you know for sure which section
> of the MT data you're working with for any given packet. But be prepared
> to handle an incomplete packet sequence as well (I'm pretty sure I saw
> some of these when I was working with a v4 touchpad).

I found an old patch I had from working on the semi-MT support
previously that demonstrates the multi_packet-as-counter approach. I
ported the relevant code on top of 3.4-rc2, cleaned it up, compile
tested it, and pasted the resulting patch below.

Note that this is ignoring the ST coordinates except from the final
packet of the MT sequence, which isn't ideal. A better approach might be
to stash the ST data from each packet in alps_data, then when you have
all three packets process the bitmaps and report all three ST points
with the same set of MT data.

Cheers,
Seth


diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4c6a72d..8cc0dbf 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -604,35 +604,88 @@ static void alps_process_packet_v3(struct psmouse *psmouse)
 
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
 
-	left = packet[4] & 0x01;
-	right = packet[4] & 0x02;
+	/*
+	 * v4 has a 6-byte encoding for bitmap data, but this data is
+	 * broken up between 3 normal packets. Use priv->multi_packet to
+	 * track our position in the bitmap packet.
+	 */
+	if (packet[6] & 0x40) {
+		/* sync, reset position */
+		priv->multi_packet = 0;
+	}
 
-	x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
-	    ((packet[0] & 0x30) >> 4);
-	y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
-	z = packet[5] & 0x7f;
+	if (WARN_ON_ONCE(priv->multi_packet > 2))
+		return;
 
-	if (z >= 64)
-		input_report_key(dev, BTN_TOUCH, 1);
-	else
-		input_report_key(dev, BTN_TOUCH, 0);
+	offset = 2 * priv->multi_packet;
+	priv->multi_data[offset] = packet[6];
+	priv->multi_data[offset + 1] = packet[7];
 
-	if (z > 0) {
-		input_report_abs(dev, ABS_X, x);
-		input_report_abs(dev, ABS_Y, y);
-	}
-	input_report_abs(dev, ABS_PRESSURE, z);
+	if (++priv->multi_packet > 2) {
+		priv->multi_packet = 0;
 
-	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
+		left = packet[4] & 0x01;
+		right = packet[4] & 0x02;
 
-	input_sync(dev);
+		x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
+		    ((packet[0] & 0x30) >> 4);
+		y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
+		z = packet[5] & 0x7f;
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
+		 * If there were no contacts in the bitmap, use ST
+		 * points in MT reports.
+		 */
+		if (fingers == 0) {
+			x1 = x;
+			y1 = y;
+			fingers = 1;
+		}
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
+	}
 }
 
 static void alps_process_packet(struct psmouse *psmouse)
@@ -1557,6 +1610,7 @@ int alps_init(struct psmouse *psmouse)
 		input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
 		break;
 	case ALPS_PROTO_V3:
+	case ALPS_PROTO_V4:
 		set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
 		input_mt_init_slots(dev1, 2);
 		input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, ALPS_V3_X_MAX, 0, 0);
@@ -1565,8 +1619,7 @@ int alps_init(struct psmouse *psmouse)
 		set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
 		set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
-		/* fall through */
-	case ALPS_PROTO_V4:
+
 		input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
 		input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
 		break;
