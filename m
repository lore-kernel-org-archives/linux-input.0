From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics_rmi4 - register F03 port as pass-through
 serio
Date: Tue, 6 Jun 2017 23:51:28 -0700
Message-ID: <20170607065128.GA31686@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32819 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdFGGvc (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:51:32 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-kernel@vger.kernel.org

The 5th generation Thinkpad X1 Carbons use Synaptics touchpads accessible
over SMBus/RMI, combined with ALPS or Elantech trackpoint devices instead
of classic IBM/Lenovo trackpoints. Unfortunately there is no way for ALPS
driver to detect whether it is dealing with touchpad + trackpoint
combination or just a trackpoint, so we end up with a "phantom" dualpoint
ALPS device in addition to real touchpad and trackpoint.

Given that we do not have any special advanced handling for ALPS or
Elantech trackpoints (unlike IBM trackpoints that have separate driver and
a host of options) we are better off keeping the trackpoints in PS/2
emulation mode. We achieve that by setting serio type to SERIO_PS_PSTHRU,
which will limit number of protocols psmouse driver will try. In addition
to getting rid of the "phantom" touchpads, this will also speed up probing
of F03 pass-through port.

Reported-by: Damjan Georgievski <gdamjan@gmail.com>
Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 77dad045a468..ad71a5e768dc 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -146,7 +146,7 @@ static int rmi_f03_register_pt(struct f03_data *f03)
 	if (!serio)
 		return -ENOMEM;
 
-	serio->id.type = SERIO_8042;
+	serio->id.type = SERIO_PS_PSTHRU;
 	serio->write = rmi_f03_pt_write;
 	serio->port_data = f03;
 
-- 
2.13.0.506.g27d5fe0cd-goog


-- 
Dmitry
