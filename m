From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: q40kbd - convert driver to the split model
Date: Wed, 18 Jan 2012 01:25:48 -0800
Message-ID: <20120118092548.GD32285@core.coreip.homeip.net>
References: <20111231010814.7392.52389.stgit@hammer.corenet.prv>
 <CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com>
 <20120111081118.GC18668@core.coreip.homeip.net>
 <CAMuHMdXfs2ru7KG-xFRoKPso5Y+UuAnOOUie8HoOZHYyoVeyaA@mail.gmail.com>
 <20120111173051.GB21047@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50627 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab2ARJZz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 04:25:55 -0500
Received: by iagf6 with SMTP id f6so5711480iag.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jan 2012 01:25:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120111173051.GB21047@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org

On Wed, Jan 11, 2012 at 09:30:51AM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 11, 2012 at 10:25:20AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 11, 2012 at 09:11, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Wed, Jan 11, 2012 at 08:55:54AM +0100, Geert Uytterhoeven wrot=
e:
> > >> On Sat, Dec 31, 2011 at 02:11, Dmitry Torokhov
> > >> <dmitry.torokhov@gmail.com> wrote:
> >=20
> > >> > +static struct platform_device q40_kbd_pdev =3D {
> > >> > +       .name   =3D "q40kbd",
> > >> > + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> > >> > +};
> > >> > +
> > >> > +static __init int q40_add_kbd_device(void)
> > >> > +{
> > >> > + =A0 =A0 =A0 return platform_device_register(&q40_kbd_pdev);
> > >>
> > >> If you would use platform_device_register_simple(), you don't ne=
ed the
> > >> q40_kbd_pdev above, reducing memory consumption on non-Q40 platf=
orms.
> > >
> > > Isn't this file only compiled on q40 platforms?
> >=20
> > No, m68k does support multi-platform kernels.
>=20
> OK, I'll do dynamic platform device allocation.
>=20
> >=20
> > >> > +}
> > >> > +arch_initcall(q40_add_kbd_device);
> > >>
> > >> For the Amiga platform drivers, I used device_initcall().
> > >
> > > Won't it potentially race with initialization of q40kbd? It looks=
 like
> > > module_initcall is the same as device_initcall() when module is c=
ompiled
> > > in. Given that q40kbd uses platform_dveice_probe() losing race mi=
ght be
> > > fatal.
> >=20
> > So far I haven't encountered any problems on Amiga.
> > I'll look into this.
>=20
> I guess link order (arch before drivers) saves you here but it is not
> very clean.
>=20
> >
> > >> > -static int __devexit q40kbd_remove(struct platform_device *de=
v)
> > >> > +static int __devexit q40kbd_remove(struct platform_device *pd=
ev)
> > >> > =A0{
> > >> > - =A0 =A0 =A0 serio_unregister_port(q40kbd_port);
> > >> > + =A0 =A0 =A0 struct q40kbd *q40kbd =3D platform_get_drvdata(p=
dev);
> > >> > +
> > >> > + =A0 =A0 =A0 free_irq(Q40_IRQ_KEYBOARD, q40kbd);
> > >> > +
> > >> > + =A0 =A0 =A0 serio_unregister_port(q40kbd->port);
> > >>
> > >> Should the unregister be done before freeing the IRQ, i.e. rever=
se
> > >> order compared to probe?
> > >
> > > Unregister will most likely cause memory being freed; you don't w=
ant to
> > > chance IRQ firing here.
> >=20
> > And in the probe case that can't happen when request_irq() is calle=
d?
>=20
> We explicitly do q40kbd_stop() before requesting IRQ. Frankly serio
> will be stopped by the serio core (via serio->stop() which is
> q40kbd_stop()) so freeing IRQ fisrt should be fine, it just was looki=
ng
> scary. I'll revert the order and add a comment.
>=20

OK, so here it is.

--=20
Dmitry


Input: q40kbd - convert driver to the split model

=46rom: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Convert the driver to standard spilt model arch-specific code registers
platform device to which driver code can bind later.

Also request IRQ immediately upon binding to the device instead of doin=
g
this when serio port is being opened.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/m68k/q40/config.c       |    7 ++
 drivers/input/serio/q40kbd.c |  139 ++++++++++++++++++++++++----------=
--------
 2 files changed, 86 insertions(+), 60 deletions(-)


diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index ad10fec..c72a3ed 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -24,6 +24,7 @@
 #include <linux/rtc.h>
 #include <linux/vt_kern.h>
 #include <linux/bcd.h>
+#include <linux/platform_device.h>
=20
 #include <asm/io.h>
 #include <asm/rtc.h>
@@ -329,3 +330,9 @@ static int q40_set_rtc_pll(struct rtc_pll_info *pll=
)
 	} else
 		return -EINVAL;
 }
