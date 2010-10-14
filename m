From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Thu, 14 Oct 2010 07:23:47 -0700
Message-ID: <20101014142347.GA18011@core.coreip.homeip.net>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
 <AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
 <20100930062547.GF5260@core.coreip.homeip.net>
 <AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
 <20101007163606.GA24406@core.coreip.homeip.net>
 <AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46823 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab0JNOYM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 10:24:12 -0400
Received: by iwn35 with SMTP id 35so34240iwn.19
        for <linux-input@vger.kernel.org>; Thu, 14 Oct 2010 07:24:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 08, 2010 at 12:50:34PM +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> On Thu, Oct 7, 2010 at 8:36 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Oct 07, 2010 at 07:19:57PM +0400, Dmitry Eremin-Solenikov wrote:
> >> Hello,
> >>
> >> On Thu, Sep 30, 2010 at 10:25 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov wrote:
> >> >> On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
> >> >> <dbaryshkov@gmail.com> wrote:
> >> >> > PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
> >> >> > into one serial data stream. It's used e.g. on TQM85xx serie of boards.
> >> >> >
> >> >> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> >> > ---
> >> >> >
> >> >> > It actually depends on "serio: multiple children" patch. I'm not resending it
> >> >> > as you were the originator of the latest version of the patch.
> >> >>
> >> >> So, what about this version of patch?
> >> >>
> >> >
> >> > Looks better but I think you also need ->start() to make sure you do not
> >> > try to deliver events too early. Does the following still work for you?
> >>
> >> Sorry for the delay. Crashes w/o the attached patch.
> >>
> >
> > Ah, I see, however what I actually wanted is to create ports before hand
> > and handle any errors that might arise and then enable the device and
> > register child ports.
> >
> > If you apply the patch below instead of yours does it still work?
> 
> It won't work, as we don't set psm->ports[i].serio before ps2mult_serio_start()
> 

Indeed. I guess we need to set the pointer immediately then and also add
a flag to the port structure telling whether it has been registered.
Does the following work for you by any chance?

Thanks.

-- 
Dmitry

Input: ps2mult - don't register ports twice

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/ps2mult.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)


diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
index 3664398..ec8f8c1 100644
--- a/drivers/input/serio/ps2mult.c
+++ b/drivers/input/serio/ps2mult.c
@@ -28,6 +28,7 @@ MODULE_LICENSE("GPL");
 struct ps2mult_port {
 	struct serio *serio;
 	unsigned char sel;
+	bool registered;
 };
 
 #define PS2MULT_NUM_PORTS	2
@@ -107,7 +108,7 @@ static int ps2mult_serio_start(struct serio *serio)
 	unsigned long flags;
 
 	spin_lock_irqsave(&psm->lock, flags);
-	port->serio = serio;
+	port->registered = true;
 	spin_unlock_irqrestore(&psm->lock, flags);
 
 	return 0;
@@ -120,7 +121,7 @@ static void ps2mult_serio_stop(struct serio *serio)
 	unsigned long flags;
 
 	spin_lock_irqsave(&psm->lock, flags);
-	port->serio = NULL;
+	port->registered = false;
 	spin_unlock_irqrestore(&psm->lock, flags);
 }
 
@@ -144,8 +145,7 @@ static int ps2mult_create_port(struct ps2mult *psm, int i)
 	serio->parent = psm->mx_serio;
 	serio->port_data = &psm->ports[i];
 
-	serio_register_port(serio);
-	dev_info(&serio->dev, "%s port at %s\n", serio->name, mx_serio->phys);
+	psm->ports[i].serio = serio;
 
 	return 0;
 }
@@ -196,8 +196,12 @@ static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
 
 	ps2mult_reset(psm);
 
-	for (i = 0; i <  PS2MULT_NUM_PORTS; i++)
-		serio_register_port(psm->ports[i].serio);
+	for (i = 0; i <  PS2MULT_NUM_PORTS; i++) {
+		struct serio *s = psm->ports[i].serio;
+
+		dev_info(&serio->dev, "%s port at %s\n", s->name, serio->phys);
+		serio_register_port(s);
+	}
 
 	return 0;
 
@@ -243,7 +247,7 @@ static irqreturn_t ps2mult_interrupt(struct serio *serio,
 	if (psm->escape) {
 		psm->escape = false;
 		in_port = psm->in_port;
-		if (in_port->serio)
+		if (in_port->registered)
 			serio_interrupt(in_port->serio, data, dfl);
 		goto out;
 	}
@@ -279,8 +283,9 @@ static irqreturn_t ps2mult_interrupt(struct serio *serio,
 
 	default:
 		in_port = psm->in_port;
-		if (in_port->serio)
+		if (in_port->registered)
 			serio_interrupt(in_port->serio, data, dfl);
+		break;
 	}
 
  out:
