From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Wed, 29 Sep 2010 23:25:48 -0700
Message-ID: <20100930062547.GF5260@core.coreip.homeip.net>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
 <AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45968 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab0I3GZz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Sep 2010 02:25:55 -0400
Received: by iwn5 with SMTP id 5so2028274iwn.19
        for <linux-input@vger.kernel.org>; Wed, 29 Sep 2010 23:25:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov wrote:
> On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
> > PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
> > into one serial data stream. It's used e.g. on TQM85xx serie of boards.
> >
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > ---
> >
> > It actually depends on "serio: multiple children" patch. I'm not resending it
> > as you were the originator of the latest version of the patch.
> 
> So, what about this version of patch?
> 

Looks better but I think you also need ->start() to make sure you do not
try to deliver events too early. Does the following still work for you?

Thanks.

-- 
Dmitry

Input: ps2mutl - assorted changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/ps2mult.c |  261 +++++++++++++++++++++++------------------
 1 files changed, 146 insertions(+), 115 deletions(-)


diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
index bd45e76..3664398 100644
--- a/drivers/input/serio/ps2mult.c
+++ b/drivers/input/serio/ps2mult.c
@@ -31,25 +31,27 @@ struct ps2mult_port {
 };
 
 #define PS2MULT_NUM_PORTS	2
+#define PS2MULT_KBD_PORT	0
+#define PS2MULT_MOUSE_PORT	1
 
 struct ps2mult {
-	struct serio *serio;
+	struct serio *mx_serio;
 	struct ps2mult_port ports[PS2MULT_NUM_PORTS];
 
 	spinlock_t lock;
-	struct serio *in_serio;
-	struct serio *out_serio;
+	struct ps2mult_port *in_port;
+	struct ps2mult_port *out_port;
 	bool escape;
 };
 
-/* First MUST com PS2MULT_NUM_PORTS selectors */
-static unsigned char ps2mult_controls[] = {
+/* First MUST come PS2MULT_NUM_PORTS selectors */
+static const unsigned char ps2mult_controls[] = {
 	PS2MULT_KB_SELECTOR, PS2MULT_MS_SELECTOR,
 	PS2MULT_ESCAPE, PS2MULT_BSYNC,
 	PS2MULT_SESSION_START, PS2MULT_SESSION_END,
 };
 
-static struct serio_device_id ps2mult_serio_ids[] = {
+static const struct serio_device_id ps2mult_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_PS2MULT,
@@ -61,113 +63,112 @@ static struct serio_device_id ps2mult_serio_ids[] = {
 
 MODULE_DEVICE_TABLE(serio, ps2mult_serio_ids);
 
-static int ps2mult_serio_write(struct serio *serio, unsigned char data)
+static void ps2mult_select_port(struct ps2mult *psm, struct ps2mult_port *port)
+{
+	struct serio *mx_serio = psm->mx_serio;
+
+	serio_write(mx_serio, port->sel);
+	psm->out_port = port;
+	dev_dbg(&mx_serio->dev, "switched to sel %02x\n", port->sel);
+}
 
+static int ps2mult_serio_write(struct serio *serio, unsigned char data)
 {
-	struct ps2mult *psm = serio_get_drvdata(serio->parent);
-	struct ps2mult_port *psmp = serio->port_data;
+	struct serio *mx_port = serio->parent;
+	struct ps2mult *psm = serio_get_drvdata(mx_port);
+	struct ps2mult_port *port = serio->port_data;
 	bool need_escape;
 	unsigned long flags;
 
 	spin_lock_irqsave(&psm->lock, flags);
-	if (psm->out_serio != serio) {
-		psm->serio->write(psm->serio, psmp->sel);
-		psm->out_serio = serio;
-		dev_dbg(&serio->dev, "switched to sel %02x\n", psmp->sel);
-	}
+
+	if (psm->out_port != port)
+		ps2mult_select_port(psm, port);
 
 	need_escape = memchr(ps2mult_controls, data, sizeof(ps2mult_controls));
 
-	dev_dbg(&serio->dev, "write: %s%02x\n",
-			need_escape ? "ESC " : "", data);
+	dev_dbg(&serio->dev,
+		"write: %s%02x\n", need_escape ? "ESC " : "", data);
 
 	if (need_escape)
-		psm->serio->write(psm->serio, PS2MULT_ESCAPE);
-	psm->serio->write(psm->serio, data);
+		serio_write(mx_port, PS2MULT_ESCAPE);
+
+	serio_write(mx_port, data);
 
 	spin_unlock_irqrestore(&psm->lock, flags);
 
 	return 0;
 }
 
-static void ps2mult_serio_stop(struct serio *serio)
+static int ps2mult_serio_start(struct serio *serio)
 {
 	struct ps2mult *psm = serio_get_drvdata(serio->parent);
-	struct ps2mult_port *psmp = serio->port_data;
-
+	struct ps2mult_port *port = serio->port_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&psm->lock, flags);
+	port->serio = serio;
+	spin_unlock_irqrestore(&psm->lock, flags);
 
-	psmp->serio = NULL;
-	if (psm->in_serio == serio)
-		psm->in_serio = NULL;
-	if (psm->out_serio == serio)
-		psm->out_serio = NULL;
+	return 0;
+}
 
-	spin_unlock_irqrestore(&psm->lock, flags);
+static void ps2mult_serio_stop(struct serio *serio)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio->parent);
+	struct ps2mult_port *port = serio->port_data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&psm->lock, flags);
+	port->serio = NULL;
+	spin_unlock_irqrestore(&psm->lock, flags);
 }
 
 static int ps2mult_create_port(struct ps2mult *psm, int i)
 {
-	struct serio *serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	struct serio *mx_serio = psm->mx_serio;
+	struct serio *serio;
+
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
 	strlcpy(serio->name, "TQC PS/2 Multiplexer", sizeof(serio->name));
 	snprintf(serio->phys, sizeof(serio->phys),
-			"%s/port%d", psm->serio->phys, i);
+		 "%s/port%d", mx_serio->phys, i);
 	serio->id.type = SERIO_8042;
 	serio->id.proto = SERIO_PS2MULT;
 	serio->write = ps2mult_serio_write;
