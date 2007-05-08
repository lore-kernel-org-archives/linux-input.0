From: Aristeu Rozanski <arozansk@redhat.com>
Subject: Re: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Tue, 8 May 2007 14:53:27 -0400
Message-ID: <20070508185327.GB4215@redhat.com>
References: <20070402204810.GC14838@redhat.com> <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com> <20070403144243.GE14838@redhat.com> <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Chris Williams <cww@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,
> You'd need to add something like this to psmouse_protocols[]:
> 
>        {
>                .type           = PSMOUSE_CORTRON,
>                .name           = "CortronPS/2",
>                .alias          = "cortps",
>                .detect         = cortron_detect,
>        },
> 
> and then model cortron_detect after ps2bare_detect (where you don't
> actually detect anything, just force protocol).
we asked Cortron again about a possible auto-detection sequence but they
didn't implemented anything in this matter. So I updated the patch
according your recomendations and Chris tested again with the Trackball,
with success. If you're ok with that, I'll resubmit it with proper
description/signed-off-by header.


--- linus-2.6.orig/drivers/input/mouse/psmouse-base.c
+++ linus-2.6/drivers/input/mouse/psmouse-base.c
@@ -177,6 +177,15 @@ static psmouse_ret_t psmouse_process_byt
 	}
 
 /*
+ * Cortron PS2 Trackball reports SIDE button on the 4th bit of the first
+ * byte.
+ */
+	if (psmouse->type == PSMOUSE_CORTRON) {
+		input_report_key(dev, BTN_SIDE, (packet[0] >> 3) & 1);
+		packet[0] |= 0x08;
+	}
+
+/*
  * Generic PS/2 Mouse
  */
 
@@ -538,6 +547,20 @@ static int ps2bare_detect(struct psmouse
 	return 0;
 }
 
+/*
+ * Cortron PS/2 protocol detection. There's no special way to detect it, so it
+ * must be forced by sysfs protocol writing.
+ */
+static int cortron_detect(struct psmouse *psmouse, int set_properties)
+{
+	if (set_properties) {
+		psmouse->vendor = "Cortron";
+		psmouse->name = "PS/2 Trackball";
+		set_bit(BTN_SIDE, psmouse->dev->keybit);
+	}
+
+	return 0;
+}
 
 /*
  * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
@@ -655,6 +678,12 @@ static const struct psmouse_protocol psm
 		.detect		= ps2bare_detect,
 	},
 	{
+		.type		= PSMOUSE_CORTRON,
+		.name		= "CortronPS/2",
+		.alias		= "cortps",
+		.detect		= cortron_detect,
+	},
+	{
 		.type		= PSMOUSE_PS2PP,
 		.name		= "PS2++",
 		.alias		= "logitech",
--- linus-2.6.orig/drivers/input/mouse/psmouse.h
+++ linus-2.6/drivers/input/mouse/psmouse.h
@@ -78,6 +78,7 @@ struct psmouse {
 enum psmouse_type {
 	PSMOUSE_NONE,
 	PSMOUSE_PS2,
+	PSMOUSE_CORTRON,
 	PSMOUSE_PS2PP,
 	PSMOUSE_THINKPS,
 	PSMOUSE_GENPS,
