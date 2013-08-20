From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 1/2] tps6507x-ts: Add DT support
Date: Tue, 20 Aug 2013 11:26:32 +0530
Message-ID: <CAKDJKT5cxk7a6RF0XpwH4Az8RmnH1k6dCd5w0+k9_9-aBm_ksA@mail.gmail.com>
References: <1369126458-24872-1-git-send-email-manishv.b@ti.com>
	<1369126458-24872-2-git-send-email-manishv.b@ti.com>
	<20130610060442.GA30158@core.coreip.homeip.net>
	<A4887BF146CD57468F700B415D2F47015A0DFD@DBDE04.ent.ti.com>
	<20130610180311.GA4649@core.coreip.homeip.net>
	<A4887BF146CD57468F700B415D2F47015A1315@DBDE04.ent.ti.com>
	<CAKDJKT6UETVpPT9B6LE59_EMrxNGpTmUiu9iddHoWOYhGpHP3Q@mail.gmail.com>
	<CAKDJKT500ewMEv-f-vZBkMELkFkNBXLrv0oS_qUivbq0T-Y6yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1969535587=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <CAKDJKT500ewMEv-f-vZBkMELkFkNBXLrv0oS_qUivbq0T-Y6yA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--===============1969535587==
Content-Type: multipart/alternative; boundary="047d7b15b2a500da4504e45ab83f"

--047d7b15b2a500da4504e45ab83f
Content-Type: text/plain; charset="ISO-8859-1"

Hi Dmitry,

On Mon, Jul 29, 2013 at 11:47 AM, Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> wrote:

> Hi Dmitry
>
> On Mon, Jul 1, 2013 at 4:40 PM, Manish Badarkhe
> <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hi Dmitry
> >
> >
> > On Wed, Jun 12, 2013 at 12:23 PM, Vishwanathrao Badarkhe, Manish
> > <manishv.b-l0cyMroinI0@public.gmane.org> wrote:
> > > Hi Dmitry,
> > >
> > > On Mon, Jun 10, 2013 at 23:33:11, Dmitry Torokhov wrote:
> > >> Manish,
> > >>
> > >> On Mon, Jun 10, 2013 at 10:23:16AM +0000, Vishwanathrao Badarkhe,
> > >> Manish wrote:
> > >> > Hi Dmitry,
> > >> >
> > >> > On Mon, Jun 10, 2013 at 11:34:42, Dmitry Torokhov wrote:
> > >> > > Hi Manish,
> > >> > >
> > >> > > On Tue, May 21, 2013 at 02:24:17PM +0530, Vishwanathrao Badarkhe,
> > >> > > Manish wrote:
> > >> > >
> > >> > > > +       struct touchscreen_init_data *init_data = NULL;
> > >> > > > +       int err;
> > >> > > > +
> > >> > > > +       if (node)
> > >> > > > +               node = of_find_node_by_name(node, "tsc");
> > >> > >
> > >> > > Why do you have to locate OF node manually instead of already
> > >> > > having it attached to the device stucture?
> > >> >
> > >> > As TPS6507x is mfd device containing two nodes, regulator and
> > >> > touchscreen.
> > >> > It is necessary to use "of_find_node_by_name" to find child "tsc"
> > >> > node
> > >> > of TPS6507x MFD device.
> > >>
> > >> I understand that TPS6507x is a MFD device, However, I still do not
> > >> understand why you do not attach OF data to the child platform device
> > >> representing touch screen when you create it.
> > >
> > > I gone through most of MFD devices in mainline kernel where
> > > "of_find_node_by_name"
> > > function is used in order to populate child node properties.
> > > See below example of max8925 MFD device.
> > >
> > > Max8025 MFD device has following modules
> > > 1. Touch screen
> > > 2. Charger
> > > 3. Backlight
> > > 4. regulator
> > >
> > > In DT case, device node for max8925 MFD device is in
> > > "arch/arm/boot/dts/mmp2-brownstone.dts"
> > > file having child nodes as regulator, backlight and charger.
> > > Respective drivers (regulator, backlight and charger) of max8925 MFD
> > > device used
> > > "of_find_node_by_name" function in order to populate child node
> > > properties.
> > >
> > > Here, also same case for TPS6507x MFD device
> > >
> > > TPS6507x MFD device has two childs:
> > > 1. regulator
> > > 2. touch screen.
> > >
> > > Regulator driver for TPS6507x is already in mainline and using function
> > > "of_find_node_by_name" to populate device tree properties for
> > > regulators.
> > > On similar lines I used "of_find_node_by_name" to populate device
> > > tree properties for touch screen.
> > >
> > > Still, I agreed that it is possible to attach OF data to child platform
> > > device
> > > but it requires changes in MFD driver of TPS6507x.
> > >
> > > Please let me know your opinion about this.
> >
> > Please let me know so accordingly I will make changes in code.
> >
>
> Please provide your comments so accordingly will make changes in code.
>
>    Please let me know your comments so I will do necessary modifications
   and post this series again.

Regards
Manish Badarkhe

