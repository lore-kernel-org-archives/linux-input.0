From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] synaptics: fix rmi4 bus dependencies
Date: Tue, 9 Jan 2018 14:19:33 -0800
Message-ID: <20180109221933.nexohjl75g4uu2nl@dtor-ws>
References: <20180102191609.21460-1-mcroce@redhat.com>
 <20180102192143.egooy4onto73qd3y@dtor-ws>
 <204b8c3f-ec33-4400-33ff-fe39e9ca5702@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42870 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeAIWTh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 Jan 2018 17:19:37 -0500
Received: by mail-pf0-f196.google.com with SMTP id d23so9577557pfe.9
        for <linux-input@vger.kernel.org>; Tue, 09 Jan 2018 14:19:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <204b8c3f-ec33-4400-33ff-fe39e9ca5702@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Matteo Croce <mcroce@redhat.com>, linux-input@vger.kernel.org

On Tue, Jan 02, 2018 at 11:37:07AM -0800, Andrew Duggan wrote:
> On 01/02/2018 11:21 AM, Dmitry Torokhov wrote:
> > On Tue, Jan 02, 2018 at 08:16:09PM +0100, Matteo Croce wrote:
> > > Make MOUSE_PS2_SYNAPTICS_SMBUS select MOUSE_PS2_SYNAPTICS because if
> > > the latter is disabled the detection and switching code isn't being run.
> > Hmm, it should. In synaptics.c:
> > 
> > #if defined(CONFIG_MOUSE_PS2_SYNAPTICS) || \
> >      defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)
> > 
> > int synaptics_init(struct psmouse *psmouse)
> > {
> > 	struct synaptics_device_info info;
> > 	int error;
> > 	int retval;
> > 
> > 	psmouse_reset(psmouse);
> > ...
> > }
> > 
> > The intent was to allow disabling the PS/2 portion of Synaptics driver
> > while retaining the switching to SMbus capability.
> 
> Oh, I suggested to Matteo that this patch might be needed off list. I
> clearly didn't look closely enough to see that MOUSE_PS2_SYNAPTICS_SMBUS is
> intended to be able to be used independently of MOUSE_PS2_SYNAPTICS.
> 
> However, he did seem to see behavior where the mode switch did not occur
> when MOUSE_PS2_SYNAPTICS was disabled, but MOUSE_PS2_SYNAPTICS_SMBUS was
> enabled. That will need to be investigated further.

OK, I see what the problem is. Could you please try the version below?

Thanks.

-- 
Dmitry


Input: psmouse - fix Synaptics detection when protocol is disabled

When Synaptics protocol is disabled, we still need to ytry and detect the
hardware, so we can switch to SMBus device if SMbus is detected, or we know
that it is Synaptics device and reset it properly for the bare PS/2
protocol.

Fixes: c378b5119eb0 ("Input: psmouse - factor out common protocol probing code")
Reported-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index f3eb407a3b7d..cbe12671f784 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -984,6 +984,21 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 	psmouse->pt_deactivate = NULL;
 }
 
+static bool psmouse_do_detect(int (*detect)(struct psmouse *, bool),
+			      struct psmouse *psmouse, bool allow_passthrough,
+			      bool set_properties)
+{
+	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
+	    !allow_passthrough) {
+		return false;
+	}
+
+	if (set_properties)
+		psmouse_apply_defaults(psmouse);
+
+	return detect(psmouse, set_properties) == 0;
+}
+
 static bool psmouse_try_protocol(struct psmouse *psmouse,
 				 enum psmouse_type type,
 				 unsigned int *max_proto,
@@ -995,15 +1010,8 @@ static bool psmouse_try_protocol(struct psmouse *psmouse,
 	if (!proto)
 		return false;
 
-	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
-	    !proto->try_passthru) {
-		return false;
-	}
-
-	if (set_properties)
-		psmouse_apply_defaults(psmouse);
-
-	if (proto->detect(psmouse, set_properties) != 0)
+	if (!psmouse_do_detect(proto->detect, psmouse, proto->try_passthru,
+			       set_properties))
 		return false;
 
 	if (set_properties && proto->init && init_allowed) {
@@ -1036,8 +1044,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * Always check for focaltech, this is safe as it uses pnp-id
 	 * matching.
 	 */
-	if (psmouse_try_protocol(psmouse, PSMOUSE_FOCALTECH,
-				 &max_proto, set_properties, false)) {
+	if (psmouse_do_detect(focaltech_detect,
+			      psmouse, false, set_properties)) {
 		if (max_proto > PSMOUSE_IMEX &&
 		    IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
 		    (!set_properties || focaltech_init(psmouse) == 0)) {
@@ -1083,8 +1091,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * probing for IntelliMouse.
 	 */
 	if (max_proto > PSMOUSE_PS2 &&
-	    psmouse_try_protocol(psmouse, PSMOUSE_SYNAPTICS, &max_proto,
-				 set_properties, false)) {
+	    psmouse_do_detect(synaptics_detect,
+			      psmouse, false, set_properties)) {
 		synaptics_hardware = true;
 
 		if (max_proto > PSMOUSE_IMEX) {
