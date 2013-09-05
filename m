From: "yunkang.tang@cn.alps.com" <yunkang.tang@cn.alps.com>
Subject: [PATCH 2/2] Input: ALPS Touchpad- Improve the performance of alps
 v5-protocol's touchpad
Date: Thu, 5 Sep 2013 05:50:55 +0000
Message-ID: <89B48266C4EEC447B3A3A031C8DE21870263AF93@SIXPRD0410MB394.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:52504
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000Ab3IEFu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Sep 2013 01:50:59 -0400
Content-Language: zh-CN
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "yunkang.tang@cn.alps.com" <yunkang.tang@cn.alps.com>

<Change list>
- Add the macro definition for v5 device.

--- linux-3.11/drivers/input/mouse/alps.h.orig 2013-09-04 19:51:33.837135870 +0800
+++ linux-3.11/drivers/input/mouse/alps.h 2013-09-05 21:01:57.074314890 +0800
@@ -18,6 +18,10 @@
 #define ALPS_PROTO_V4 4
 #define ALPS_PROTO_V5 5
 
+#define DOLPHIN_COUNT_PER_ELECTRODE 64
+#define DOLPHIN_PROFILE_XOFFSET  8 /* [DOLPHIN] The number of the x-electrode offset value */
+#define DOLPHIN_PROFILE_YOFFSET  1 /* [DOLPHIN] The number of the y-electrode offset value */
+
 /**
  * struct alps_model_info - touchpad ID table
  * @signature: E7 response string to match.
@@ -69,7 +73,7 @@ struct alps_nibble_commands {
  * @y: Y position for ST.
  * @z: Z position for ST.
  * @first_mp: Packet is the first of a multi-packet report.
- * @is_mp: Packet is part of a multi-packet report.
+ * @is_mp: Packet is the last of a multi-packet report.
  * @left: Left touchpad button is active.
  * @right: Right touchpad button is active.
  * @middle: Middle touchpad button is active.
@@ -145,7 +149,7 @@ struct alps_data {
 
  int (*hw_init)(struct psmouse *psmouse);
  void (*process_packet)(struct psmouse *psmouse);
- void (*decode_fields)(struct alps_fields *f, unsigned char *p);
+ void (*decode_fields)(struct alps_fields *f, unsigned char *p, struct psmouse *psmouse);
  void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
 
  int prev_fin;


-Tommy
