From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics, CAP_FORCEPAD, bad behavior
Date: Thu, 9 Oct 2014 18:03:38 -0700
Message-ID: <20141010010338.GA27033@dtor-ws>
References: <543656A2.4080009@kernelconcepts.de>
 <20141009165246.GA18213@dtor-ws>
 <20141009172832.GB18213@dtor-ws>
 <543726A6.3020804@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45169 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaJJBDm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2014 21:03:42 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so685182pad.5
        for <linux-input@vger.kernel.org>; Thu, 09 Oct 2014 18:03:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <543726A6.3020804@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Nicole Faerber <nicole.faerber@kernelconcepts.de>, Christopher Heiny <cheiny@synaptics.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Oct 09, 2014 at 05:21:58PM -0700, Andrew Duggan wrote:
> On 10/09/2014 10:28 AM, Dmitry Torokhov wrote:
> >On Thu, Oct 09, 2014 at 09:52:46AM -0700, Dmitry Torokhov wrote:
> >>On Thu, Oct 09, 2014 at 11:34:26AM +0200, Nicole Faerber wrote:
> >>>Hi!
> >>>Just installed the just released 3.17 kernel and found a bad behavior of
> >>>the new Synaptics driver on my Thinkpad Yoga which has the new Synaptics
> >>>clickpad enabled touchpad:
> >>>
> >>>psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
> >>>caps: 0xd002a3/0x940300/0x12f800, board id: 2911, fw id: 2560
> >>>
> >>>The issue is that now a button release is only issued after the finger
> >>>has completely left the touchpad and not when releasing the physical
> >>>button. Is this physical button now called FORCEPAD? Anyway, this is
> >>>pretty annoying. Double clicking become a real pain.
> >>>I did comment out the new
> >>>
> >>>	if (SYN_CAP_FORCEPAD(priv->ext_cap_0c)) {
> >>>	...
> >>>
> >>>and everything is back to normal again, i.e. when I do release the pad
> >>>physical button but keep the finger on the pad, the button release event
> >>>is issued properly.
> >>Hmm, the forcepad code should only activate if the devoice do4es not
> >>have physical buttons at all. Let me see what's the diffference in
> >>capabilities between your and mine touchpads...
> >OK, so your extended caps are 0x12f800 while on my forcepad they are
> >0x12e800. The forcepad bit is supposed to be bit 15, so it is set for
> >both our devices, but bit 12 (counting from 0) is different.
> >
> >Andrew, Chris, could you please tell us what bit 12 indicates? In fact,
> >if you could share the updated description for all currently defined
> >capability bits that would be awesome.
> >
> >Thanks!
> >
> Hmm, looks like I got incorrect information about the ForcePad
> capabilities bit and unfortunately there does not seem to be a
> capabilities bit for ForcePad on PS/2. Too bad that wasn't caught
> before 3.17 was released. Bit 12 is for "uniform clickpad" which
> means that the whole clickpad moves when you press it as opposed to
> it being hinged at the top. That makes sense that a ForcePad would
> not have that capability.

Argh, that is unfortunate. Well, I guess we are back to DMI checks.

Thanks.

-- 
Dmitry

Input: synaptics - gate forcepad support by DMI check

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Unfortunately, ForcePad capability is not actually exported over PS/2, so
we have to resort to DMI checks.

Cc: stable@vger.kernel.org
Reported-by: Nicole Faerber <nicole.faerber@kernelconcepts.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c |   22 +++++++++++++++++++++-
 drivers/input/mouse/synaptics.h |    8 ++------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 6394d9b..9031a0a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -607,6 +607,8 @@ static void synaptics_parse_agm(const unsigned char buf[],
 	priv->agm_pending = true;
 }
 
+static bool is_forcepad;
+
 static int synaptics_parse_hw_state(const unsigned char buf[],
 				    struct synaptics_data *priv,
 				    struct synaptics_hw_state *hw)
@@ -636,7 +638,7 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 		hw->left  = (buf[0] & 0x01) ? 1 : 0;
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
 
-		if (SYN_CAP_FORCEPAD(priv->ext_cap_0c)) {
+		if (is_forcepad) {
 			/*
 			 * ForcePads, like Clickpads, use middle button
 			 * bits to report primary button clicks.
@@ -1667,11 +1669,29 @@ static const struct dmi_system_id __initconst cr48_dmi_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id forcepad_dmi_table[] __initconst = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook Folio 1040 G1"),
+		},
+	},
+#endif
+	{ }
+};
+
 void __init synaptics_module_init(void)
 {
 	impaired_toshiba_kbc = dmi_check_system(toshiba_dmi_table);
 	broken_olpc_ec = dmi_check_system(olpc_dmi_table);
 	cr48_profile_sensor = dmi_check_system(cr48_dmi_table);
+
+	/*
+	 * Unfortunately ForcePad capability is not exported over PS/2,
+	 * so we have to resort to checking DMI.
+	 */
+	is_forcepad = dmi_check_system(forcepad_dmi_table);
 }
 
 static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index fb2e076..1bd01f2 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -77,12 +77,9 @@
  *					for noise.
  * 2	0x08	image sensor		image sensor tracks 5 fingers, but only
  *					reports 2.
+ * 2	0x01	uniform clickpad	whole clickpad moves instead of being
+ *					hinged at the top.
  * 2	0x20	report min		query 0x0f gives min coord reported
- * 2	0x80	forcepad		forcepad is a variant of clickpad that
- *					does not have physical buttons but rather
- *					uses pressure above certain threshold to
- *					report primary clicks. Forcepads also have
- *					clickpad bit set.
  */
 #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
 #define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
@@ -91,7 +88,6 @@
 #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
 #define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & 0x000400)
 #define SYN_CAP_IMAGE_SENSOR(ex0c)	((ex0c) & 0x000800)
-#define SYN_CAP_FORCEPAD(ex0c)		((ex0c) & 0x008000)
 
 /* synaptics modes query bits */
 #define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