+	serio->start = ps2mult_serio_start;
 	serio->stop = ps2mult_serio_stop;
-	serio->parent = psm->serio;
-
+	serio->parent = psm->mx_serio;
 	serio->port_data = &psm->ports[i];
 
-	psm->ports[i].serio = serio;
-	psm->ports[i].sel = ps2mult_controls[i];
-
 	serio_register_port(serio);
-	dev_info(&serio->dev, "%s port at %s\n", serio->name, psm->serio->phys);
+	dev_info(&serio->dev, "%s port at %s\n", serio->name, mx_serio->phys);
 
 	return 0;
 }
 
-static int ps2mult_reconnect(struct serio *serio)
+static void ps2mult_reset(struct ps2mult *psm)
 {
-	struct ps2mult *psm = serio_get_drvdata(serio);
 	unsigned long flags;
 
-	serio->write(serio, PS2MULT_SESSION_END);
-	serio->write(serio, PS2MULT_SESSION_START);
-
 	spin_lock_irqsave(&psm->lock, flags);
-	psm->out_serio = psm->ports[0].serio;
-	serio->write(serio, psm->ports[0].sel);
-	spin_unlock_irqrestore(&psm->lock, flags);
-
-	return 0;
-}
-
-static void ps2mult_disconnect(struct serio *serio)
-{
-	struct ps2mult *psm = serio_get_drvdata(serio);
 
-	serio->write(serio, PS2MULT_SESSION_END);
+	serio_write(psm->mx_serio, PS2MULT_SESSION_END);
+	serio_write(psm->mx_serio, PS2MULT_SESSION_START);
 
-	serio_close(serio);
-	serio_set_drvdata(serio, NULL);
+	ps2mult_select_port(psm, &psm->ports[PS2MULT_KBD_PORT]);
 
-	kfree(psm);
+	spin_unlock_irqrestore(&psm->lock, flags);
 }
 
 static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct ps2mult *psm;
 	int i;
-	int rc;
+	int error;
 
 	if (!serio->write)
 		return -EINVAL;
@@ -177,83 +178,113 @@ static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
 		return -ENOMEM;
 
 	spin_lock_init(&psm->lock);
-	psm->serio = serio;
+	psm->mx_serio = serio;
 
-	serio_set_drvdata(serio, psm);
-
-	for (i = 0; i <  PS2MULT_NUM_PORTS; i++) {
-		rc = ps2mult_create_port(psm, i);
-		if (rc)
+	for (i = 0; i < PS2MULT_NUM_PORTS; i++) {
+		psm->ports[i].sel = ps2mult_controls[i];
+		error = ps2mult_create_port(psm, i);
+		if (error)
 			goto err_out;
 	}
 
-	serio_open(serio, drv);
+	psm->in_port = psm->out_port = &psm->ports[PS2MULT_KBD_PORT];
 
-	rc = ps2mult_reconnect(serio);
-	if (rc)
+	serio_set_drvdata(serio, psm);
+	error = serio_open(serio, drv);
+	if (error)
 		goto err_out;
 
+	ps2mult_reset(psm);
+
+	for (i = 0; i <  PS2MULT_NUM_PORTS; i++)
+		serio_register_port(psm->ports[i].serio);
+
 	return 0;
 
 err_out:
-	ps2mult_disconnect(serio);
+	while (--i >= 0)
+		kfree(psm->ports[i].serio);
+	kfree(serio);
+	return error;
+}
+
+static void ps2mult_disconnect(struct serio *serio)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio);
+
+	/* Note that serio core already take care of children ports */
+	serio_write(serio, PS2MULT_SESSION_END);
+	serio_close(serio);
+	kfree(psm);
 
