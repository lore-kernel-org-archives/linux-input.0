From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 1/2] tps6507x-ts: Add DT support
Date: Mon, 1 Jul 2013 16:40:34 +0530
Message-ID: <CAKDJKT6UETVpPT9B6LE59_EMrxNGpTmUiu9iddHoWOYhGpHP3Q@mail.gmail.com>
References: <1369126458-24872-1-git-send-email-manishv.b@ti.com>
 <1369126458-24872-2-git-send-email-manishv.b@ti.com>
 <20130610060442.GA30158@core.coreip.homeip.net>
 <A4887BF146CD57468F700B415D2F47015A0DFD@DBDE04.ent.ti.com>
 <20130610180311.GA4649@core.coreip.homeip.net>
 <A4887BF146CD57468F700B415D2F47015A1315@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4150873186128155797=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <A4887BF146CD57468F700B415D2F47015A1315-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--===============4150873186128155797==
Content-Type: multipart/alternative; boundary=20cf307f39c00c88c404e071478a

--20cf307f39c00c88c404e071478a
Content-Type: text/plain; charset=ISO-8859-1

Hi Dmitry

On Wed, Jun 12, 2013 at 12:23 PM, Vishwanathrao Badarkhe, Manish <
manishv.b-l0cyMroinI0@public.gmane.org> wrote:
> Hi Dmitry,
>
> On Mon, Jun 10, 2013 at 23:33:11, Dmitry Torokhov wrote:
>> Manish,
>>
>> On Mon, Jun 10, 2013 at 10:23:16AM +0000, Vishwanathrao Badarkhe, Manish
wrote:
>> > Hi Dmitry,
>> >
>> > On Mon, Jun 10, 2013 at 11:34:42, Dmitry Torokhov wrote:
>> > > Hi Manish,
>> > >
>> > > On Tue, May 21, 2013 at 02:24:17PM +0530, Vishwanathrao Badarkhe,
Manish wrote:
>> > >
>> > > > +       struct touchscreen_init_data *init_data = NULL;
>> > > > +       int err;
>> > > > +
>> > > > +       if (node)
>> > > > +               node = of_find_node_by_name(node, "tsc");
>> > >
>> > > Why do you have to locate OF node manually instead of already having
it attached to the device stucture?
>> >
>> > As TPS6507x is mfd device containing two nodes, regulator and
touchscreen.
>> > It is necessary to use "of_find_node_by_name" to find child "tsc" node
>> > of TPS6507x MFD device.
>>
>> I understand that TPS6507x is a MFD device, However, I still do not
understand why you do not attach OF data to the child platform device
representing touch screen when you create it.
>
> I gone through most of MFD devices in mainline kernel where
"of_find_node_by_name"
> function is used in order to populate child node properties.
> See below example of max8925 MFD device.
>
> Max8025 MFD device has following modules
> 1. Touch screen
> 2. Charger
> 3. Backlight
> 4. regulator
>
> In DT case, device node for max8925 MFD device is in
"arch/arm/boot/dts/mmp2-brownstone.dts"
> file having child nodes as regulator, backlight and charger.
> Respective drivers (regulator, backlight and charger) of max8925 MFD
device used
> "of_find_node_by_name" function in order to populate child node
properties.
>
> Here, also same case for TPS6507x MFD device
>
> TPS6507x MFD device has two childs:
> 1. regulator
> 2. touch screen.
>
> Regulator driver for TPS6507x is already in mainline and using function
> "of_find_node_by_name" to populate device tree properties for regulators.
> On similar lines I used "of_find_node_by_name" to populate device
> tree properties for touch screen.
>
> Still, I agreed that it is possible to attach OF data to child platform
device
> but it requires changes in MFD driver of TPS6507x.
>
> Please let me know your opinion about this.

Please let me know so accordingly I will make changes in code.

Regards
Manish Badarkhe

