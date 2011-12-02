From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bug: touchpad unresponsive after resume from S3 (psmouse driver)
Date: Thu, 1 Dec 2011 22:16:23 -0800
Message-ID: <20111202061623.GA9688@core.coreip.homeip.net>
References: <4ED507AB.6040905@canonical.com>
 <20111129175333.GE4241@core.coreip.homeip.net>
 <4ED535E7.5030108@canonical.com>
 <20111130001748.GA2270@core.coreip.homeip.net>
 <4ED64932.90407@canonical.com>
 <20111201051534.GB16816@core.coreip.homeip.net>
 <4ED7E60F.7020306@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48986 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab1LBGQ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2011 01:16:29 -0500
Received: by ywa9 with SMTP id 9so2529860ywa.19
        for <linux-input@vger.kernel.org>; Thu, 01 Dec 2011 22:16:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4ED7E60F.7020306@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Manrique <daniel.manrique@canonical.com>
Cc: linux-input@vger.kernel.org

On Thu, Dec 01, 2011 at 03:39:43PM -0500, Daniel Manrique wrote:
> 
> The ssleep(1); line is what appears to do the trick; the version that just
> queries the ID exhibits the same problem I reported initially, while the one
> that just ssleeps works fine, with the touchpad working OK after resuming.
> 
> I'll await further instructions on this, thanks so much for your help!
> 

OK, great. Could you please try the patch below to make sure it works as
intended and I'll queue it to upstream/stable?

Thanks.

-- 
Dmitry

Input: synaptics - fix touchpad not working after S2R on Vostro V13

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Synaptics touchpads on several Dell laptops, particularly Vostro V13
systems, may not respond properly to PS/2 commands and queries immediately
after resuming from suspend to RAM. This leads to unresponsive touchpad
after suspend/resume cycle.

Adding a 1-second delay after resetting the device allows touchpad to
finish initializing (calibrating?) and start reacting properly.

Reported-by: Daniel Manrique <daniel.manrique@canonical.com>
Tested-by: Daniel Manrique <daniel.manrique@canonical.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)


diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 06c9ee5..8081a0a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input/mt.h>
 #include <linux/serio.h>
@@ -1288,6 +1289,16 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 
 	do {
 		psmouse_reset(psmouse);
+		if (retry) {
+			/*
+			 * On some boxes, right after resuming, the touchpad
+			 * needs some time to finish initializing (I assume
+			 * it needs time to calibrate) and start responding
+			 * to Synaptics-specific queries, so let's wait a
+			 * bit.
+			 */
+			ssleep(1);
+		}
 		error = synaptics_detect(psmouse, 0);
 	} while (error && ++retry < 3);
 
