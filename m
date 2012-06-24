From: Eric Miao <eric.miao@canonical.com>
Subject: [PATCH RFC] input: fix weird issue of synaptics psmouse sync lost
 after resume
Date: Sun, 24 Jun 2012 23:32:38 +0800
Message-ID: <CAMPhdO92C=t8hDYAkk5rG0ZNHnLiZQ2WY3SP+LGJ=VNJL=Unaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54226 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2FXPdA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jun 2012 11:33:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ayan George <ayan.george@canonical.com>

All,

BugLink: https://bugs.launchpad.net/bugs/717970

So in summary, the symptom is intermittent key events lost after resume
on some machines with synaptics touchpad (seems this is synaptics _only_),
and key events loss is due to serio port reconnect after psmouse sync lost.
Removing psmouse and inserting it back during the suspend/resume process
is able to work around the issue, so the difference between psmouse_connect()
and psmouse_reconnect() is the key to the root cause of this problem.

After comparing the two different paths, synaptics driver has its own
implementation of synaptics_reconnect(), and the missing psmouse_probe()
seems significant, the patch below added psmouse_probe() to the reconnect
process, and has been verified many times that the issue could not be reliably
reproduced.

There are two PS/2 commands in psmouse_probe():

  1. PSMOUSE_CMD_GETID
  2. PSMOUSE_CMD_RESET_DIS

The weird thing is, the PSMOUSE_CMD_GETID seems to be significant, and the
PSMOUSE_CMD_RESET_DIS is irrelevant to this issue after trying several times.
Now it's rather difficult to form a sane theory. So this patch is
really for RFC.
Note it does fix a real problem though.

========= >8 =========

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 8eac3b7..7a72d82 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1218,6 +1218,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 {
        struct synaptics_data *priv = psmouse->private;
        struct synaptics_data old_priv = *priv;
+       unsigned char param[2];
        int retry = 0;
        int error;

@@ -1233,6 +1234,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
                         */
                        ssleep(1);
                }
+               ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETID);
                error = synaptics_detect(psmouse, 0);
        } while (error && ++retry < 3);
