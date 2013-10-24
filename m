From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 1/2] tps6507x-ts: Add DT support
Date: Thu, 24 Oct 2013 22:35:53 +0530
Message-ID: <CAKDJKT4+ma+KdNX0uemZUQVKHp8giGUX8EgWkY40vYOR-KR0_A@mail.gmail.com>
References: <1382545733-8865-1-git-send-email-badarkhe.manish@gmail.com>
	<1382545733-8865-2-git-send-email-badarkhe.manish@gmail.com>
	<20131023164548.GB6042@kartoffel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1237863098=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20131023164548.GB6042@kartoffel>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--===============1237863098==
Content-Type: multipart/alternative; boundary="047d7b2e104384a75f04e97fa555"

--047d7b2e104384a75f04e97fa555
Content-Type: text/plain; charset="ISO-8859-1"

Hi Mark,

Thank you for your reply.

On Wed, Oct 23, 2013 at 10:15 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:

> On Wed, Oct 23, 2013 at 05:28:52PM +0100, Manish Badarkhe wrote:
> > Add device tree based support for TI's tps6507x touchscreen.
> >
> > Signed-off-by: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > Changes since V3:
> >  - Rebased on top of Dmitry's changes
> >  - Removed error handling for optional DT properties
> >
> > Changes since V2:
> >  - Removed unnecessary code.
> >  - Updated Documentation to provide proper names of
> >    devicetree properties.
> >
> > Changes since V1:
> >  - Updated documentation to specify tps6507x as multifunctional
> >    device.
> >  - return proper error value in absence of platform and DT
> >    data for touchscreen.
> >  - Updated commit message.
> >
> > :100755 100755 8fffa3c... e1b9cfd... M
>  Documentation/devicetree/bindings/mfd/tps6507x.txt
> > :100644 100644 db604e0... 0cf0eb1... M
>  drivers/input/touchscreen/tps6507x-ts.c
> >  Documentation/devicetree/bindings/mfd/tps6507x.txt |   24 ++++++-
> >  drivers/input/touchscreen/tps6507x-ts.c            |   72
> ++++++++++++--------
> >  2 files changed, 67 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt
> b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> > index 8fffa3c..e1b9cfd 100755
> > --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
> > +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> > @@ -1,4 +1,8 @@
> > -TPS6507x Power Management Integrated Circuit
> > +TPS6507x Multifunctional Device.
> > +
> > +Features provided by TPS6507x:
> > +        1.Power Management Integrated Circuit.
> > +        2.Touch-Screen.
> >
> >  Required properties:
> >  - compatible: "ti,tps6507x"
> > @@ -23,6 +27,9 @@ Required properties:
> >         vindcdc1_2-supply: VDCDC1 and VDCDC2 input.
> >         vindcdc3-supply  : VDCDC3 input.
> >         vldo1_2-supply   : VLDO1 and VLDO2 input.
> > +- tsc: This node specifies touch screen data.
>
> This is a node, but is listed un "Required properties". That seems odd.
>
> When is it required?
>
> Why is the data under the tsc subnode? Why not directly under the main
> node?
>

Yes, It seems odd to add a subnode properties here. I gone through other
documentation
for MFD devices and observed that separate documentation file is present
for sub node modules.

TPS6507x is multifunctional device and having touch screen submodule. As it
is child node for
TPS6507x multifunctional device, I have created child node as "tsc".


>
> > +     ti,poll-period : Time at which touch input is getting sampled in
> ms.
>
> Is this for debounce? Other bindings have similar but differently named
> properties.
>
> This is not debounce time. This time is required for input poll devices.


> Why is this necessary? Can the driver not choose a sane value?
>
> poll-period is necessary to sample touch inputs. Driver will chose value
default poll
period if this value is not present. I was bit confused here, whether to
add this property
as optional or required. As with default period touch not achieve
performance.
Can I make this property optional?


> > +     ti,min-pressure: Minimum pressure value to trigger touch.
>
> What type are these? Single (u32) cells?
>
> What units is ti,min-pressure in?
>
> No, its a u16 cell. It is measured in ohm. Again default value for
min-pressure is available
in driver code. Can I make this property optional?

