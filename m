From: Ramiro Morales <cramm0@gmail.com>
Subject: [PATCH] Input: synaptics - quirk for Thinkpad E440
Date: Thu, 19 Mar 2015 07:37:22 -0300
Message-ID: <1426761442-4823-1-git-send-email-cramm0@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34262 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbbCSKh3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 06:37:29 -0400
Received: by qcaz10 with SMTP id z10so62054038qca.1
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2015 03:37:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ramiro Morales <cramm0@gmail.com>

Its ClickPad shares PNP ID "LEN2006" with the one in model E540 which is
already handled by the driver (both are Haswell iterations of the Edge
line, launched in 2014) but the dimensions it reports are different:

  $ sudo ./touchpad-edge-detector /dev/input/event3
  Touchpad SynPS/2 Synaptics TouchPad on /dev/input/event3
  Move one finger around the touchpad to detect the actual edges
  Kernel says: x [1472..5044], y [1408..3398]
  Touchpad sends: x [1024..5045], y [2457..4832] /^C

Fortunately we can use the board ID, which is also different, to
distinguish among them.

  $ dmesg | grep -i synaptics
  psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
      caps: 0xd001a3/0x940300/0x127c00, board id: 2691, fw id: 1494646
  psmouse serio1: synaptics: serio: Synaptics pass-through port at
      isa0060/serio1/input0
  input: SynPS/2 Synaptics TouchPad as
      /devices/platform/i8042/serio1/input/input4

Board ID in E540 is 2722:

  psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
      caps: 0xd001a3/0x940300/0x127c00, board id: 2722, fw id: 1484859

(from https://launchpadlibrarian.net/179702965/BootDmesg.txt)

Signed-off-by: Ramiro Morales <cramm0@gmail.com>
---
 drivers/input/mouse/synaptics.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ca7ca8d..880fc49 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -154,6 +154,11 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 	},
 	{
 		(const char * const []){"LEN2006", NULL},
+		{2691, 2691},
+		1024, 5045, 2457, 4632
+	},
+	{
+		(const char * const []){"LEN2006", NULL},
 		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1264, 5675, 1171, 4688
 	},
@@ -189,7 +194,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN2003",
 	"LEN2004", /* L440 */
 	"LEN2005",
-	"LEN2006",
+	"LEN2006", /* Edge E440/E540 */
 	"LEN2007",
 	"LEN2008",
 	"LEN2009",
-- 
1.9.1