+
+static __init int q40_add_kbd_device(void)
+{
+	return platform_device_register_simple("q40kbd", -1, NULL, 0);
+}
+arch_initcall(q40_add_kbd_device);
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.=
c
index 5eb84b3..0c0df7f 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -44,26 +44,31 @@
 #include <asm/irq.h>
 #include <asm/q40ints.h>
=20
+#define DRV_NAME	"q40kbd"
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
=20
-static DEFINE_SPINLOCK(q40kbd_lock);
-static struct serio *q40kbd_port;
-static struct platform_device *q40kbd_device;
+struct q40kbd {
+	struct serio *port;
+	spinlock_t lock;
+};
=20
 static irqreturn_t q40kbd_interrupt(int irq, void *dev_id)
 {
+	struct q40kbd *q40kbd =3D dev_id;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&q40kbd_lock, flags);
+	spin_lock_irqsave(&q40kbd->lock, flags);
=20
 	if (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
-		serio_interrupt(q40kbd_port, master_inb(KEYCODE_REG), 0);
+		serio_interrupt(q40kbd->port, master_inb(KEYCODE_REG), 0);
=20
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
=20
-	spin_unlock_irqrestore(&q40kbd_lock, flags);
+	spin_unlock_irqrestore(&q40kbd->lock, flags);
=20
 	return IRQ_HANDLED;
 }
@@ -72,17 +77,23 @@ static irqreturn_t q40kbd_interrupt(int irq, void *=
dev_id)
  * q40kbd_flush() flushes all data that may be in the keyboard buffers
  */
=20
-static void q40kbd_flush(void)
+static void q40kbd_flush(struct q40kbd *q40kbd)
 {
 	int maxread =3D 100;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&q40kbd_lock, flags);
+	spin_lock_irqsave(&q40kbd->lock, flags);
=20
 	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
 		master_inb(KEYCODE_REG);
=20
-	spin_unlock_irqrestore(&q40kbd_lock, flags);
+	spin_unlock_irqrestore(&q40kbd->lock, flags);
+}
+
+static void q40kbd_stop(void)
+{
+	master_outb(0, KEY_IRQ_ENABLE_REG);
+	master_outb(-1, KEYBOARD_UNLOCK_REG);
 }
=20
 /*
@@ -92,12 +103,9 @@ static void q40kbd_flush(void)
=20
 static int q40kbd_open(struct serio *port)
 {
-	q40kbd_flush();
+	struct q40kbd *q40kbd =3D port->port_data;
=20
-	if (request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL=
)) {
-		printk(KERN_ERR "q40kbd.c: Can't get irq %d.\n", Q40_IRQ_KEYBOARD);
-		return -EBUSY;
-	}
+	q40kbd_flush(q40kbd);
=20
 	/* off we go */
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
@@ -108,36 +116,72 @@ static int q40kbd_open(struct serio *port)
=20
 static void q40kbd_close(struct serio *port)
 {
-	master_outb(0, KEY_IRQ_ENABLE_REG);
-	master_outb(-1, KEYBOARD_UNLOCK_REG);
-	free_irq(Q40_IRQ_KEYBOARD, NULL);
+	struct q40kbd *q40kbd =3D port->port_data;
=20
-	q40kbd_flush();
+	q40kbd_stop();
+	q40kbd_flush(q40kbd);
 }
