From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Sun, 21 Jun 2009 17:10:50 -0700
Message-ID: <200906211710.50537.david-b@pacbell.net>
References: <200901171315.08019.david-b@pacbell.net> <200904202319.02590.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:48593 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754279AbZFVAR2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Jun 2009 20:17:28 -0400
In-Reply-To: <200904202319.02590.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Dmitry Torokhov <dtor@mail.ru>

On Monday 20 April 2009, David Brownell wrote:
> On Saturday 17 January 2009, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > Subject: input: =A0dm355evm_keys driver
> > =A0 =A0=20
>=20
> PING?? =A0I was told this was in the input queue, but it does
> not seem to be in
>=20
> =A0 http://git.kernel.org/?p=3Dlinux/kernel/git/dtor/input.git
>=20
> Current version of the patch is appended.
>=20
> - Dave
>=20

Hmm, still no response.  What's up, input team??

Appended is a minor tweak to this code.  I'm going to resend
the patch again.  Maybe one day, soon, I can take it out of
my list of patches-due-to-hit-mainline ...

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
=46rom: David Brownell <dbrownell@users.sourceforge.net>

Convert the dm355evm keys driver to use IRQ threading instead
of a private workqueue ... that mechanism was added to Linux
after the driver was first written.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/keyboard/dm355evm_keys.c |   38 ++++++++++++++----------=
-------
 1 file changed, 18 insertions(+), 20 deletions(-)

--- a/drivers/input/keyboard/dm355evm_keys.c
+++ b/drivers/input/keyboard/dm355evm_keys.c
@@ -23,30 +23,16 @@
  * pressed, or its autorepeat kicks in, an event is sent.  This driver
  * read those events from the small (32 event) queue and reports them.
  *
- * Because we communicate with the MSP430 using I2C, and all I2C calls
- * in Linux sleep, we need to cons up a kind of threaded IRQ handler
- * using a work_struct.  The IRQ is active low, but we use it through
- * the GPIO controller so we can trigger on falling edges.
- *
  * Note that physically there can only be one of these devices.
  *
  * This driver was tested with firmware revision A4.
  */
 struct dm355evm_keys {
-	struct work_struct	work;
 	struct input_dev	*input;
 	struct device		*dev;
 	int			irq;
 };
=20
-static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
-{
-	struct dm355evm_keys	*keys =3D _keys;
-
-	schedule_work(&keys->work);
-	return IRQ_HANDLED;
-}
-
 /* These initial keycodes can be remapped by dm355evm_setkeycode(). */
 static struct {
 	u16	event;
@@ -110,13 +96,12 @@ static struct {
 	{ 0x3169, KEY_PAUSE, },
 };
=20
-static void dm355evm_keys_work(struct work_struct *work)
+/* runs in an IRQ thread -- can (and will!) sleep */
+static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
 {
-	struct dm355evm_keys	*keys;
+	struct dm355evm_keys	*keys =3D _keys;
 	int			status;
=20
-	keys =3D container_of(work, struct dm355evm_keys, work);
-
 	/* For simplicity we ignore INPUT_COUNT and just read
 	 * events until we get the "queue empty" indicator.
 	 * Reading INPUT_LOW decrements the count.
@@ -184,6 +169,19 @@ static void dm355evm_keys_work(struct wo
 		input_report_key(keys->input, keycode, 0);
 		input_sync(keys->input);
 	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Because we communicate with the MSP430 using I2C, and all I2C calls
+ * in Linux sleep, we use a threaded IRQ handler.  The IRQ itself is
+ * active low, but we go through the GPIO controller so we can trigger
+ * on falling edges and not worry about enabling/disabling the IRQ in
+ * the keypress handling path.
+ */
+static irqreturn_t dm355evm_keys_hardirq(int irq, void *_keys)
+{
+	return IRQ_WAKE_THREAD;
 }
=20
 static int dm355evm_setkeycode(struct input_dev *dev, int index, int k=
eycode)
@@ -259,7 +257,6 @@ static int __devinit dm355evm_keys_probe
 	if (status < 0)
 		goto fail1;
 	keys->irq =3D status;
-	INIT_WORK(&keys->work, dm355evm_keys_work);
=20
 	/* REVISIT:  flush the event queue? */
=20
@@ -269,7 +266,8 @@ static int __devinit dm355evm_keys_probe
 		goto fail0;
=20
 	/* start reporting events */
-	status =3D request_irq(keys->irq, dm355evm_keys_irq,
+	status =3D request_threaded_irq(keys->irq,
+			dm355evm_keys_hardirq, dm355evm_keys_irq,
 			IRQF_TRIGGER_FALLING,
 			dev_name(&pdev->dev), keys);
 	if (status < 0) {


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
