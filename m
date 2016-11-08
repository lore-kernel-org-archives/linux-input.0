From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v3 2/3] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Tue, 8 Nov 2016 09:59:51 -0500
Message-ID: <20161108145951.GL2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108145423.GK2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:45243 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbcKHO7x (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 09:59:53 -0500
Content-Disposition: inline
In-Reply-To: <20161108145423.GK2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>

Input: ALPS - Clean up TrackStick handling for SS5 hardware

For consistency and clarity, the input_report_*() functions should
be called by alps_process_packet_ss4_v2() instead of by
alps_decode_ss4_v2().

Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index b93fe83..12376d2 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1267,18 +1267,11 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
                break;
 
        case SS4_PACKET_ID_STICK:
-               if (!(priv->flags & ALPS_DUALPOINT)) {
-                       psmouse_warn(psmouse,
-                                    "Rejected trackstick packet from non DualPoint device");
-               } else {
-                       int x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
-                       int y = (s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
-                       int pressure = (s8)(p[4] & 0x7f);
-
-                       input_report_rel(priv->dev2, REL_X, x);
-                       input_report_rel(priv->dev2, REL_Y, -y);
-                       input_report_abs(priv->dev2, ABS_PRESSURE, pressure);
-               }
+               f->st.x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
+               f->st.y = -(s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
+               f->pressure = (s8)(p[4] & 0x7f);
+               f->first_mp = 0;
+               f->is_mp = 0;
                break;
 
        case SS4_PACKET_ID_IDLE:
@@ -1348,12 +1341,21 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
        /* Report trackstick */
        if (alps_get_pkt_id_ss4_v2(packet) == SS4_PACKET_ID_STICK) {
-               if (priv->flags & ALPS_DUALPOINT) {
-                       input_report_key(dev2, BTN_LEFT, f->ts_left);
-                       input_report_key(dev2, BTN_RIGHT, f->ts_right);
-                       input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
-                       input_sync(dev2);
+               if (!(priv->flags & ALPS_DUALPOINT)) {
+                       psmouse_warn(psmouse,
+                                    "Rejected trackstick packet from non DualPoint device");
+                       return;
                }
+
+               input_report_rel(priv->dev2, REL_X, f->st.x);
+               input_report_rel(priv->dev2, REL_Y, f->st.y);
+               input_report_abs(priv->dev2, ABS_PRESSURE, f->pressure);
+
+               input_report_key(dev2, BTN_LEFT, f->ts_left);
+               input_report_key(dev2, BTN_RIGHT, f->ts_right);
+               input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
+
+               input_sync(dev2);
                return;
        }
 
