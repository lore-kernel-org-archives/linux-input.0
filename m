From: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 5/5] Input: Add ChromeOS EC keyboard driver
Date: Wed, 19 Dec 2012 12:20:03 -0800
Message-ID: <CAPnjgZ2MH_iD73oOZe7pEEAVg_8c5dFWHdeaNfD6A4E9NeWRug@mail.gmail.com>
References: <1355348028-19017-1-git-send-email-sjg@chromium.org>
 <1355348028-19017-6-git-send-email-sjg@chromium.org>
 <20121215011345.9D5973E0BEE@localhost>
 <2990462.l5jY89jKQx@dtor-d630.eng.vmware.com>
 <20121219125722.DCD3E3E0AD7@localhost>
 <20121219181643.GA31435@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0886577501179963914=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121219181643.GA31435-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
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
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Luigi Semenzato <semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--===============0886577501179963914==
Content-Type: multipart/alternative; boundary=14dae93a1145ed1c7104d13a566d

--14dae93a1145ed1c7104d13a566d
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Dec 19, 2012 at 10:16 AM, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> wrote:

> On Wed, Dec 19, 2012 at 12:57:22PM +0000, Grant Likely wrote:
> > On Fri, 14 Dec 2012 17:43:31 -0800, Dmitry Torokhov <
> dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On Saturday, December 15, 2012 01:13:45 AM Grant Likely wrote:
> > > > On Wed, 12 Dec 2012 13:33:48 -0800, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> wrote:
> > > > > Use the key-matrix layer to interpret key scan information from
> the EC
> > > > > and inject input based on the FDT-supplied key map. This driver
> registers
> > > > > itself with the ChromeOS EC driver to perform communications.
> > > > >
> > > > > Additional FDT bindings are provided to specify rows/columns and
> the
> > > > > auto-repeat information.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > > Signed-off-by: Luigi Semenzato <semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > > Signed-off-by: Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > > ---
> > > > >
> > > > >  .../devicetree/bindings/input/cros-ec-keyb.txt     |   77 ++++
> > > > >  drivers/input/keyboard/Kconfig                     |   10 +
> > > > >  drivers/input/keyboard/Makefile                    |    1 +
> > > > >  drivers/input/keyboard/cros_ec_keyb.c              |  413
> > > > >  ++++++++++++++++++++ 4 files changed, 501 insertions(+), 0
> deletions(-)
> > > > >  create mode 100644
> > > > >  Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> > > > >  create mode 100644 drivers/input/keyboard/cros_ec_keyb.c
> > > > >
> > > > > diff --git
> a/Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> > > > > b/Documentation/devicetree/bindings/input/cros-ec-keyb.txt new
> file mode
> > > > > 100644
> > > > > index 0000000..67f51d8
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> > > > > @@ -0,0 +1,77 @@
> > > > > +ChromeOS EC Keyboard
> > > > > +
> > > > > +Google's ChromeOS EC Keyboard is a simple matrix keyboard
> implemented on
> > > > > +a separate EC (Embedded Controller) device. It provides a message
> for
> > > > > reading +key scans from the EC. These are then converted into
> keycodes
> > > > > for processing +by the kernel.
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible: "google,cros-ec-keyb"
> > > > > +- google,key-rows: Number of keyboard rows (must be <= 8)
> > > > > +- google,key-columns: Number of keyboard columns (must be <= 13)
> > > > > +- google,repeat-delay-ms: Key repeat delay in milliseconds
> > > > > +- google,repeat-rate-ms: Key repeat rate in milliseconds
> > > >
> > > > Hmmm, these should probably be in a common binding. Take a look at
> > > > the other input bindings and make a proposal for properties to add to
> > > > matrix-keymap.txt.
> > >
> > > Actually these are not essentia for bringup and can be set from
> userspace,
> > > so I'd say simply drop them.
> >
> > Aren't they needed for a working keyboard? If so, I would really think
> > they should be set correctly without userspace intervention.
>
> I am sorry if I was unclear, but I was actually talking about the last
> 2: repeat-delay-ms and repeat-rate-ms. Input core has I believe sane
> defaults (250 msec delay, 33 cps autorepeat) and user can adjust if
> other rate is preferred.
>

I seems like I should remove these two, then.

It would be nice if we could keep these parameters so that the keyboard
doesn't require user-space set up to work, but I understand and agree they
are not essential. Regarding Grant's request to come up with a common
binding, if I remove these then that is not needed, right?

Regards,
Simon


> Thanks.
>
> --
> Dmitry
>

--14dae93a1145ed1c7104d13a566d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style=3D"font-family: arial, helvetica, sans-serif; font-size: 10pt"><=
div dir=3D"ltr"><div class=3D"gmail_default" style>On Wed, Dec 19, 2012 at =
10:16 AM, Dmitry Torokhov <span dir=3D"ltr">&lt;<a href=3D"mailto:dmitry.to=
rokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span=
> wrote:<br>
</div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Wed, Dec 19, 201=
2 at 12:57:22PM +0000, Grant Likely wrote:<br>

