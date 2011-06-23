From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/3] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Thu, 23 Jun 2011 01:24:10 -0700
Message-ID: <20110623082409.GA2493@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-3-git-send-email-david@protonic.nl>
 <20110616192559.GI3795@ponder.secretlab.ca>
 <20110617105823.77c5920a@archvile>
 <BANLkTikp=HfED5KD16Axop84=kXUp=xnTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55673 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab1FWIYU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 04:24:20 -0400
Received: by pwj7 with SMTP id 7so1090919pwj.19
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2011 01:24:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikp=HfED5KD16Axop84=kXUp=xnTQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Jander <david.jander@protonic.nl>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Fri, Jun 17, 2011 at 06:54:17AM -0600, Grant Likely wrote:
> On Fri, Jun 17, 2011 at 2:58 AM, David Jander <david.jander@protonic.=
nl> wrote:
> >
> > Hi Grant,
> >
> > On Thu, 16 Jun 2011 13:25:59 -0600
> > Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> >> On Tue, Jun 14, 2011 at 11:08:10AM +0200, David Jander wrote:
> >> > This patch enables fetching configuration data which is normally=
 provided
> >> > via platform_data from the device-tree instead.
> >> > If the device is configured from device-tree data, the platform_=
data struct
> >> > is not used, and button data needs to be allocated dynamically.
> >> > Big part of this patch deals with confining pdata usage to the p=
robe
> >> > function, to make this possible.
> >> >
> >> > Signed-off-by: David Jander <david@protonic.nl>
> >> > ---
> >> > =A0.../devicetree/bindings/gpio/gpio_keys.txt =A0 =A0 =A0 =A0 | =
=A0 49 +++++++
> >> > =A0drivers/input/keyboard/gpio_keys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0147
> >> > ++++++++++++++++++-- 2 files changed, 186 insertions(+), 10 dele=
tions(-)
> >> > =A0create mode 100644 Documentation/devicetree/bindings/gpio/gpi=
o_keys.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.tx=
t
> >> > b/Documentation/devicetree/bindings/gpio/gpio_keys.txt new file =
mode 100644
> >> > index 0000000..60a4d8e
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> >> > @@ -0,0 +1,49 @@
> >> > +Device-Tree bindings for input/gpio_keys.c keyboard driver
> >> > +
> >> > +Required properties:
> >> > + =A0 - compatible =3D "gpio-keys";
> >> > +
> >> > +Optional properties:
> >> > + =A0 - autorepeat: Boolean, Enable auto repeat feature of Linux=
 input
> >> > + =A0 =A0 subsystem.
> >> > +
> >> > +Each button (key) is represented as a sub-node of "gpio-keys":
> >> > +Subnode properties:
> >> > +
> >> > + =A0 - reg: GPIO number the key is bound to if linux GPIO numbe=
ring is
> >> > used.
> >>
> >> Wait. =A0That won't work. =A0There is no concept of "linux gpio nu=
mbering"
> >> in the device tree data. =A0When using device tree, the gpio numbe=
rs
> >> usually get dynamically assigned.
> >
> > Yes I know, but suppose you want to use this driver with a GPIO-dri=
ver that
> > does not have devaice-tree support yet? I need a way of binding the=
 button to
> > a GPIO pin that does not have a device-tree definition. How should =
I do this
> > otherwise?
> > I am using this driver with a pca963x, as you might have suspected =
already,
> > and I just added OF device-tree support to it, so that will work, b=
ut
> > others...?
>=20
> The solution is to add OF support to the GPIO driver being used.
>=20
> > Before "fixing" pca963x, I used this property and it worked perfect=
ly well, so
> > please explain what is not supposed to work. Please keep in mind th=
at this
> > is meant as more of a backwards-compatibility feature. If you think=
 that being
> > backwards compatible with non-OF GPIO drivers is a bad idea, I'll r=
emove this.
>=20
> It is.  Something that we've been very careful about is to avoid
> encoding Linux-specific implementation details into the device tree
> bindings.  The implementation details, such as how gpio controllers
> are enumerated, are subject to change just in the normal progress of
> development.  By focusing the DT bindings on HW description, the DT
> data is insulated to a degree from kernel churn.
>=20
> >> > + =A0 - wakeup: Boolean, button can wake-up the system.
> >>
> >> "wakeup" is potentially too generic a property name (potential to
> >> conflict with a generic wakeup binding if one ever exists). =A0Jus=
t to
> >> be defencive, I'd suggest prefixing these custom gpio keys propert=
ies
> >> with something like "gpio-key,".
> >
> > Ok, "gpio-key,wakeup" it will be then? But isn't this function some=
thing
> > potentially other IO-pins/keys/buttons/interrupts/etc... could have=
 to be able
> > to wake up the system?
>=20
> Can you foresee how all bindings would potentially use a 'wakeup'
> property?  It's really hard to define a common binding without first
> having several use cases ready to use it.  It's better to start being
> cautious, and then create a common binding at some point in the
> future.
>=20
>=20
> >> > + =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,input-t=
ype", &len);
> >> > + =A0 =A0 =A0 =A0 =A0 if (reg)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D be32_t=
o_cpup(reg);
> >> > + =A0 =A0 =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D EV_KEY=
;
> >> how about:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D reg ? be32_to_cpup=
(reg) : EV_KEY;
> >
> > Ok, if you prefer this notation.... just an "if...else" in another =
dress ;-)
>=20
> Yup, but it's shorter, and I like painting bike sheds.
>=20

So is there an updated version of this patch coming?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
