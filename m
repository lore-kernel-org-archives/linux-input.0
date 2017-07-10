From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Cypress PS/2 trackpad does not work
Date: Mon, 10 Jul 2017 15:24:27 +0800
Message-ID: <CAAd53p73UxYQO-fDy5wrPbzZ+xFzTCas_oDq_yWZJYdoOJyATw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35423 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbdGJHYn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 03:24:43 -0400
Received: by mail-wr0-f173.google.com with SMTP id k67so125620801wrc.2
        for <linux-input@vger.kernel.org>; Mon, 10 Jul 2017 00:24:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dudl@cypress.com

Hi,

The original bug report is at [1].

I used diff below to
1. generate verbose debug information,
2. print bad packet data,
3. ignore bad data and continue
.. But the touchpad still falls back to ImPS/2 mouse. The dmesg is at [2].

Also, change "cytp->tp_metrics_supporte" from 1 to 0 doesn't help, either.

How do I help the user to debug this issue further?

Thanks.


diff --git a/drivers/input/mouse/cypress_ps2.c
b/drivers/input/mouse/cypress_ps2.c
index 125f72cf9814..ed2cf770ae53 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -27,7 +27,7 @@

 #include "cypress_ps2.h"

-#undef CYTP_DEBUG_VERBOSE  /* define this and DEBUG for more verbose dump */
+#define CYTP_DEBUG_VERBOSE  /* define this and DEBUG for more verbose dump */

 static void cypress_set_packet_size(struct psmouse *psmouse, unsigned int n)
 {
@@ -583,8 +583,12 @@ static psmouse_ret_t cypress_validate_byte(struct
psmouse *psmouse)
        unsigned char *packet = psmouse->packet;
        struct cytp_data *cytp = psmouse->private;

-       if (index < 0 || index > cytp->pkt_size)
+       if (index < 0 || index > cytp->pkt_size) {
+               psmouse_warn(psmouse,
+                               "lp1693440: index = %d, pkt_size = %d\n",
+                               index, cytp->pkt_size);
                return PSMOUSE_BAD_DATA;
+       }

        if (index == 0 && (packet[0] & 0xfc) == 0) {
                /* call packet process for reporting finger leave. */
@@ -606,8 +610,13 @@ static psmouse_ret_t cypress_validate_byte(struct
psmouse *psmouse)
        if ((cytp->mode & CYTP_BIT_ABS_REL_MASK) == 0)
                return PSMOUSE_GOOD_DATA;

-       if ((packet[0] & 0x08) == 0x08)
-               return PSMOUSE_BAD_DATA;
+       if ((packet[0] & 0x08) == 0x08) {
+               psmouse_warn(psmouse,
+                               "lp1693440: bad packet[0] = %0x, "
+                               "but let's pretend it's nothing\n",
+                               packet[0]);
+               //return PSMOUSE_BAD_DATA;
+       }

        contact_cnt = cypress_get_finger_count(packet[0]);
        if (cytp->mode & CYTP_BIT_ABS_NO_PRESSURE)


[1] https://bugs.launchpad.net/bugs/1693440
[2] https://launchpadlibrarian.net/326836808/4.12dmesg
