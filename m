From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Separate set parameter function for MT device
Date: Sat, 28 Mar 2015 20:37:37 -0700
Message-ID: <20150329033737.GA36501@dtor-ws>
References: <1427409967-4721-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34115 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbbC2Dhl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 23:37:41 -0400
Received: by iedfl3 with SMTP id fl3so107920706ied.1
        for <linux-input@vger.kernel.org>; Sat, 28 Mar 2015 20:37:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427409967-4721-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: hdegoede@redhat.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com

On Fri, Mar 27, 2015 at 06:46:06AM +0800, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - Separate set parameter function for MT device.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

Thank you Masaki. I think we should not try to make
alps_set_abs_params_v7 also handle v8 down the road, but have separate
alps_set_abs_params_ss4_v2, so I changed this patch a bit, see below.

Thanks.

-- 
Dmitry

Input: ALPS - refactor alps_set_abs_params_mt()

From: Masaki Ota <masaki.ota@jp.alps.com>

In preparation for adding support for SS4 touchpads, let's split
alps_set_abs_params_mt into common, v7-specific, and other protocols
portions.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 33198b9..029f831 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -157,6 +157,8 @@ static void alps_set_abs_params_st(struct alps_data *priv,
 				   struct input_dev *dev1);
 static void alps_set_abs_params_mt(struct alps_data *priv,
 				   struct input_dev *dev1);
+static void alps_set_abs_params_v7(struct alps_data *priv,
+				   struct input_dev *dev1);
 
 /* Packet formats are described in Documentation/input/alps.txt */
 
@@ -2302,7 +2304,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
 		priv->hw_init = alps_hw_init_v7;
 		priv->process_packet = alps_process_packet_v7;
 		priv->decode_fields = alps_decode_packet_v7;
-		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->set_abs_params = alps_set_abs_params_v7;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
 		priv->x_max = 0xfff;
@@ -2428,10 +2430,11 @@ static void alps_set_abs_params_st(struct alps_data *priv,
 {
 	input_set_abs_params(dev1, ABS_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
+	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
 }
 
-static void alps_set_abs_params_mt(struct alps_data *priv,
-				   struct input_dev *dev1)
+static void alps_set_abs_params_mt_common(struct alps_data *priv,
+					  struct input_dev *dev1)
 {
 	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
@@ -2439,15 +2442,29 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
 	input_abs_set_res(dev1, ABS_MT_POSITION_X, priv->x_res);
 	input_abs_set_res(dev1, ABS_MT_POSITION_Y, priv->y_res);
 
-	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
-		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
-
 	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
+}
+
+static void alps_set_abs_params_mt(struct alps_data *priv,
+				   struct input_dev *dev1)
+{
+	alps_set_abs_params_mt_common(priv, dev1);
+	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
+
+	input_mt_init_slots(dev1, MAX_TOUCHES,
+			    INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
+				INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
+}
+
+static void alps_set_abs_params_v7(struct alps_data *priv,
+				   struct input_dev *dev1)
+{
+	alps_set_abs_params_mt_common(priv, dev1);
 
-	/* V7 is real multi-touch */
-	if (priv->proto_version == ALPS_PROTO_V7)
-		clear_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
+	input_mt_init_slots(dev1, MAX_TOUCHES,
+			    INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
+				INPUT_MT_TRACK);
 }
 
 int alps_init(struct psmouse *psmouse)
@@ -2480,9 +2497,6 @@ int alps_init(struct psmouse *psmouse)
 	dev1->evbit[BIT_WORD(EV_ABS)] |= BIT_MASK(EV_ABS);
 
 	priv->set_abs_params(priv, dev1);
-	/* No pressure on V7 */
-	if (priv->proto_version != ALPS_PROTO_V7)
-		input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
 
 	if (priv->flags & ALPS_WHEEL) {
 		dev1->evbit[BIT_WORD(EV_REL)] |= BIT_MASK(EV_REL);
