From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 2/3] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Fri, 17 Jun 2011 06:54:17 -0600
Message-ID: <BANLkTikp=HfED5KD16Axop84=kXUp=xnTQ@mail.gmail.com>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-3-git-send-email-david@protonic.nl> <20110616192559.GI3795@ponder.secretlab.ca>
 <20110617105823.77c5920a@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36299 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618Ab1FQMyi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 08:54:38 -0400
Received: by gyh3 with SMTP id 3so560703gyh.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 05:54:37 -0700 (PDT)
In-Reply-To: <20110617105823.77c5920a@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: David Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Jun 17, 2011 at 2:58 AM, David Jander <david.jander@protonic.nl=
> wrote:
>
> Hi Grant,
>
> On Thu, 16 Jun 2011 13:25:59 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Tue, Jun 14, 2011 at 11:08:10AM +0200, David Jander wrote:
>> > This patch enables fetching configuration data which is normally p=
rovided
>> > via platform_data from the device-tree instead.
>> > If the device is configured from device-tree data, the platform_da=
ta struct
>> > is not used, and button data needs to be allocated dynamically.
>> > Big part of this patch deals with confining pdata usage to the pro=
be
>> > function, to make this possible.
>> >
>> > Signed-off-by: David Jander <david@protonic.nl>
>> > ---
>> > =A0.../devicetree/bindings/gpio/gpio_keys.txt =A0 =A0 =A0 =A0 | =A0=
 49 +++++++
>> > =A0drivers/input/keyboard/gpio_keys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0147
>> > ++++++++++++++++++-- 2 files changed, 186 insertions(+), 10 deleti=
ons(-)
>> > =A0create mode 100644 Documentation/devicetree/bindings/gpio/gpio_=
keys.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt
>> > b/Documentation/devicetree/bindings/gpio/gpio_keys.txt new file mo=
de 100644
>> > index 0000000..60a4d8e
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
>> > @@ -0,0 +1,49 @@
>> > +Device-Tree bindings for input/gpio_keys.c keyboard driver
>> > +
>> > +Required properties:
>> > + =A0 - compatible =3D "gpio-keys";
>> > +
>> > +Optional properties:
>> > + =A0 - autorepeat: Boolean, Enable auto repeat feature of Linux i=
nput
>> > + =A0 =A0 subsystem.
>> > +
>> > +Each button (key) is represented as a sub-node of "gpio-keys":
>> > +Subnode properties:
>> > +
>> > + =A0 - reg: GPIO number the key is bound to if linux GPIO numberi=
ng is
>> > used.
>>
>> Wait. =A0That won't work. =A0There is no concept of "linux gpio numb=
ering"
>> in the device tree data. =A0When using device tree, the gpio numbers
>> usually get dynamically assigned.
>
> Yes I know, but suppose you want to use this driver with a GPIO-drive=
r that
> does not have devaice-tree support yet? I need a way of binding the b=
utton to
> a GPIO pin that does not have a device-tree definition. How should I =
do this
> otherwise?
> I am using this driver with a pca963x, as you might have suspected al=
ready,
> and I just added OF device-tree support to it, so that will work, but
> others...?

The solution is to add OF support to the GPIO driver being used.

> Before "fixing" pca963x, I used this property and it worked perfectly=
 well, so
> please explain what is not supposed to work. Please keep in mind that=
 this
> is meant as more of a backwards-compatibility feature. If you think t=
hat being
> backwards compatible with non-OF GPIO drivers is a bad idea, I'll rem=
ove this.

It is.  Something that we've been very careful about is to avoid
encoding Linux-specific implementation details into the device tree
bindings.  The implementation details, such as how gpio controllers
are enumerated, are subject to change just in the normal progress of
development.  By focusing the DT bindings on HW description, the DT
data is insulated to a degree from kernel churn.

>> > + =A0 - wakeup: Boolean, button can wake-up the system.
>>
>> "wakeup" is potentially too generic a property name (potential to
>> conflict with a generic wakeup binding if one ever exists). =A0Just =
to
>> be defencive, I'd suggest prefixing these custom gpio keys propertie=
s
>> with something like "gpio-key,".
>
> Ok, "gpio-key,wakeup" it will be then? But isn't this function someth=
ing
> potentially other IO-pins/keys/buttons/interrupts/etc... could have t=
o be able
> to wake up the system?

Can you foresee how all bindings would potentially use a 'wakeup'
property?  It's really hard to define a common binding without first
having several use cases ready to use it.  It's better to start being
cautious, and then create a common binding at some point in the
future.


>> > + =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,input-typ=
e", &len);
>> > + =A0 =A0 =A0 =A0 =A0 if (reg)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D be32_to_=
cpup(reg);
>> > + =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D EV_KEY;
>> how about:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D reg ? be32_to_cpup(r=
eg) : EV_KEY;
>
> Ok, if you prefer this notation.... just an "if...else" in another dr=
ess ;-)

Yup, but it's shorter, and I like painting bike sheds.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
