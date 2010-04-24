From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port should      psmouse_probe   fail   
	before  retrying
Date: Sat, 24 Apr 2010 12:00:33 +0200
Message-ID: <1272103233.4666.15.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <20100422215517.GB28213@core.coreip.homeip.net>
	 <1271983668.16254.44.camel@lovely>
	 <201004230953.52447.dmitry.torokhov@gmail.com>
	 <1272072125.4341.10.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:17694 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0DXJy6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 05:54:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so718876fgg.1
        for <linux-input@vger.kernel.org>; Sat, 24 Apr 2010 02:54:56 -0700 (PDT)
In-Reply-To: <1272072125.4341.10.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

On Sat, 2010-04-24 at 03:22 +0200, Christoph Fritz wrote:
> On Fri, 2010-04-23 at 09:53 -0700, Dmitry Torokhov wrote:
> > On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:
> 
> > > in conclusion:
> > >  If a Synaptics touchpad can't be initialized (synaptics_init) and falls
> > > back to PS/2, it doesn't get a psmouse_reset() after resuming from
> > > suspend as it would get with a synaptics driver.
> > 
> > Yes, you are right. Maybe we should just reset psmouse unconditionally in 
> > psmouse_reconnect() before actually doing any protocol reconnect/reprobe. That 
> > should help in cases when users not enable Synaptics support; also it is 
> > probably unlikely that mouse that was there gets unplugged after resume.
> 
> Yes, this would solve that case too. 

I have to correct myself.
 The case is already achieved with the patch I sent:
synaptics_detect() detects presence of synaptics_hardware even if the user
does not enable CONFIG_MOUSE_PS2_SYNAPTICS.

Just for a better overview in this thread, here it is:


---
If a Synaptics touchpad can't be initialized (synaptics_init) and falls
back to PS/2, it doesn't get a psmouse_reset() after resuming from
suspend as it would get with a synaptics driver.
 So check state of synaptics_hardware and reset this beast.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/mouse/psmouse-base.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index d8c0c8d..66ce0ac 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -116,6 +116,9 @@ struct psmouse_protocol {
 	int (*init)(struct psmouse *);
 };
 
+/* to handle some reset quirks */
+static bool synaptics_hardware = false;
+
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
  * relevant events to the input module once full packet has arrived.
@@ -597,7 +600,6 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
 static int psmouse_extensions(struct psmouse *psmouse,
 			      unsigned int max_proto, bool set_properties)
 {
-	bool synaptics_hardware = false;
 
 /*
  * We always check for lifebook because it does not disturb mouse
@@ -1401,10 +1403,14 @@ static int psmouse_reconnect(struct serio *serio)
 	if (psmouse->reconnect) {
 		if (psmouse->reconnect(psmouse))
 			goto out;
-	} else if (psmouse_probe(psmouse) < 0 ||
+	} else {
+		if (synaptics_hardware)		/* is using plain PS/2 */
+			psmouse_reset(psmouse);
+		if (psmouse_probe(psmouse) < 0 ||
 		   psmouse->type != psmouse_extensions(psmouse,
 						psmouse_max_proto, false)) {
-		goto out;
+			goto out;
+		}
 	}
 
 	/* ok, the device type (and capabilities) match the old one,
-- 
1.5.6.5



