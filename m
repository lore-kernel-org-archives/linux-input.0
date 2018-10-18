From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
Date: Thu, 18 Oct 2018 08:04:00 -0500
Message-ID: <CAL_JsqLdXEPYsK5q4J9_ZF10NJbj6_cH199zLhZ5+9oQYw9B6w@mail.gmail.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com> <20181017201522.GA26525@bogus>
 <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 18, 2018 at 3:10 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Oct 17, 2018 at 10:15 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
> > > Some new touchpads IC are connected through PS/2 and I2C. On some of these
> > > new IC, the I2C part doesn't have all of the information available.
> > > We need to be able to forward the touchpad parameters from PS/2 and
> > > thus, we need those new optional properties.
> > >
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > >  Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
> > > index 797607460735..ace6bcb0b4eb 100644
> > > --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
> > > +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
> > > @@ -13,6 +13,14 @@ Optional properties:
> > >    pinctrl binding [1]).
> > >  - vcc-supply: a phandle for the regulator supplying 3.3V power.
> > >  - elan,trackpoint: touchpad can support a trackpoint (boolean)
> > > +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
> >
> > > +- elan,max_x: the maximum reported value on the X axis
> > > +- elan,max_y: the maximum reported value on the Y axis
> > > +- elan,min_x: the minimum reported value on the X axis
> > > +- elan,min_y: the minimum reported value on the Y axis
> > > +- elan,x_res: the resolution of the X axis (in units per mm)
> > > +- elan,y_res: the resolution of the Y axis (in units per mm)
> > > +- elan,width: max reported width of a blob
> >
> > Can't we use standard touchscreen properties here? (Yes, I get this is a
> > touchpad, not touchscreen).
>
> Hey Rob,
>
> Well, there is that (it's a touchpad driver) and we can't also really
> use the of_touchscreen.c implementation.
> If both concerns are not an issue, we can then move the [min/max/res]
> properties to the touchscreen ones.

Neither is problem for me. Bindings don't have to map 1:1 to kernel code.

> Regarding 'elan,width', this is something missing from the standard ts
> properties, and AFAICT, this controls the maximum reported
> width/height of a touch.
> I should probably rename them to max_width, max_height.

Sure, just use '-' rather than '_' in property names.

> Hans, do you think we should add such properties to of_touchscreen.c
> too? (the width/height ones)
>
> Cheers,
> Benjamin
