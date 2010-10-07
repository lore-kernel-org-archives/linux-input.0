From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Thu, 7 Oct 2010 09:36:06 -0700
Message-ID: <20101007163606.GA24406@core.coreip.homeip.net>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
 <AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
 <20100930062547.GF5260@core.coreip.homeip.net>
 <AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62787 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0JGQgP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Oct 2010 12:36:15 -0400
Received: by pwj5 with SMTP id 5so13308pwj.19
        for <linux-input@vger.kernel.org>; Thu, 07 Oct 2010 09:36:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 07, 2010 at 07:19:57PM +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> On Thu, Sep 30, 2010 at 10:25 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov wrote:
> >> On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
> >> <dbaryshkov@gmail.com> wrote:
> >> > PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
> >> > into one serial data stream. It's used e.g. on TQM85xx serie of boards.
> >> >
> >> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> > ---
> >> >
> >> > It actually depends on "serio: multiple children" patch. I'm not resending it
> >> > as you were the originator of the latest version of the patch.
> >>
> >> So, what about this version of patch?
> >>
> >
> > Looks better but I think you also need ->start() to make sure you do not
> > try to deliver events too early. Does the following still work for you?
> 
> Sorry for the delay. Crashes w/o the attached patch.
> 

Ah, I see, however what I actually wanted is to create ports before hand
and handle any errors that might arise and then enable the device and
register child ports.

If you apply the patch below instead of yours does it still work?

Thanks.

-- 
Dmitry

Input: ps2mult - don't register ports twice

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/ps2mult.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)


diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
index 3664398..52b58de 100644
--- a/drivers/input/serio/ps2mult.c
+++ b/drivers/input/serio/ps2mult.c
@@ -144,9 +144,6 @@ static int ps2mult_create_port(struct ps2mult *psm, int i)
 	serio->parent = psm->mx_serio;
 	serio->port_data = &psm->ports[i];
 
-	serio_register_port(serio);
-	dev_info(&serio->dev, "%s port at %s\n", serio->name, mx_serio->phys);
-
 	return 0;
 }
 
@@ -196,8 +193,12 @@ static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
 
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
 