--20cf307f39c00c88c404e071478a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry<br><br>On Wed, Jun 12, 2013 at 12:23 PM, Vishwanathrao Badarkhe, =
Manish &lt;<a href=3D"mailto:manishv.b-l0cyMroinI0@public.gmane.org">manishv.b-l0cyMroinI0@public.gmane.org</a>&gt; wro=
te:<br>&gt; Hi Dmitry,<br>&gt;<br>&gt; On Mon, Jun 10, 2013 at 23:33:11, Dm=
itry Torokhov wrote:<br>
&gt;&gt; Manish,<br>&gt;&gt;<br>&gt;&gt; On Mon, Jun 10, 2013 at 10:23:16AM=
 +0000, Vishwanathrao Badarkhe, Manish wrote:<br>&gt;&gt; &gt; Hi Dmitry,<b=
r>&gt;&gt; &gt;<br>&gt;&gt; &gt; On Mon, Jun 10, 2013 at 11:34:42, Dmitry T=
orokhov wrote:<br>
&gt;&gt; &gt; &gt; Hi Manish,<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt; O=
n Tue, May 21, 2013 at 02:24:17PM +0530, Vishwanathrao Badarkhe, Manish wro=
te:<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 struct t=
ouchscreen_init_data *init_data =3D NULL;<br>
&gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 int err;<br>&gt;&gt; &gt; &gt; &gt; +=
<br>&gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 if (node)<br>&gt;&gt; &gt; &gt; &=
gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D of_find_node_by_name(node, &quot=
;tsc&quot;);<br>&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Why do you have to locate OF node manually instead of al=
ready having it attached to the device stucture?<br>&gt;&gt; &gt;<br>&gt;&g=
t; &gt; As TPS6507x is mfd device containing two nodes, regulator and touch=
screen.<br>
&gt;&gt; &gt; It is necessary to use &quot;of_find_node_by_name&quot; to fi=
nd child &quot;tsc&quot; node<br>&gt;&gt; &gt; of TPS6507x MFD device.<br>&=
gt;&gt;<br>&gt;&gt; I understand that TPS6507x is a MFD device, However, I =
still do not understand why you do not attach OF data to the child platform=
 device representing touch screen when you create it.<br>
&gt;<br>&gt; I gone through most of MFD devices in mainline kernel where &q=
uot;of_find_node_by_name&quot;<br>&gt; function is used in order to populat=
e child node properties.<br>&gt; See below example of max8925 MFD device.<b=
r>
&gt;<br>&gt; Max8025 MFD device has following modules<br>&gt; 1. Touch scre=
en<br>&gt; 2. Charger<br>&gt; 3. Backlight<br>&gt; 4. regulator<br>&gt;<br>=
&gt; In DT case, device node for max8925 MFD device is in &quot;arch/arm/bo=
ot/dts/mmp2-brownstone.dts&quot;<br>
&gt; file having child nodes as regulator, backlight and charger.<br>&gt; R=
espective drivers (regulator, backlight and charger) of max8925 MFD device =
used<br>&gt; &quot;of_find_node_by_name&quot; function in order to populate=
 child node properties.<br>
&gt;<br>&gt; Here, also same case for TPS6507x MFD device<br>&gt;<br>&gt; T=
PS6507x MFD device has two childs:<br>&gt; 1. regulator<br>&gt; 2. touch sc=
reen.<br>&gt;<br>&gt; Regulator driver for TPS6507x is already in mainline =
and using function<br>
&gt; &quot;of_find_node_by_name&quot; to populate device tree properties fo=
r regulators.<br>&gt; On similar lines I used &quot;of_find_node_by_name&qu=
ot; to populate device<br>&gt; tree properties for touch screen.<br>&gt;<br=
>
&gt; Still, I agreed that it is possible to attach OF data to child platfor=
m device<br>&gt; but it requires changes in MFD driver of TPS6507x.<br>&gt;=
<br>&gt; Please let me know your opinion about this.<br><br>Please let me k=
now so accordingly I will make changes in code.<br>
<br>Regards<br>Manish Badarkhe<br><br>

--20cf307f39c00c88c404e071478a--

--===============4150873186128155797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4150873186128155797==--
