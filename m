From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v4 3/3] Input: ALPS - Clean up code for SS5 hardware
Date: Tue, 8 Nov 2016 10:17:10 -0500
Message-ID: <20161108151710.GP2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
 <20161108151621.GO2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:35181 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbcKHPRM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 10:17:12 -0500
Content-Disposition: inline
In-Reply-To: <20161108151621.GO2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>

The return value of alps_get_pkt_id_ss4_v2() should really be
"enum SS4_PACKET_ID", not "unsigned char".  Correct this.
    
Also, most of the Alps SS5 (SS4 v2) packet byte parsing code is
implemented using macros, but there are a few places where bytes are
directly manipulated in alps.c.  For consistency, migrate the rest of
these to macros.
    
Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 12376d2..6a2fb69 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1153,15 +1153,13 @@ static void alps_process_packet_v7(struct psmouse *psmouse)
 		alps_process_touchpad_packet_v7(psmouse);
 }
 
-static unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
+static enum SS4_PACKET_ID alps_get_pkt_id_ss4_v2(unsigned char *byte)
 {
-	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
+	enum SS4_PACKET_ID pkt_id = SS4_PACKET_ID_IDLE;
 
 	switch (byte[3] & 0x30) {
 	case 0x00:
-		if (byte[0] == 0x18 && byte[1] == 0x10 && byte[2] == 0x00 &&
-		    (byte[3] & 0x88) == 0x08 && byte[4] == 0x10 &&
-		    byte[5] == 0x00) {
+		if (SS4_IS_IDLE_V2(byte)) {
 			pkt_id = SS4_PACKET_ID_IDLE;
 		} else {
 			pkt_id = SS4_PACKET_ID_ONE;
@@ -1188,7 +1186,7 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 			      unsigned char *p, struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	unsigned char pkt_id;
+	enum SS4_PACKET_ID pkt_id;
 	unsigned int no_data_x, no_data_y;
 
 	pkt_id = alps_get_pkt_id_ss4_v2(p);
@@ -1267,9 +1265,9 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 		break;
 
 	case SS4_PACKET_ID_STICK:
-		f->st.x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
-		f->st.y = -(s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
-		f->pressure = (s8)(p[4] & 0x7f);
+		f->st.x = SS4_TS_X_V2(p);
+		f->st.y = SS4_TS_Y_V2(p);
+		f->pressure = SS4_TS_Z_V2(p);
 		f->first_mp = 0;
 		f->is_mp = 0;
 		break;
@@ -1361,14 +1359,13 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
 	/* Report touchpad */
 	alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
-
 	input_mt_report_finger_count(dev, f->fingers);
+	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 
 	input_report_key(dev, BTN_LEFT, f->left);
 	input_report_key(dev, BTN_RIGHT, f->right);
 	input_report_key(dev, BTN_MIDDLE, f->middle);
 
-	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 	input_sync(dev);
 }
 
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index b9417e2..e221dab 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -54,7 +54,15 @@ enum SS4_PACKET_ID {
 
 #define SS4_MASK_NORMAL_BUTTONS		0x07
 
-#define SS4_1F_X_V2(_b)		((_b[0] & 0x0007) |		\
+#define SS4_IS_IDLE_V2(_b)	(((_b[0]) == 0x18) &&		\
+				 ((_b[1]) == 0x10) &&		\
+				 ((_b[2]) == 0x00) &&		\
+				 ((_b[3] & 0x88) == 0x08) &&	\
+				 ((_b[4]) == 0x10) &&		\
+				 ((_b[5]) == 0x00)		\
+				)
+
+#define SS4_1F_X_V2(_b)		(((_b[0]) & 0x0007) |		\
 				 ((_b[1] << 3) & 0x0078) |	\
 				 ((_b[1] << 2) & 0x0380) |	\
 				 ((_b[2] << 5) & 0x1C00)	\
@@ -101,6 +109,16 @@ enum SS4_PACKET_ID {
 #define SS4_IS_MF_CONTINUE(_b)	((_b[2] & 0x10) == 0x10)
 #define SS4_IS_5F_DETECTED(_b)	((_b[2] & 0x10) == 0x10)
 
+#define SS4_TS_X_V2(_b)		(((_b[0] & 0x01) << 7) |	\
+				 ((_b[1]) & 0x7F)		\
+				)
+
+#define SS4_TS_Y_V2(_b)		-(((_b[3] & 0x01) << 7) |	\
+				  ((_b[2]) & 0x7F)		\
+				 )
+
+#define SS4_TS_Z_V2(_b)		(_b[4] & 0x7F)
+
 
 #define SS4_MFPACKET_NO_AX	8160	/* X-Coordinate value */
 #define SS4_MFPACKET_NO_AY	4080	/* Y-Coordinate value */
