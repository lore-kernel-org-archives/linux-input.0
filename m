From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port should      psmouse_probe   fail before
 retrying
Date: Tue, 11 May 2010 01:22:18 -0700
Message-ID: <20100511082218.GB10404@core.coreip.homeip.net>
References: <1271723857.6652.6.camel@lovely>
 <20100422215517.GB28213@core.coreip.homeip.net>
 <1271983668.16254.44.camel@lovely>
 <201004230953.52447.dmitry.torokhov@gmail.com>
 <1272072125.4341.10.camel@lovely>
 <1272103233.4666.15.camel@lovely>
 <20100428072633.GC4232@core.coreip.homeip.net>
 <1273335729.7427.17.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64670 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab0EKIWY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 04:22:24 -0400
Received: by pxi5 with SMTP id 5so2089047pxi.19
        for <linux-input@vger.kernel.org>; Tue, 11 May 2010 01:22:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1273335729.7427.17.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

On Sat, May 08, 2010 at 06:22:09PM +0200, Christoph Fritz wrote:
> On Wed, 2010-04-28 at 00:26 -0700, Dmitry Torokhov wrote:
> 
> > What about simply resetting the mouse before actually trying to
> > reconnect?
> 
> Isn't psmouse_reconnect() the first in psmouse-base.c that gets called
> after waking up from hibernation/suspend?
> And should all ps2 devices get a reset or only the one which needs it
> (synaptic touchpads not handled by synaptics driver)?
> 

I think we should reset all devcices that do not provide reconnect
method (this includes Synaptics hardware in bare PS/2 mode). Something
like below.

-- 
Dmitry

Input: psmouse - reset all types of mice before reconnecting

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Synaptics hardware requires resetting device after suspend to ram
in order for the device to be operational. The reset lives in
synaptics-specific reconnect handler, but it is not being invoked
if synaptics support is disabled and the device is handled as a
standard PS/2 device (bare or IntelliMouse protocol).

Let's add reset into generic reconnect handler as well.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)


diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index cbc8072..a3c9731 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1394,6 +1394,7 @@ static int psmouse_reconnect(struct serio *serio)
 	struct psmouse *psmouse = serio_get_drvdata(serio);
 	struct psmouse *parent = NULL;
 	struct serio_driver *drv = serio->drv;
+	unsigned char type;
 	int rc = -1;
 
 	if (!drv || !psmouse) {
@@ -1413,10 +1414,15 @@ static int psmouse_reconnect(struct serio *serio)
 	if (psmouse->reconnect) {
 		if (psmouse->reconnect(psmouse))
 			goto out;
-	} else if (psmouse_probe(psmouse) < 0 ||
-		   psmouse->type != psmouse_extensions(psmouse,
-						psmouse_max_proto, false)) {
-		goto out;
+	} else {
+		psmouse_reset(psmouse);
+
+		if (psmouse_probe(psmouse) < 0)
+			goto out;
+
+		type = psmouse_extensions(psmouse, psmouse_max_proto, false);
+		if (psmouse->type != type)
+			goto out;
 	}
 
 	/* ok, the device type (and capabilities) match the old one,

