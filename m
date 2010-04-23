From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] reset quirk at reconnect for Synaptics touchpads
Date: Fri, 23 Apr 2010 02:52:39 +0200
Message-ID: <1271983959.16254.48.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:52578 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab0DWArH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 20:47:07 -0400
Received: by bwz25 with SMTP id 25so10400577bwz.28
        for <linux-input@vger.kernel.org>; Thu, 22 Apr 2010 17:47:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

If a Synaptics touchpad can't be initialized (synaptics_init) and falls
back to PS/2, it doesn't get a psmouse_reset() after resuming from
suspend as it would get with a synaptics driver.
 So check state of synaptics_hardware and reset this beast.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/mouse/psmouse-base.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index d8c0c8d..66ce0ac 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -116,6 +116,9 @@ struct psmouse_protocol {
 	int (*init)(struct psmouse *);
 };
 
+/* to handle some reset quirks */
+static bool synaptics_hardware = false;
+
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
  * relevant events to the input module once full packet has arrived.
@@ -597,7 +600,6 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
 static int psmouse_extensions(struct psmouse *psmouse,
 			      unsigned int max_proto, bool set_properties)
 {
-	bool synaptics_hardware = false;
 
 /*
  * We always check for lifebook because it does not disturb mouse
@@ -1401,10 +1403,14 @@ static int psmouse_reconnect(struct serio *serio)
 	if (psmouse->reconnect) {
 		if (psmouse->reconnect(psmouse))
 			goto out;
-	} else if (psmouse_probe(psmouse) < 0 ||
+	} else {
+		if (synaptics_hardware)		/* is using plain PS/2 */
+			psmouse_reset(psmouse);
+		if (psmouse_probe(psmouse) < 0 ||
 		   psmouse->type != psmouse_extensions(psmouse,
 						psmouse_max_proto, false)) {
-		goto out;
+			goto out;
+		}
 	}
 
 	/* ok, the device type (and capabilities) match the old one,
-- 
1.5.6.5