--047d7b15b2a500da4504e45ab83f
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Dmitry,<br><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Mon, Jul 29, 2013 at 11:47 AM, Manish Badarkhe <span dir=
=3D"ltr">&lt;<a href=3D"mailto:badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank"=
>badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Dmitry<br>
<div><div class=3D"h5"><br>
On Mon, Jul 1, 2013 at 4:40 PM, Manish Badarkhe<br>
&lt;<a href=3D"mailto:badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Dmitry<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Jun 12, 2013 at 12:23 PM, Vishwanathrao Badarkhe, Manish<br>
&gt; &lt;<a href=3D"mailto:manishv.b-l0cyMroinI0@public.gmane.org">manishv.b-l0cyMroinI0@public.gmane.org</a>&gt; wrote=
:<br>
&gt; &gt; Hi Dmitry,<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Jun 10, 2013 at 23:33:11, Dmitry Torokhov wrote:<br>
&gt; &gt;&gt; Manish,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Mon, Jun 10, 2013 at 10:23:16AM +0000, Vishwanathrao Badar=
khe,<br>
&gt; &gt;&gt; Manish wrote:<br>
&gt; &gt;&gt; &gt; Hi Dmitry,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; On Mon, Jun 10, 2013 at 11:34:42, Dmitry Torokhov wrote:=
<br>
&gt; &gt;&gt; &gt; &gt; Hi Manish,<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; On Tue, May 21, 2013 at 02:24:17PM +0530, Vishwanat=
hrao Badarkhe,<br>
&gt; &gt;&gt; &gt; &gt; Manish wrote:<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 struct touchscreen_init_data *in=
it_data =3D NULL;<br>
&gt; &gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 int err;<br>
&gt; &gt;&gt; &gt; &gt; &gt; +<br>
&gt; &gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 if (node)<br>
&gt; &gt;&gt; &gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D of_find=
_node_by_name(node, &quot;tsc&quot;);<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Why do you have to locate OF node manually instead =
of already<br>
&gt; &gt;&gt; &gt; &gt; having it attached to the device stucture?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; As TPS6507x is mfd device containing two nodes, regulato=
r and<br>
&gt; &gt;&gt; &gt; touchscreen.<br>
&gt; &gt;&gt; &gt; It is necessary to use &quot;of_find_node_by_name&quot; =
to find child &quot;tsc&quot;<br>
&gt; &gt;&gt; &gt; node<br>
&gt; &gt;&gt; &gt; of TPS6507x MFD device.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I understand that TPS6507x is a MFD device, However, I still =
do not<br>
&gt; &gt;&gt; understand why you do not attach OF data to the child platfor=
m device<br>
&gt; &gt;&gt; representing touch screen when you create it.<br>
&gt; &gt;<br>
&gt; &gt; I gone through most of MFD devices in mainline kernel where<br>
&gt; &gt; &quot;of_find_node_by_name&quot;<br>
&gt; &gt; function is used in order to populate child node properties.<br>
&gt; &gt; See below example of max8925 MFD device.<br>
&gt; &gt;<br>
&gt; &gt; Max8025 MFD device has following modules<br>
&gt; &gt; 1. Touch screen<br>
&gt; &gt; 2. Charger<br>
&gt; &gt; 3. Backlight<br>
&gt; &gt; 4. regulator<br>
&gt; &gt;<br>
&gt; &gt; In DT case, device node for max8925 MFD device is in<br>
&gt; &gt; &quot;arch/arm/boot/dts/mmp2-brownstone.dts&quot;<br>
&gt; &gt; file having child nodes as regulator, backlight and charger.<br>
&gt; &gt; Respective drivers (regulator, backlight and charger) of max8925 =
MFD<br>
&gt; &gt; device used<br>
&gt; &gt; &quot;of_find_node_by_name&quot; function in order to populate ch=
ild node<br>
&gt; &gt; properties.<br>
&gt; &gt;<br>
&gt; &gt; Here, also same case for TPS6507x MFD device<br>
&gt; &gt;<br>
&gt; &gt; TPS6507x MFD device has two childs:<br>
&gt; &gt; 1. regulator<br>
&gt; &gt; 2. touch screen.<br>
&gt; &gt;<br>
&gt; &gt; Regulator driver for TPS6507x is already in mainline and using fu=
nction<br>
&gt; &gt; &quot;of_find_node_by_name&quot; to populate device tree properti=
es for<br>
&gt; &gt; regulators.<br>
&gt; &gt; On similar lines I used &quot;of_find_node_by_name&quot; to popul=
ate device<br>
&gt; &gt; tree properties for touch screen.<br>
&gt; &gt;<br>
&gt; &gt; Still, I agreed that it is possible to attach OF data to child pl=
atform<br>
&gt; &gt; device<br>
&gt; &gt; but it requires changes in MFD driver of TPS6507x.<br>
&gt; &gt;<br>
&gt; &gt; Please let me know your opinion about this.<br>
&gt;<br>
&gt; Please let me know so accordingly I will make changes in code.<br>
&gt;<br>
<br>
</div></div>Please provide your comments so accordingly will make changes i=
n code.<br>
<br></blockquote></div>=A0=A0 Please let me know your comments so I will do=
 necessary modifications <br>=A0=A0 and post this series again.<br><br></di=
v><div class=3D"gmail_extra">Regards<br></div><div class=3D"gmail_extra">Ma=
nish Badarkhe<br>
</div></div>

--047d7b15b2a500da4504e45ab83f--

--===============1969535587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1969535587==--
