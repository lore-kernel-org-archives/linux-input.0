From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH] INPUT: gpio_keys.c: Added OF support and enabled use
 with I2C GPIO expanders
Date: Mon, 6 Jun 2011 15:39:10 +0200
Message-ID: <20110606153910.14865cc9@archvile>
References: <-3144470533789149426@unknownmsgid>
	<BANLkTikt2iLXqOeO0ba0jK1+WiNRVBAESw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:12151 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab1FFNjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 09:39:06 -0400
In-Reply-To: <BANLkTikt2iLXqOeO0ba0jK1+WiNRVBAESw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


Hi Grant,

Thanks for reacting.

On Thu, 2 Jun 2011 07:30:21 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:
> There are a lot of unrelated changes being made in this patch.  Can
> you split it up please into logical changes.  For example, adding
> device tree support is one discrete change, reworking the handling of
> struct device pointers is another, changing the initcall is another,
> etc.

Ok, will do.

>[...]
> >
> > =C2=A0struct gpio_button_data {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_keys_button *button;
> > @@ -42,6 +49,7 @@ struct gpio_keys_drvdata {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*enable)(struct device *dev);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*disable)(struct device *dev);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_button_data data[0];
> > + =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_platform_data *dyn_pdata;
>=20
> If you make this a copy of the gpio_keys_platform_data instead of a
> pointer, then you can avoid kzallocing a pdata structure, and avoid
> the messy question about when to free it.

Someone needs to kzalloc it somewhere. Originally it is supposed to be =
done in
platform setup code somewhere in the BSP. Now I am parsing OF Device-Tr=
ee
data, so I will need to provide this, since pdata is NULL.
I don't know how to deal with it in a simpler way than using an extra m=
ember
in struct gpio_keys_drvdata to save the allocated pointer and free it i=
f
needed....

> > =C2=A0};
> >
> > =C2=A0/*
> > @@ -251,8 +259,7 @@ static ssize_t gpio_keys_show_##name(struct dev=
ice
> > *dev, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ struct device_attr=
ibute *attr, =C2=A0 =C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf) =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 \
> > =C2=A0{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > - =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platform=
_device(dev); =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > - =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_drvdata *ddata =3D platform=
_get_drvdata(pdev); =C2=A0 \
> > + =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_drvdata *ddata =3D dev_get_=
drvdata(dev); =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return gpio_keys_attr_show_helper(ddata,=
 buf, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0type, only_disabled); =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > @@ -278,8 +285,7 @@ static ssize_t gpio_keys_store_##name(struct de=
vice
> > *dev, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ const char *buf, =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t c=
ount) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
> > =C2=A0{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > - =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platform=
_device(dev); =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > - =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_drvdata *ddata =3D platform=
_get_drvdata(pdev); =C2=A0 \
> > + =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_drvdata *ddata =3D dev_get_=
drvdata(dev); =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t error; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D gpio_keys_attr_store_helper(dd=
ata, buf, type); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > @@ -359,12 +365,11 @@ static irqreturn_t gpio_keys_isr(int irq, voi=
d
> > *dev_id) return IRQ_HANDLED;
> > =C2=A0}
> >
> > -static int __devinit gpio_keys_setup_key(struct platform_device *p=
dev,
> > +static int __devinit gpio_keys_setup_key(struct device *dev,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct gpio_button_data *bdata,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct gpio_keys_button *button)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0char *desc =3D button->desc ? button->de=
sc : "gpio_keys";
> > - =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &pdev->dev;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long irqflags;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq, error;
> >
> > @@ -410,8 +415,8 @@ static int __devinit gpio_keys_setup_key(struct
> > platform_device *pdev, if (!button->can_disable)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irqflags |=3D=
 IRQF_SHARED;
> >
> > - =C2=A0 =C2=A0 =C2=A0 error =3D request_any_context_irq(irq, gpio_=
keys_isr, irqflags,
> > desc, bdata);
> > - =C2=A0 =C2=A0 =C2=A0 if (error < 0) {
> > + =C2=A0 =C2=A0 =C2=A0 error =3D request_threaded_irq(irq, NULL, gp=
io_keys_isr, irqflags,
> > desc, bdata);
> > + =C2=A0 =C2=A0 =C2=A0 if (error) {
>=20
> You need to explain why you are making this change.

Will do in next patch version... it amounts to this:
request_threaded_irq() permits to execute the IRQ code in a thread, whi=
ch is
better suited if the handler wants to do things like I2C transfers to f=
igure
out the cause of the interrupt (like in a PCA953x).
The second line was not intended to be changed... will revert that, sor=
ry.

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev,=
 "Unable to claim irq %d; error %d\n",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0irq, error);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail3;
> > @@ -440,18 +445,133 @@ static void gpio_keys_close(struct input_dev=
 *input)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ddata->disab=
le(input->dev.parent);
> > =C2=A0}
> >
> > +/*
> > + * Handlers for alternative sources of platform_data
> > + */
> > +#ifdef CONFIG_OF
> > +/*
> > + * Translate OpenFirmware node properties into platform_data
> > + */
> > +static struct gpio_keys_platform_data *
> > +gpio_keys_get_alt_pdata(struct device *dev)
>=20
> Function name should reflect what it does.  In this case, something
> like gpio_keys_get_devtree_pdata() would be more appropriate.

Agreed!

> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_platform_data *pdata;
> > + =C2=A0 =C2=A0 =C2=A0 struct device_node *node, *pp;
> > + =C2=A0 =C2=A0 =C2=A0 int i;
> > + =C2=A0 =C2=A0 =C2=A0 struct gpio_keys_button *buttons;
> > + =C2=A0 =C2=A0 =C2=A0 const u32 *reg;
> > + =C2=A0 =C2=A0 =C2=A0 int len;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 node =3D dev->of_node;
> > + =C2=A0 =C2=A0 =C2=A0 if (node =3D=3D NULL)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 pdata =3D kzalloc(sizeof(struct gpio_keys_pl=
atform_data),
> > GFP_KERNEL);
> > + =C2=A0 =C2=A0 =C2=A0 if (pdata =3D=3D NULL) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Un=
able to allocate platform_data\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 reg =3D of_get_property(node, "linux,autorep=
eat", &len);
>=20
> You're creating a new binding.  You must also document it in
> Documentation/devicetree/bindings.

Ok, will do, thanks for pointing out.

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