-	return rc;
+	serio_set_drvdata(serio, NULL);
+}
+
+static int ps2mult_reconnect(struct serio *serio)
+{
+	struct ps2mult *psm = serio_get_drvdata(serio);
+
+	ps2mult_reset(psm);
+
+	return 0;
 }
 
-static irqreturn_t ps2mult_interrupt(struct serio *serio, unsigned char data,
-		unsigned int flags)
+static irqreturn_t ps2mult_interrupt(struct serio *serio,
+				     unsigned char data, unsigned int dfl)
 {
 	struct ps2mult *psm = serio_get_drvdata(serio);
+	struct ps2mult_port *in_port;
+	unsigned long flags;
+
+	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, dfl);
+
+	spin_lock_irqsave(&psm->lock, flags);
 
-	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, flags);
 	if (psm->escape) {
-		spin_lock(&psm->lock);
-		if (psm->in_serio)
-			serio_interrupt(psm->in_serio, data, flags);
-		spin_unlock(&psm->lock);
-
-		psm->escape = 0;
-	} else
-		switch (data) {
-		case PS2MULT_ESCAPE:
-			dev_dbg(&serio->dev, "ESCAPE\n");
-			psm->escape = 1;
-			break;
-		case PS2MULT_BSYNC:
-			dev_dbg(&serio->dev, "BSYNC\n");
-			spin_lock(&psm->lock);
-			psm->in_serio = psm->out_serio;
-			spin_unlock(&psm->lock);
-			break;
-		case PS2MULT_SESSION_START:
-			dev_dbg(&serio->dev, "SS\n");
-			break;
-		case PS2MULT_SESSION_END:
-			dev_dbg(&serio->dev, "SE\n");
-			break;
-		case PS2MULT_KB_SELECTOR:
-			dev_dbg(&serio->dev, "KB\n");
-
-			spin_lock(&psm->lock);
-			psm->in_serio = psm->ports[0].serio;
-			spin_unlock(&psm->lock);
-
-			break;
-		case PS2MULT_MS_SELECTOR:
-			dev_dbg(&serio->dev, "MS\n");
-
-			spin_lock(&psm->lock);
-			psm->in_serio = psm->ports[1].serio;
-			spin_unlock(&psm->lock);
-
-			break;
-		default:
-			spin_lock(&psm->lock);
-			if (psm->in_serio)
-				serio_interrupt(psm->in_serio, data, flags);
-			spin_unlock(&psm->lock);
-		}
+		psm->escape = false;
+		in_port = psm->in_port;
+		if (in_port->serio)
+			serio_interrupt(in_port->serio, data, dfl);
+		goto out;
+	}
+
+	switch (data) {
+	case PS2MULT_ESCAPE:
+		dev_dbg(&serio->dev, "ESCAPE\n");
+		psm->escape = true;
+		break;
+
+	case PS2MULT_BSYNC:
+		dev_dbg(&serio->dev, "BSYNC\n");
+		psm->in_port = psm->out_port;
+		break;
+
+	case PS2MULT_SESSION_START:
+		dev_dbg(&serio->dev, "SS\n");
+		break;
+
+	case PS2MULT_SESSION_END:
+		dev_dbg(&serio->dev, "SE\n");
+		break;
+
+	case PS2MULT_KB_SELECTOR:
+		dev_dbg(&serio->dev, "KB\n");
+		psm->in_port = &psm->ports[PS2MULT_KBD_PORT];
+		break;
+
+	case PS2MULT_MS_SELECTOR:
+		dev_dbg(&serio->dev, "MS\n");
+		psm->in_port = &psm->ports[PS2MULT_MOUSE_PORT];
+		break;
+
+	default:
+		in_port = psm->in_port;
+		if (in_port->serio)
+			serio_interrupt(in_port->serio, data, dfl);
+	}
+
+ out:
+	spin_unlock_irqrestore(&psm->lock, flags);
 	return IRQ_HANDLED;
 }
 
