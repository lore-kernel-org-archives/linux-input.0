From: Ulrich Dangel <uli-kernel@spamt.net>
Subject: [PATCH] input/mouse/alps.c: Handle touchpoints buttons correctly
Date: Mon, 17 Nov 2008 02:42:50 +0100
Message-ID: <200811170242.51046.uli-kernel@spamt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dino.spamt.net ([217.10.9.51]:48582 "EHLO dino.spamt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbYKQBnA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Nov 2008 20:43:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>

When pressing any button belonging to the touchpoint, the generated click
events dont belong to the touchpoint but to the touchpad.

This patch fixes this behaviour, the events will be sent via the correct
device, so scrolling with touchpoint is possible.

The patch compiles cleanly and has been tested successfully on my
machine.

Signed-off-by: Ulrich Dangel <uli@spamt.net>

---

 alps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)


--- a/drivers/input/mouse/alps.c    2008-10-26 00:05:07.000000000 +0200
+++ b/drivers/input/mouse/alps.c    2008-11-17 01:22:03.738057264 +0100
@@ -130,18 +130,23 @@ static void alps_process_packet(struct p
    ges = packet[2] & 1;
    fin = packet[2] & 2;

-   input_report_key(dev, BTN_LEFT, left);
-   input_report_key(dev, BTN_RIGHT, right);
-   input_report_key(dev, BTN_MIDDLE, middle);
-
    if ((priv->i->flags & ALPS_DUALPOINT) && z == 127) {
        input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
        input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
+
+       input_report_key(dev2, BTN_LEFT, left);
+       input_report_key(dev2, BTN_RIGHT, right);
+       input_report_key(dev2, BTN_MIDDLE, middle);
+
        input_sync(dev);
        input_sync(dev2);
        return;
    }

+   input_report_key(dev, BTN_LEFT, left);
+   input_report_key(dev, BTN_RIGHT, right);
+   input_report_key(dev, BTN_MIDDLE, middle);
+
    /* Convert hardware tap to a reasonable Z value */
    if (ges && !fin) z = 40;