=20
-static int __devinit q40kbd_probe(struct platform_device *dev)
+static int __devinit q40kbd_probe(struct platform_device *pdev)
 {
-	q40kbd_port =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!q40kbd_port)
-		return -ENOMEM;
-
-	q40kbd_port->id.type	=3D SERIO_8042;
-	q40kbd_port->open	=3D q40kbd_open;
-	q40kbd_port->close	=3D q40kbd_close;
-	q40kbd_port->dev.parent	=3D &dev->dev;
-	strlcpy(q40kbd_port->name, "Q40 Kbd Port", sizeof(q40kbd_port->name))=
;
-	strlcpy(q40kbd_port->phys, "Q40", sizeof(q40kbd_port->phys));
-
-	serio_register_port(q40kbd_port);
+	struct q40kbd *q40kbd;
+	struct serio *port;
+	int error;
+
+	q40kbd =3D kzalloc(sizeof(struct q40kbd), GFP_KERNEL);
+	port =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!q40kbd || !port) {
+		error =3D -ENOMEM;
+		goto err_free_mem;
+	}
+
+	q40kbd->port =3D port;
+	spin_lock_init(&q40kbd->lock);
+
+	port->id.type =3D SERIO_8042;
+	port->open =3D q40kbd_open;
+	port->close =3D q40kbd_close;
+	port->port_data =3D q40kbd;
+	port->dev.parent =3D &pdev->dev;
+	strlcpy(port->name, "Q40 Kbd Port", sizeof(port->name));
+	strlcpy(port->phys, "Q40", sizeof(port->phys));
+
+	q40kbd_stop();
+
+	error =3D request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0,
+			    DRV_NAME, q40kbd);
+	if (error) {
+		dev_err(&pdev->dev, "Can't get irq %d.\n", Q40_IRQ_KEYBOARD);
+		goto err_free_mem;
+	}
+
+	serio_register_port(q40kbd->port);
+
+	platform_set_drvdata(pdev, q40kbd);
 	printk(KERN_INFO "serio: Q40 kbd registered\n");
=20
 	return 0;
+
+err_free_mem:
+	kfree(port);
+	kfree(q40kbd);
+	return error;
 }
=20
-static int __devexit q40kbd_remove(struct platform_device *dev)
+static int __devexit q40kbd_remove(struct platform_device *pdev)
 {
-	serio_unregister_port(q40kbd_port);
-
+	struct q40kbd *q40kbd =3D platform_get_drvdata(pdev);
+
+	/*
+	 * q40kbd_close() will be called as part of unregistering
+	 * and will ensure that IRQ is turned off, so it is safe
+	 * to unregister port first and free IRQ later.
+	 */
+	serio_unregister_port(q40kbd->port);
+	free_irq(Q40_IRQ_KEYBOARD, q40kbd);
+	kfree(q40kbd);
+
+	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
=20
@@ -146,41 +190,16 @@ static struct platform_driver q40kbd_driver =3D {
 		.name	=3D "q40kbd",
 		.owner	=3D THIS_MODULE,
 	},
-	.probe		=3D q40kbd_probe,
 	.remove		=3D __devexit_p(q40kbd_remove),
 };
=20
 static int __init q40kbd_init(void)
 {
-	int error;
-
-	if (!MACH_IS_Q40)
-		return -ENODEV;
-
-	error =3D platform_driver_register(&q40kbd_driver);
-	if (error)
-		return error;
-
-	q40kbd_device =3D platform_device_alloc("q40kbd", -1);
-	if (!q40kbd_device)
-		goto err_unregister_driver;
-
-	error =3D platform_device_add(q40kbd_device);
-	if (error)
-		goto err_free_device;
-
-	return 0;
-
- err_free_device:
-	platform_device_put(q40kbd_device);
- err_unregister_driver:
-	platform_driver_unregister(&q40kbd_driver);
-	return error;
+	return platform_driver_probe(&q40kbd_driver, q40kbd_probe);
 }
=20
 static void __exit q40kbd_exit(void)
 {
-	platform_device_unregister(q40kbd_device);
 	platform_driver_unregister(&q40kbd_driver);
 }
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
