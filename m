From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: psmouse - move protocol descriptions around
Date: Sat, 28 Nov 2015 21:13:54 -0800
Message-ID: <1448774036-39040-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35968 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbK2FOE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2015 00:14:04 -0500
In-Reply-To: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org

We move protocol descriptions and psmouse_find_by_type() and
pmouse_find_by_name() so that we can use them without forward declarations
in the subsequent patches.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 379 ++++++++++++++++++-------------------
 1 file changed, 189 insertions(+), 190 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index c2bd866..b92c1bd 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -683,6 +683,195 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
 	return 0;
 }
 
+static const struct psmouse_protocol psmouse_protocols[] = {
+	{
+		.type		= PSMOUSE_PS2,
+		.name		= "PS/2",
+		.alias		= "bare",
+		.maxproto	= true,
+		.ignore_parity	= true,
+		.detect		= ps2bare_detect,
+	},
+#ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
+	{
+		.type		= PSMOUSE_PS2PP,
+		.name		= "PS2++",
+		.alias		= "logitech",
+		.detect		= ps2pp_init,
+	},
+#endif
+	{
+		.type		= PSMOUSE_THINKPS,
+		.name		= "ThinkPS/2",
+		.alias		= "thinkps",
+		.detect		= thinking_detect,
+	},
+#ifdef CONFIG_MOUSE_PS2_CYPRESS
+	{
+		.type		= PSMOUSE_CYPRESS,
+		.name		= "CyPS/2",
+		.alias		= "cypress",
+		.detect		= cypress_detect,
+		.init		= cypress_init,
+	},
+#endif
+	{
+		.type		= PSMOUSE_GENPS,
+		.name		= "GenPS/2",
+		.alias		= "genius",
+		.detect		= genius_detect,
+	},
+	{
+		.type		= PSMOUSE_IMPS,
+		.name		= "ImPS/2",
+		.alias		= "imps",
+		.maxproto	= true,
+		.ignore_parity	= true,
+		.detect		= intellimouse_detect,
+	},
+	{
+		.type		= PSMOUSE_IMEX,
+		.name		= "ImExPS/2",
+		.alias		= "exps",
+		.maxproto	= true,
+		.ignore_parity	= true,
+		.detect		= im_explorer_detect,
+	},
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+	{
+		.type		= PSMOUSE_SYNAPTICS,
+		.name		= "SynPS/2",
+		.alias		= "synaptics",
+		.detect		= synaptics_detect,
+		.init		= synaptics_init,
+	},
+	{
+		.type		= PSMOUSE_SYNAPTICS_RELATIVE,
+		.name		= "SynRelPS/2",
+		.alias		= "synaptics-relative",
+		.detect		= synaptics_detect,
+		.init		= synaptics_init_relative,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_ALPS
+	{
+		.type		= PSMOUSE_ALPS,
+		.name		= "AlpsPS/2",
+		.alias		= "alps",
+		.detect		= alps_detect,
+		.init		= alps_init,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_LIFEBOOK
+	{
+		.type		= PSMOUSE_LIFEBOOK,
+		.name		= "LBPS/2",
+		.alias		= "lifebook",
+		.init		= lifebook_init,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_TRACKPOINT
+	{
+		.type		= PSMOUSE_TRACKPOINT,
+		.name		= "TPPS/2",
+		.alias		= "trackpoint",
+		.detect		= trackpoint_detect,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_TOUCHKIT
+	{
+		.type		= PSMOUSE_TOUCHKIT_PS2,
+		.name		= "touchkitPS/2",
+		.alias		= "touchkit",
+		.detect		= touchkit_ps2_detect,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_OLPC
+	{
+		.type		= PSMOUSE_HGPK,
+		.name		= "OLPC HGPK",
+		.alias		= "hgpk",
+		.detect		= hgpk_detect,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_ELANTECH
+	{
+		.type		= PSMOUSE_ELANTECH,
+		.name		= "ETPS/2",
+		.alias		= "elantech",
+		.detect		= elantech_detect,
+		.init		= elantech_init,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_SENTELIC
+	{
+		.type		= PSMOUSE_FSP,
+		.name		= "FSPPS/2",
+		.alias		= "fsp",
+		.detect		= fsp_detect,
+		.init		= fsp_init,
+	},
+#endif
+	{
+		.type		= PSMOUSE_CORTRON,
+		.name		= "CortronPS/2",
+		.alias		= "cortps",
+		.detect		= cortron_detect,
+	},
+#ifdef CONFIG_MOUSE_PS2_FOCALTECH
+	{
+		.type		= PSMOUSE_FOCALTECH,
+		.name		= "FocalTechPS/2",
+		.alias		= "focaltech",
+		.detect		= focaltech_detect,
+		.init		= focaltech_init,
+	},
+#endif
+#ifdef CONFIG_MOUSE_PS2_VMMOUSE
+	{
+		.type		= PSMOUSE_VMMOUSE,
+		.name		= VMMOUSE_PSNAME,
+		.alias		= "vmmouse",
+		.detect		= vmmouse_detect,
+		.init		= vmmouse_init,
+	},
+#endif
+	{
+		.type		= PSMOUSE_AUTO,
+		.name		= "auto",
+		.alias		= "any",
+		.maxproto	= true,
+	},
+};
+
+static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++)
+		if (psmouse_protocols[i].type == type)
+			return &psmouse_protocols[i];
+
+	WARN_ON(1);
+	return &psmouse_protocols[0];
+}
+
+static const struct psmouse_protocol *psmouse_protocol_by_name(const char *name, size_t len)
+{
+	const struct psmouse_protocol *p;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++) {
+		p = &psmouse_protocols[i];
+
+		if ((strlen(p->name) == len && !strncmp(p->name, name, len)) ||
+		    (strlen(p->alias) == len && !strncmp(p->alias, name, len)))
+			return &psmouse_protocols[i];
+	}
+
+	return NULL;
+}
+
 /*
  * Apply default settings to the psmouse structure. Most of them will
  * be overridden by individual protocol initialization routines.
@@ -954,196 +1143,6 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	return PSMOUSE_PS2;
 }
 
-static const struct psmouse_protocol psmouse_protocols[] = {
-	{
-		.type		= PSMOUSE_PS2,
-		.name		= "PS/2",
-		.alias		= "bare",
-		.maxproto	= true,
-		.ignore_parity	= true,
-		.detect		= ps2bare_detect,
-	},
-#ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
-	{
-		.type		= PSMOUSE_PS2PP,
-		.name		= "PS2++",
-		.alias		= "logitech",
-		.detect		= ps2pp_init,
-	},
-#endif
-	{
-		.type		= PSMOUSE_THINKPS,
-		.name		= "ThinkPS/2",
-		.alias		= "thinkps",
-		.detect		= thinking_detect,
-	},
-#ifdef CONFIG_MOUSE_PS2_CYPRESS
-	{
-		.type		= PSMOUSE_CYPRESS,
-		.name		= "CyPS/2",
-		.alias		= "cypress",
-		.detect		= cypress_detect,
-		.init		= cypress_init,
-	},
-#endif
-	{
-		.type		= PSMOUSE_GENPS,
-		.name		= "GenPS/2",
-		.alias		= "genius",
-		.detect		= genius_detect,
-	},
-	{
-		.type		= PSMOUSE_IMPS,
-		.name		= "ImPS/2",
-		.alias		= "imps",
-		.maxproto	= true,
-		.ignore_parity	= true,
-		.detect		= intellimouse_detect,
-	},
-	{
-		.type		= PSMOUSE_IMEX,
-		.name		= "ImExPS/2",
-		.alias		= "exps",
-		.maxproto	= true,
-		.ignore_parity	= true,
-		.detect		= im_explorer_detect,
-	},
-#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
-	{
-		.type		= PSMOUSE_SYNAPTICS,
-		.name		= "SynPS/2",
-		.alias		= "synaptics",
-		.detect		= synaptics_detect,
-		.init		= synaptics_init,
-	},
-	{
-		.type		= PSMOUSE_SYNAPTICS_RELATIVE,
-		.name		= "SynRelPS/2",
-		.alias		= "synaptics-relative",
-		.detect		= synaptics_detect,
-		.init		= synaptics_init_relative,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_ALPS
-	{
-		.type		= PSMOUSE_ALPS,
-		.name		= "AlpsPS/2",
-		.alias		= "alps",
-		.detect		= alps_detect,
-		.init		= alps_init,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_LIFEBOOK
-	{
-		.type		= PSMOUSE_LIFEBOOK,
-		.name		= "LBPS/2",
-		.alias		= "lifebook",
-		.init		= lifebook_init,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_TRACKPOINT
-	{
-		.type		= PSMOUSE_TRACKPOINT,
-		.name		= "TPPS/2",
-		.alias		= "trackpoint",
-		.detect		= trackpoint_detect,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_TOUCHKIT
-	{
-		.type		= PSMOUSE_TOUCHKIT_PS2,
-		.name		= "touchkitPS/2",
-		.alias		= "touchkit",
-		.detect		= touchkit_ps2_detect,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_OLPC
-	{
-		.type		= PSMOUSE_HGPK,
-		.name		= "OLPC HGPK",
-		.alias		= "hgpk",
-		.detect		= hgpk_detect,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_ELANTECH
-	{
-		.type		= PSMOUSE_ELANTECH,
-		.name		= "ETPS/2",
-		.alias		= "elantech",
-		.detect		= elantech_detect,
-		.init		= elantech_init,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_SENTELIC
-	{
-		.type		= PSMOUSE_FSP,
-		.name		= "FSPPS/2",
-		.alias		= "fsp",
-		.detect		= fsp_detect,
-		.init		= fsp_init,
-	},
-#endif
-	{
-		.type		= PSMOUSE_CORTRON,
-		.name		= "CortronPS/2",
-		.alias		= "cortps",
-		.detect		= cortron_detect,
-	},
-#ifdef CONFIG_MOUSE_PS2_FOCALTECH
-	{
-		.type		= PSMOUSE_FOCALTECH,
-		.name		= "FocalTechPS/2",
-		.alias		= "focaltech",
-		.detect		= focaltech_detect,
-		.init		= focaltech_init,
-	},
-#endif
-#ifdef CONFIG_MOUSE_PS2_VMMOUSE
-	{
-		.type		= PSMOUSE_VMMOUSE,
-		.name		= VMMOUSE_PSNAME,
-		.alias		= "vmmouse",
-		.detect		= vmmouse_detect,
-		.init		= vmmouse_init,
-	},
-#endif
-	{
-		.type		= PSMOUSE_AUTO,
-		.name		= "auto",
-		.alias		= "any",
-		.maxproto	= true,
-	},
-};
-
-static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++)
-		if (psmouse_protocols[i].type == type)
-			return &psmouse_protocols[i];
-
-	WARN_ON(1);
-	return &psmouse_protocols[0];
-}
-
-static const struct psmouse_protocol *psmouse_protocol_by_name(const char *name, size_t len)
-{
-	const struct psmouse_protocol *p;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++) {
-		p = &psmouse_protocols[i];
-
-		if ((strlen(p->name) == len && !strncmp(p->name, name, len)) ||
-		    (strlen(p->alias) == len && !strncmp(p->alias, name, len)))
-			return &psmouse_protocols[i];
-	}
-
-	return NULL;
-}
-
-
 /*
  * psmouse_probe() probes for a PS/2 mouse.
  */
-- 
2.6.0.rc2.230.g3dd15c0

