From: Alon Ziv <alonz@nolaviz.org>
Subject: [PATCH] Try harder to probe finicky rodents
Date: Sun, 22 Jul 2007 20:24:56 +0300
Message-ID: <1185125096.13699.4.camel@bruno.nolaviz.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_0eUK2fVl0QKV2P4n82Wb3Q)"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org


--Boundary_(ID_0eUK2fVl0QKV2P4n82Wb3Q)
Content-type: text/plain
Content-transfer-encoding: 7BIT

My rodent appears to be extra-finicky, and requires both a
PSMOUSE_RESET_DIS and a PSMOUSE_RESET_BAT before it is unconfused
enough to be probed.

Signed-off-by: Alon Ziv <lkml@nolaviz.org>
---
 drivers/input/mouse/psmouse-base.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


--Boundary_(ID_0eUK2fVl0QKV2P4n82Wb3Q)
Content-type: application/mbox; name=0001-Try-harder.patch
Content-transfer-encoding: 7bit
Content-disposition: attachment; filename=0001-Try-harder.patch

>From 0d206d8a22c60d6720d1f5043baed8a3c4fd72a4 Mon Sep 17 00:00:00 2001
From: Alon Ziv <alonz@nolaviz.org>
Date: Sun, 22 Jul 2007 20:08:40 +0300
Subject: [PATCH] Try harder to probe finicky rodents

Some rodents appear to be extra-finicky, and require both a PSMOUSE_RESET_DIS
and a PSMOUSE_RESET_BAT before they are unconfused enough to be probed.

Signed-off-by: Alon Ziv <lkml@nolaviz.org>
---
 drivers/input/mouse/psmouse-base.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index b9f0fb2..ca039a5 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -651,6 +651,7 @@ static int psmouse_extensions(struct psmouse *psmouse,
  * protocol probes. Note that we do full reset becuase some mice
  * put themselves to sleep when see PSMOUSE_RESET_DIS.
  */
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 	psmouse_reset(psmouse);
 
 	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse, set_properties) == 0)
-- 
1.5.2.146.gb75c6


--Boundary_(ID_0eUK2fVl0QKV2P4n82Wb3Q)--