>
> >  Regulator Optional properties:
> >  - defdcdc_default: It's property of DCDC2 and DCDC3 regulators.
> > @@ -30,6 +37,14 @@ Regulator Optional properties:
> >                       1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
> >    If this property is not defined, it defaults to 0 (not enabled).
> >
> > +Touchscreen Optional properties:
> > +- ti,vendor : Touchscreen vendor id to populate
> > +           in sysclass interface.
> > +- ti,product: Touchscreen product id to populate
> > +           in sysclass interface.
> > +- ti,version: Touchscreen version id to populate
> > +           in sysclass interface.
>
> Are these integers, strings, or something else?
>
> These are unsigned short(u16) values.


> What values make sense?
>
> These values are only to tell about chip details.


> What's the sysclass interface? That sounds like a Linux detail. The
> properties
> might be fine but the description shouldn't need to refer to Linux
> internals.
>
> Okay, I will update description for these properties.

> +
> >  Example:
> >
> >       pmu: tps6507x@48 {
> > @@ -88,4 +103,11 @@ Example:
> >                       };
> >               };
> >
> > +             tsc {
> > +                     ti,poll-period = <30>;
> > +                     ti,min-pressure = <0x30>;
> > +                     ti,vendor = <0>;
> > +                     ti,product = <65070>;
> > +                     ti,version = <0x100>;
> > +             };
> >       };
> > diff --git a/drivers/input/touchscreen/tps6507x-ts.c
> b/drivers/input/touchscreen/tps6507x-ts.c
> > index db604e0..0cf0eb1 100644
> > --- a/drivers/input/touchscreen/tps6507x-ts.c
> > +++ b/drivers/input/touchscreen/tps6507x-ts.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/mfd/tps6507x.h>
> >  #include <linux/input/tps6507x-ts.h>
> >  #include <linux/delay.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >
> >  #define TSC_DEFAULT_POLL_PERIOD 30 /* ms */
> >  #define TPS_DEFAULT_MIN_PRESSURE 0x30
> > @@ -206,33 +208,54 @@ done:
> >       tps6507x_adc_standby(tsc);
> >  }
> >
> > +static void tsc_init_data(struct tps6507x_ts *tsc,
> > +             struct input_dev *input_dev)
> > +{
> > +     struct device_node *node = tsc->dev->of_node;
> > +     const struct tps6507x_board *tps_board =
> > +                     dev_get_platdata(tsc->dev);
> > +     const struct touchscreen_init_data *init_data = NULL;
> > +
> > +     if (node)
> > +             node = of_find_node_by_name(node, "tsc");
>
> As of_find_node_by_name traverses the list of all nodes (not just
> children),
> this may match nodes other than what you expect.
>

I think, It traverse nodes from parent node (i.e. tps6507x) and find child.
Please correct me if I am wrong?


>
> > +     if (tps_board)
> > +             /*
> > +              * init_data points to array of touchscreen_init structure
> > +              * coming from the board-evm file.
> > +              */
> > +             init_data = tps_board->tps6507x_ts_init_data;
> > +
> > +     if (node == NULL || init_data == NULL) {
> > +             tsc->poll_dev->poll_interval = TSC_DEFAULT_POLL_PERIOD;
> > +             tsc->min_pressure = TPS_DEFAULT_MIN_PRESSURE;
> > +     } else if (init_data) {
> > +             tsc->poll_dev->poll_interval = init_data->poll_period;
> > +             tsc->min_pressure = init_data->min_pressure;
> > +             input_dev->id.vendor = init_data->vendor;
> > +             input_dev->id.product = init_data->product;
> > +             input_dev->id.version = init_data->version;
> > +     } else if (node) {
> > +             of_property_read_u32(node, "ti,poll-period",
> > +                             &tsc->poll_dev->poll_interval);
> > +             of_property_read_u16(node, "ti,min-pressure",
> > +                             &tsc->min_pressure);
>
> You didn't mention these were 16-bit values in the binding.
>
> As DTB is encoded big-endian, and you didn't use a /bits/ 16 declaration
> (making the property a u32 cell), won't this read 0 in all cases you have a
> value in the expected range (as in your example)?
>

I will mention these values as 16bit. values in binding.


>
> > +             of_property_read_u16(node, "ti,vendor",
> > +                             &input_dev->id.vendor);
> > +             of_property_read_u16(node, "ti,product",
> > +                             &input_dev->id.product);
> > +             of_property_read_u16(node, "ti,version",
> > +                             &input_dev->id.version);
>
> Similarly for these three.
>

Also, I will mention these values as 16bit in binding.


>
> Thanks,
> Mark.
>

Thanks,
Manish Badarkhe

--047d7b2e104384a75f04e97fa555
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mark,<br><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">Thank you for your reply.<br></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Oct 23, 2013 at 10:15 PM, Mark =
Rutland <span dir=3D"ltr">&lt;<a href=3D"mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org" targe=
t=3D"_blank">mark.rutland-5wv7dgnIgG8@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D""><div clas=
s=3D"h5">On Wed, Oct 23, 2013 at 05:28:52PM +0100, Manish Badarkhe wrote:<b=
r>
&gt; Add device tree based support for TI&#39;s tps6507x touchscreen.<br>
&gt;<br>
&gt; Signed-off-by: Manish Badarkhe &lt;<a href=3D"mailto:badarkhe.manish@g=
mail.com">badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; Changes since V3:<br>
&gt; =A0- Rebased on top of Dmitry&#39;s changes<br>
&gt; =A0- Removed error handling for optional DT properties<br>
&gt;<br>
&gt; Changes since V2:<br>
&gt; =A0- Removed unnecessary code.<br>
&gt; =A0- Updated Documentation to provide proper names of<br>
&gt; =A0 =A0devicetree properties.<br>
&gt;<br>
&gt; Changes since V1:<br>
&gt; =A0- Updated documentation to specify tps6507x as multifunctional<br>
&gt; =A0 =A0device.<br>
&gt; =A0- return proper error value in absence of platform and DT<br>
&gt; =A0 =A0data for touchscreen.<br>
&gt; =A0- Updated commit message.<br>
&gt;<br>
&gt; :100755 100755 8fffa3c... e1b9cfd... M =A0 =A0 =A0 =A0Documentation/de=
vicetree/bindings/mfd/tps6507x.txt<br>
&gt; :100644 100644 db604e0... 0cf0eb1... M =A0 =A0 =A0 =A0drivers/input/to=
uchscreen/tps6507x-ts.c<br>
&gt; =A0Documentation/devicetree/bindings/mfd/tps6507x.txt | =A0 24 ++++++-=
<br>
&gt; =A0drivers/input/touchscreen/tps6507x-ts.c =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 72 ++++++++++++--------<br>
&gt; =A02 files changed, 67 insertions(+), 29 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Docu=
mentation/devicetree/bindings/mfd/tps6507x.txt<br>
&gt; index 8fffa3c..e1b9cfd 100755<br>
&gt; --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt<br>
&gt; +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt<br>
&gt; @@ -1,4 +1,8 @@<br>
&gt; -TPS6507x Power Management Integrated Circuit<br>
&gt; +TPS6507x Multifunctional Device.<br>
&gt; +<br>
&gt; +Features provided by TPS6507x:<br>
&gt; + =A0 =A0 =A0 =A01.Power Management Integrated Circuit.<br>
&gt; + =A0 =A0 =A0 =A02.Touch-Screen.<br>
&gt;<br>
&gt; =A0Required properties:<br>
&gt; =A0- compatible: &quot;ti,tps6507x&quot;<br>
&gt; @@ -23,6 +27,9 @@ Required properties:<br>
&gt; =A0 =A0 =A0 =A0 vindcdc1_2-supply: VDCDC1 and VDCDC2 input.<br>
&gt; =A0 =A0 =A0 =A0 vindcdc3-supply =A0: VDCDC3 input.<br>
&gt; =A0 =A0 =A0 =A0 vldo1_2-supply =A0 : VLDO1 and VLDO2 input.<br>
&gt; +- tsc: This node specifies touch screen data.<br>
<br>
</div></div>This is a node, but is listed un &quot;Required properties&quot=
;. That seems odd.<br>
<br>
When is it required?<br>
<br>
Why is the data under the tsc subnode? Why not directly under the main node=
?<br></blockquote><div><br></div><div>Yes, It seems odd to add a subnode pr=
operties here. I gone through other documentation <br>for MFD devices and o=
bserved that separate documentation file is present for sub node modules.<b=
r>
<br>TPS6507x is multifunctional device and having touch screen submodule. A=
s it is child node for<br>TPS6507x multifunctional device, I have created c=
hild node as &quot;tsc&quot;.<br></div><div>=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">

<div class=3D"im"><br>
&gt; + =A0 =A0 ti,poll-period : Time at which touch input is getting sample=
d in ms.<br>
<br>
</div>Is this for debounce? Other bindings have similar but differently nam=
ed<br>
properties.<br>
<br></blockquote><div>This is not debounce time. This time is required for =
input poll devices.<br></div><div>=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">

Why is this necessary? Can the driver not choose a sane value?<br>
<div class=3D"im"><br></div></blockquote><div>poll-period is necessary to s=
ample touch inputs. Driver will chose value default poll <br></div><div>per=
iod if this value is not present. I was bit confused here, whether to add t=
his property <br>
</div><div>as optional or required. As with default period touch not achiev=
e performance. <br>Can I make this property optional?<br></div><div>=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im">
&gt; + =A0 =A0 ti,min-pressure: Minimum pressure value to trigger touch.<br=
>
<br>
</div>What type are these? Single (u32) cells?<br>
<br>
What units is ti,min-pressure in?<br>
<div class=3D"im"><br></div></blockquote><div>No, its a u16 cell. It is mea=
sured in ohm. Again default value for min-pressure is available<br></div><d=
iv>in driver code. Can I make this property optional?<br> <br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im">
&gt;<br>
&gt; =A0Regulator Optional properties:<br>
&gt; =A0- defdcdc_default: It&#39;s property of DCDC2 and DCDC3 regulators.=
<br>
&gt; @@ -30,6 +37,14 @@ Regulator Optional properties:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1: If defdcdc pin of DCDC2=
/DCDC3 is driven HIGH.<br>
&gt; =A0 =A0If this property is not defined, it defaults to 0 (not enabled)=
.<br>
&gt;<br>
&gt; +Touchscreen Optional properties:<br>
&gt; +- ti,vendor : Touchscreen vendor id to populate<br>
&gt; + =A0 =A0 =A0 =A0 =A0 in sysclass interface.<br>
&gt; +- ti,product: Touchscreen product id to populate<br>
&gt; + =A0 =A0 =A0 =A0 =A0 in sysclass interface.<br>
&gt; +- ti,version: Touchscreen version id to populate<br>
&gt; + =A0 =A0 =A0 =A0 =A0 in sysclass interface.<br>
<br>
</div>Are these integers, strings, or something else?<br>
<br></blockquote><div>These are unsigned short(u16) values. <br></div><div>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
What values make sense?<br>
<br></blockquote><div>These values are only to tell about chip details.<br>=
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
What&#39;s the sysclass interface? That sounds like a Linux detail. The pro=
perties<br>
might be fine but the description shouldn&#39;t need to refer to Linux inte=
rnals.<br>
<div><div class=3D"h5"><br></div></div></blockquote><div>Okay, I will updat=
e description for these properties.=A0 <br><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<div><div class=3D"h5">
&gt; +<br>
&gt; =A0Example:<br>
&gt;<br>
&gt; =A0 =A0 =A0 pmu: tps6507x@48 {<br>
&gt; @@ -88,4 +103,11 @@ Example:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 tsc {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,poll-period =3D &lt;30&gt=
;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,min-pressure =3D &lt;0x30=
&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,vendor =3D &lt;0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,product =3D &lt;65070&gt;=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,version =3D &lt;0x100&gt;=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; =A0 =A0 =A0 };<br>
&gt; diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/t=
ouchscreen/tps6507x-ts.c<br>
&gt; index db604e0..0cf0eb1 100644<br>
&gt; --- a/drivers/input/touchscreen/tps6507x-ts.c<br>
&gt; +++ b/drivers/input/touchscreen/tps6507x-ts.c<br>
&gt; @@ -22,6 +22,8 @@<br>
&gt; =A0#include &lt;linux/mfd/tps6507x.h&gt;<br>
&gt; =A0#include &lt;linux/input/tps6507x-ts.h&gt;<br>
&gt; =A0#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/of.h&gt;<br>
&gt; +#include &lt;linux/of_device.h&gt;<br>
&gt;<br>
&gt; =A0#define TSC_DEFAULT_POLL_PERIOD 30 /* ms */<br>
&gt; =A0#define TPS_DEFAULT_MIN_PRESSURE 0x30<br>
&gt; @@ -206,33 +208,54 @@ done:<br>
&gt; =A0 =A0 =A0 tps6507x_adc_standby(tsc);<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static void tsc_init_data(struct tps6507x_ts *tsc,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct input_dev *input_dev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct device_node *node =3D tsc-&gt;dev-&gt;of_node;<br>
&gt; + =A0 =A0 const struct tps6507x_board *tps_board =3D<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_get_platdata(tsc-&gt;dev=
);<br>
&gt; + =A0 =A0 const struct touchscreen_init_data *init_data =3D NULL;<br>
&gt; +<br>
&gt; + =A0 =A0 if (node)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 node =3D of_find_node_by_name(node, &quot;ts=
c&quot;);<br>
<br>
</div></div>As of_find_node_by_name traverses the list of all nodes (not ju=
st children),<br>
this may match nodes other than what you expect.<br></blockquote><div><br><=
/div><div>I think, It traverse nodes from parent node (i.e. tps6507x) and f=
ind child.<br></div><div>Please correct me if I am wrong? <br></div><div>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im"><br>
&gt; + =A0 =A0 if (tps_board)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0* init_data points to array of touchscree=
n_init structure<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0* coming from the board-evm file.<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 init_data =3D tps_board-&gt;tps6507x_ts_init=
_data;<br>
&gt; +<br>
&gt; + =A0 =A0 if (node =3D=3D NULL || init_data =3D=3D NULL) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 tsc-&gt;poll_dev-&gt;poll_interval =3D TSC_D=
EFAULT_POLL_PERIOD;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 tsc-&gt;min_pressure =3D TPS_DEFAULT_MIN_PRE=
SSURE;<br>
&gt; + =A0 =A0 } else if (init_data) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 tsc-&gt;poll_dev-&gt;poll_interval =3D init_=
data-&gt;poll_period;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 tsc-&gt;min_pressure =3D init_data-&gt;min_p=
ressure;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 input_dev-&gt;id.vendor =3D init_data-&gt;ve=
ndor;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 input_dev-&gt;id.product =3D init_data-&gt;p=
roduct;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 input_dev-&gt;id.version =3D init_data-&gt;v=
ersion;<br>
&gt; + =A0 =A0 } else if (node) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(node, &quot;ti,poll-per=
iod&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;tsc-&gt=
;poll_dev-&gt;poll_interval);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u16(node, &quot;ti,min-pres=
sure&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;tsc-&gt=
;min_pressure);<br>
<br>
</div>You didn&#39;t mention these were 16-bit values in the binding.<br>
<br>
As DTB is encoded big-endian, and you didn&#39;t use a /bits/ 16 declaratio=
n<br>
(making the property a u32 cell), won&#39;t this read 0 in all cases you ha=
ve a<br>
value in the expected range (as in your example)?<br></blockquote><div><br>=
</div><div>I will mention these values as 16bit. values in binding.<br></di=
v><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u16(node, &quot;ti,vendor&q=
uot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;input_d=
ev-&gt;id.vendor);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u16(node, &quot;ti,product&=
quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;input_d=
ev-&gt;id.product);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u16(node, &quot;ti,version&=
quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;input_d=
ev-&gt;id.version);<br>
<br>
</div>Similarly for these three.<br></blockquote><div><br>Also, I will ment=
ion these values as 16bit in binding.<br></div><div>=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">

<br>
Thanks,<br>
Mark.<br>
</blockquote></div><br></div><div class=3D"gmail_extra">Thanks,<br></div><d=
iv class=3D"gmail_extra">Manish Badarkhe<br></div></div>

--047d7b2e104384a75f04e97fa555--

--===============1237863098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1237863098==--
