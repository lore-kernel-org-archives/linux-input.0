From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v4 2/3] Input: gpio_keys.c: Added support for
 device-tree platform data
Date: Thu, 23 Jun 2011 10:55:38 +0200
Message-ID: <20110623105538.064957e0@archvile>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
	<1308042491-20203-3-git-send-email-david@protonic.nl>
	<20110616192559.GI3795@ponder.secretlab.ca>
	<20110617105823.77c5920a@archvile>
	<BANLkTikp=HfED5KD16Axop84=kXUp=xnTQ@mail.gmail.com>
	<20110623082409.GA2493@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:7858 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab1FWIzd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 04:55:33 -0400
In-Reply-To: <20110623082409.GA2493@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Thu, 23 Jun 2011 01:24:10 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, Jun 17, 2011 at 06:54:17AM -0600, Grant Likely wrote:
> > On Fri, Jun 17, 2011 at 2:58 AM, David Jander <david.jander@protoni=
c.nl>
> > wrote:
> > >
> > > Hi Grant,
> > >
> > > On Thu, 16 Jun 2011 13:25:59 -0600
> > > Grant Likely <grant.likely@secretlab.ca> wrote:
> > >
> > >> On Tue, Jun 14, 2011 at 11:08:10AM +0200, David Jander wrote:
> > >> > This patch enables fetching configuration data which is normal=
ly
> > >> > provided via platform_data from the device-tree instead.
> > >> > If the device is configured from device-tree data, the platfor=
m_data
> > >> > struct is not used, and button data needs to be allocated dyna=
mically.
> > >> > Big part of this patch deals with confining pdata usage to the=
 probe
> > >> > function, to make this possible.
> > >> >
> > >> > Signed-off-by: David Jander <david@protonic.nl>
> > >> > ---
> > >> > =C2=A0.../devicetree/bindings/gpio/gpio_keys.txt =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 49 +++++++
> > >> > =C2=A0drivers/input/keyboard/gpio_keys.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0147
> > >> > ++++++++++++++++++-- 2 files changed, 186 insertions(+), 10
> > >> > deletions(-) create mode 100644
> > >> > Documentation/devicetree/bindings/gpio/gpio_keys.txt
> > >> >
> > >> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.=
txt
> > >> > b/Documentation/devicetree/bindings/gpio/gpio_keys.txt new fil=
e mode
> > >> > 100644 index 0000000..60a4d8e
> > >> > --- /dev/null
> > >> > +++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> > >> > @@ -0,0 +1,49 @@
> > >> > +Device-Tree bindings for input/gpio_keys.c keyboard driver
> > >> > +
> > >> > +Required properties:
> > >> > + =C2=A0 - compatible =3D "gpio-keys";
> > >> > +
> > >> > +Optional properties:
> > >> > + =C2=A0 - autorepeat: Boolean, Enable auto repeat feature of =
Linux input
> > >> > + =C2=A0 =C2=A0 subsystem.
> > >> > +
> > >> > +Each button (key) is represented as a sub-node of "gpio-keys"=
:
> > >> > +Subnode properties:
> > >> > +
> > >> > + =C2=A0 - reg: GPIO number the key is bound to if linux GPIO =
numbering is
> > >> > used.
> > >>
> > >> Wait. =C2=A0That won't work. =C2=A0There is no concept of "linux=
 gpio numbering"
> > >> in the device tree data. =C2=A0When using device tree, the gpio =
numbers
> > >> usually get dynamically assigned.
> > >
> > > Yes I know, but suppose you want to use this driver with a GPIO-d=
river
> > > that does not have devaice-tree support yet? I need a way of bind=
ing the
> > > button to a GPIO pin that does not have a device-tree definition.=
 How
> > > should I do this otherwise?
> > > I am using this driver with a pca963x, as you might have suspecte=
d
> > > already, and I just added OF device-tree support to it, so that w=
ill
> > > work, but others...?
> >=20
> > The solution is to add OF support to the GPIO driver being used.
> >=20
> > > Before "fixing" pca963x, I used this property and it worked perfe=
ctly
> > > well, so please explain what is not supposed to work. Please keep=
 in
> > > mind that this is meant as more of a backwards-compatibility feat=
ure. If
> > > you think that being backwards compatible with non-OF GPIO driver=
s is a
> > > bad idea, I'll remove this.
> >=20
> > It is.  Something that we've been very careful about is to avoid
> > encoding Linux-specific implementation details into the device tree
> > bindings.  The implementation details, such as how gpio controllers
> > are enumerated, are subject to change just in the normal progress o=
f
> > development.  By focusing the DT bindings on HW description, the DT
> > data is insulated to a degree from kernel churn.
> >=20
> > >> > + =C2=A0 - wakeup: Boolean, button can wake-up the system.
> > >>
> > >> "wakeup" is potentially too generic a property name (potential t=
o
> > >> conflict with a generic wakeup binding if one ever exists). =C2=A0=
Just to
> > >> be defencive, I'd suggest prefixing these custom gpio keys prope=
rties
> > >> with something like "gpio-key,".
> > >
> > > Ok, "gpio-key,wakeup" it will be then? But isn't this function so=
mething
> > > potentially other IO-pins/keys/buttons/interrupts/etc... could ha=
ve to
> > > be able to wake up the system?
> >=20
> > Can you foresee how all bindings would potentially use a 'wakeup'
> > property?  It's really hard to define a common binding without firs=
t
> > having several use cases ready to use it.  It's better to start bei=
ng
> > cautious, and then create a common binding at some point in the
> > future.
> >=20
> >=20
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D of_get_property(p=
p, "linux,input-type", &len);
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg)
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 buttons[i].type =3D be32_to_cpup(reg);
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 buttons[i].type =3D EV_KEY;
> > >> how about:
> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons[i].type=
 =3D reg ? be32_to_cpup(reg) : EV_KEY;
> > >
> > > Ok, if you prefer this notation.... just an "if...else" in anothe=
r
> > > dress ;-)
> >=20
> > Yup, but it's shorter, and I like painting bike sheds.
> >=20
>=20
> So is there an updated version of this patch coming?

Yes, I'm preparing v5 right now.

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