&gt; On Fri, 14 Dec 2012 17:43:31 -0800, Dmitry Torokhov &lt;<a href=3D"mai=
lto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; On Saturday, December 15, 2012 01:13:45 AM Grant Likely wrote:<br=
>
&gt; &gt; &gt; On Wed, 12 Dec 2012 13:33:48 -0800, Simon Glass &lt;<a href=
=3D"mailto:sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; Use the key-matrix layer to interpret key scan informat=
ion from the EC<br>
&gt; &gt; &gt; &gt; and inject input based on the FDT-supplied key map. Thi=
s driver registers<br>
&gt; &gt; &gt; &gt; itself with the ChromeOS EC driver to perform communica=
tions.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Additional FDT bindings are provided to specify rows/co=
lumns and the<br>
&gt; &gt; &gt; &gt; auto-repeat information.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Simon Glass &lt;<a href=3D"mailto:sjg@ch=
romium.org">sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Luigi Semenzato &lt;<a href=3D"mailto:se=
menzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">semenzato-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Vincent Palatin &lt;<a href=3D"mailto:vp=
alatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; =A0.../devicetree/bindings/input/cros-ec-keyb.txt =A0 =
=A0 | =A0 77 ++++<br>
&gt; &gt; &gt; &gt; =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | =A0 10 +<br>
&gt; &gt; &gt; &gt; =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0| =A0 =A01 +<br>
&gt; &gt; &gt; &gt; =A0drivers/input/keyboard/cros_ec_keyb.c =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0413<br>
&gt; &gt; &gt; &gt; =A0++++++++++++++++++++ 4 files changed, 501 insertions=
(+), 0 deletions(-)<br>
&gt; &gt; &gt; &gt; =A0create mode 100644<br>
&gt; &gt; &gt; &gt; =A0Documentation/devicetree/bindings/input/cros-ec-keyb=
.txt<br>
&gt; &gt; &gt; &gt; =A0create mode 100644 drivers/input/keyboard/cros_ec_ke=
yb.c<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/Documentation/devicetree/bindings/input/cr=
os-ec-keyb.txt<br>
&gt; &gt; &gt; &gt; b/Documentation/devicetree/bindings/input/cros-ec-keyb.=
txt new file mode<br>
&gt; &gt; &gt; &gt; 100644<br>
&gt; &gt; &gt; &gt; index 0000000..67f51d8<br>
&gt; &gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; &gt; +++ b/Documentation/devicetree/bindings/input/cros-ec-k=
eyb.txt<br>
&gt; &gt; &gt; &gt; @@ -0,0 +1,77 @@<br>
&gt; &gt; &gt; &gt; +ChromeOS EC Keyboard<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +Google&#39;s ChromeOS EC Keyboard is a simple matrix k=
eyboard implemented on<br>
&gt; &gt; &gt; &gt; +a separate EC (Embedded Controller) device. It provide=
s a message for<br>
&gt; &gt; &gt; &gt; reading +key scans from the EC. These are then converte=
d into keycodes<br>
&gt; &gt; &gt; &gt; for processing +by the kernel.<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +Required properties:<br>
&gt; &gt; &gt; &gt; +- compatible: &quot;google,cros-ec-keyb&quot;<br>
&gt; &gt; &gt; &gt; +- google,key-rows: Number of keyboard rows (must be &l=
t;=3D 8)<br>
&gt; &gt; &gt; &gt; +- google,key-columns: Number of keyboard columns (must=
 be &lt;=3D 13)<br>
&gt; &gt; &gt; &gt; +- google,repeat-delay-ms: Key repeat delay in millisec=
onds<br>
&gt; &gt; &gt; &gt; +- google,repeat-rate-ms: Key repeat rate in millisecon=
ds<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hmmm, these should probably be in a common binding. Take a l=
ook at<br>
&gt; &gt; &gt; the other input bindings and make a proposal for properties =
to add to<br>
&gt; &gt; &gt; matrix-keymap.txt.<br>
&gt; &gt;<br>
&gt; &gt; Actually these are not essentia for bringup and can be set from u=
serspace,<br>
&gt; &gt; so I&#39;d say simply drop them.<br>
&gt;<br>
&gt; Aren&#39;t they needed for a working keyboard? If so, I would really t=
hink<br>
&gt; they should be set correctly without userspace intervention.<br>
<br>
</div></div>I am sorry if I was unclear, but I was actually talking about t=
he last<br>
2: repeat-delay-ms and repeat-rate-ms. Input core has I believe sane<br>
defaults (250 msec delay, 33 cps autorepeat) and user can adjust if<br>
other rate is preferred.<br></blockquote><div><br></div><div style>I seems =
like I should remove these two, then.</div><div style><br></div><div style>=
It would be nice if we could keep these parameters so that the keyboard doe=
sn&#39;t require user-space set up to work, but I understand and agree they=
 are not essential. Regarding Grant&#39;s request to come up with a common =
binding, if I remove these then that is not needed, right?</div>
<div style><br></div><div style>Regards,</div><div style>Simon</div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Dmitry<br>
</font></span></blockquote></div><br></div></div></div>

--14dae93a1145ed1c7104d13a566d--

--===============0886577501179963914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0886577501179963914==--
