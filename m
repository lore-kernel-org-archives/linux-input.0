From: Julian Exner <jexner@techfak.uni-bielefeld.de>
Subject: Re: Input: mouse: Trackpoint middle button not recognized on Thinkpad
 E470
Date: Wed, 26 Apr 2017 23:18:44 +0200
Message-ID: <a1682c1c-3894-0439-f224-b6c6fc73eba6@techfak.uni-bielefeld.de>
References: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
 <f516c725-48d8-6f82-5ac7-c6afee303e59@techfak.uni-bielefeld.de>
 <20170425211633.bl72ajw5duwdpq4j@beacon.debie>
 <20170425221014.GD30843@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------237A50C8D32081CC6A20FAA0"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smarthost.TechFak.Uni-Bielefeld.DE ([129.70.137.17]:47528 "EHLO
        smarthost.TechFak.Uni-Bielefeld.DE" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030396AbdDZVSq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 17:18:46 -0400
In-Reply-To: <20170425221014.GD30843@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ulrik.debie-os@e2big.org
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, aduggan@synaptics.com

This is a multi-part message in MIME format.
--------------237A50C8D32081CC6A20FAA0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 26/04/17 00:10, Dmitry Torokhov wrote:
> Hmm.. I do not recall seeing real trackpoints with only 2 buttons. Let's
> try defaulting to 3 and see what happens.

This patch assumes three buttons when the trackpoint_read command 
failed. This is just a quick fix. trackpoint_read may fail for other 
reasons than the extended-button-data command not being available, e.g. 
errors in the ps2 communication. A more narrow solution should check if 
a resend request was received, resend, and if the resend failed assume 
three buttons.

--------------237A50C8D32081CC6A20FAA0
Content-Type: text/x-patch;
 name="trackpoint-default-3-buttons.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trackpoint-default-3-buttons.patch"

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 354d47e..70c3a48 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -380,8 +380,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 		return 0;
 
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
-		psmouse_warn(psmouse, "failed to get extended button data\n");
-		button_info = 0;
+		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons are present\n");
+		button_info = 0x33;
 	}
 
 	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);

--------------237A50C8D32081CC6A20FAA0--
