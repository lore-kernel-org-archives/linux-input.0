From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v2] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Sat, 5 Nov 2016 12:44:58 -0400
Message-ID: <20161105164458.GF2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161101093507.GE3081@pali>
 <20161105163047.GE2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:44235 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755486AbcKEQpA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 5 Nov 2016 12:45:00 -0400
Content-Disposition: inline
In-Reply-To: <20161105163047.GE2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

The current Alps SS5 (SS4 v2) code generates bogus TouchPad events when 
TrackStick packets are processed.

This causes the xorg synaptics driver to print 
"unable to find touch point 0" and 
"BUG: triggered 'if (priv->num_active_touches > priv->num_slots)'" 
messages.  It also causes unexpected TouchPad button release and reclick 
event sequences if the TrackStick is moved while holding a TouchPad 
button.

This commit corrects the problem by adjusting
alps_process_packet_ss4_v2() so that it only sends TrackStick reports
when processing TrackStick packets.

Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 6d7de9b..1d0302b 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1279,6 +1279,8 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
                        input_report_rel(priv->dev2, REL_Y, -y);
                        input_report_abs(priv->dev2, ABS_PRESSURE, pressure);
                }
+               f->first_mp = 0;
+               f->is_mp = 0;
                break;
 
        case SS4_PACKET_ID_IDLE:
@@ -1346,18 +1348,18 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
        priv->multi_packet = 0;
 
-       alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
+       if ((packet[3] & 0x30) != 0x20) {
+               alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
 
-       input_mt_report_finger_count(dev, f->fingers);
+               input_mt_report_finger_count(dev, f->fingers);
 
-       input_report_key(dev, BTN_LEFT, f->left);
-       input_report_key(dev, BTN_RIGHT, f->right);
-       input_report_key(dev, BTN_MIDDLE, f->middle);
+               input_report_key(dev, BTN_LEFT, f->left);
+               input_report_key(dev, BTN_RIGHT, f->right);
+               input_report_key(dev, BTN_MIDDLE, f->middle);
 
-       input_report_abs(dev, ABS_PRESSURE, f->pressure);
-       input_sync(dev);
-
-       if (priv->flags & ALPS_DUALPOINT) {
+               input_report_abs(dev, ABS_PRESSURE, f->pressure);
+               input_sync(dev);
+       } else if (priv->flags & ALPS_DUALPOINT) {
                input_report_key(dev2, BTN_LEFT, f->ts_left);
                input_report_key(dev2, BTN_RIGHT, f->ts_right);
                input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
