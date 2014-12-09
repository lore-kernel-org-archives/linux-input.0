From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 1/3] sunxi:dts-bindings:input:ps2 bindings
 for A10/A20 ps2.
Date: Tue, 9 Dec 2014 02:21:28 -0800 (PST)
Message-ID: <84ef8f93-8c51-4ab0-8714-a6714f6766bd@googlegroups.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
 <1417907719-26775-2-git-send-email-VishnuPatekar0510@gmail.com>
 <20141208221509.GM8739@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16_1457337234.1418120489014"
Return-path: <linux-sunxi+bncBD64TFVR3YIBBKU2TOSAKGQEMNSAXDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141208221509.GM8739@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

------=_Part_16_1457337234.1418120489014
Content-Type: multipart/alternative;
	boundary="----=_Part_17_1415897803.1418120489014"

------=_Part_17_1415897803.1418120489014
Content-Type: text/plain; charset=UTF-8

Hello,

On Tuesday, December 9, 2014 3:50:05 AM UTC+5:30, Maxime Ripard wrote:
>
> Hi, 
>
> On Sun, Dec 07, 2014 at 04:45:17AM +0530, vishnupatekar wrote: 
> > A10 and A20 have same PS2 addresses, clocks, interrupts. 
> > added compatible as allwinner,sun4i-a10-ps2. 
> > 
> > Signed-off-by: vishnupatekar <VishnuPa...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>> 
>
> You should have your real name here. 
>
This is my real Name. Vishnu Patekar  :)

>
> > --- 
> >  .../bindings/input/allwinner,sunxi-ps2.txt         |   23 
> ++++++++++++++++++++ 
> >  1 file changed, 23 insertions(+) 
> >  create mode 100644 
> Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt 
> > 
> > diff --git 
> a/Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt 
> b/Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt 
> > new file mode 100644 
> > index 0000000..3a8919a 
> > --- /dev/null 
> > +++ b/Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt 
> > @@ -0,0 +1,23 @@ 
> > +* Device tree bindings for Allwinner A10, A20 PS2 host controller 
>
> > +A20 PS2 is dual role controller(PS2 host and PS2 device). These 
> > +bindings are for PS2 host controller. IBM compliant IBM PS2 and 
> > AT-compatible keyboard and mouse can be connected. 
>
> This should be wrapped to 80 chars. 
>
> Okie.
 

> > +Required properties: 
> > + 
> > + - reg             : Offset and length of the register set for the 
> device. 
> > + - compatible      : Should one of the following: 
> > +                     - "allwinner,sun7i-a20-ps2" 
> > +                     - "allwinner,sun4i-a10-ps2" 
> > + - interrupts      : The interrupt line connected to the PS2. 
> > + - clocks          : The gate clk connected to the PS2. 
> > + 
> > + 
> > +Example: 
> > +        ps20: ps2@0x01c2a000 { 
> > +                compatible = "allwinner,sun7i-a20-ps2"; 
> > +                reg = <0x01c2a000 0x400>; 
> > +                interrupts = <0 62 4>; 
> > +                clocks = <&apb1_gates 6>; 
> > +                status = "disabled"; 
> > +        }; 
> > -- 
> > 1.7.9.5 
> > 
>
> -- 
> Maxime Ripard, Free Electrons 
> Embedded Linux, Kernel and Android engineering 
> http://free-electrons.com 
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_17_1415897803.1418120489014
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>On Tuesday, December 9, 2014 3:50:05 AM UTC+=
5:30, Maxime Ripard wrote:<blockquote class=3D"gmail_quote" style=3D"margin=
: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>On Sun, Dec 07, 2014 at 04:45:17AM +0530, vishnupatekar wrote:
<br>&gt; A10 and A20 have same PS2 addresses, clocks, interrupts.
<br>&gt; added compatible as allwinner,sun4i-a10-ps2.
<br>&gt;=20
<br>&gt; Signed-off-by: vishnupatekar &lt;<a href=3D"javascript:" target=3D=
"_blank" gdf-obfuscated-mailto=3D"NwaeSQeYkOwJ" onmousedown=3D"this.href=3D=
'javascript:';return true;" onclick=3D"this.href=3D'javascript:';return tru=
e;">VishnuPa...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
<br>
<br>You should have your real name here.
<br></blockquote><div>This is my real Name. Vishnu Patekar &nbsp;:)</div><b=
lockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;borde=
r-left: 1px #ccc solid;padding-left: 1ex;">
<br>&gt; ---
<br>&gt; &nbsp;.../bindings/input/allwinner,<wbr>sunxi-ps2.txt &nbsp; &nbsp=
; &nbsp; &nbsp; | &nbsp; 23 ++++++++++++++++++++
<br>&gt; &nbsp;1 file changed, 23 insertions(+)
<br>&gt; &nbsp;create mode 100644 Documentation/devicetree/<wbr>bindings/in=
put/allwinner,<wbr>sunxi-ps2.txt
<br>&gt;=20
<br>&gt; diff --git a/Documentation/devicetree/<wbr>bindings/input/allwinne=
r,<wbr>sunxi-ps2.txt b/Documentation/devicetree/<wbr>bindings/input/allwinn=
er,<wbr>sunxi-ps2.txt
<br>&gt; new file mode 100644
<br>&gt; index 0000000..3a8919a
<br>&gt; --- /dev/null
<br>&gt; +++ b/Documentation/devicetree/<wbr>bindings/input/allwinner,<wbr>=
sunxi-ps2.txt
<br>&gt; @@ -0,0 +1,23 @@
<br>&gt; +* Device tree bindings for Allwinner A10, A20 PS2 host controller
<br>
<br>&gt; +A20 PS2 is dual role controller(PS2 host and PS2 device). These
<br>&gt; +bindings are for PS2 host controller. IBM compliant IBM PS2 and
<br>&gt; AT-compatible keyboard and mouse can be connected.
<br>
<br>This should be wrapped to 80 chars.
<br>
<br></blockquote><div>Okie.</div><div>&nbsp;</div><blockquote class=3D"gmai=
l_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;=
padding-left: 1ex;">&gt; +Required properties:
<br>&gt; +
<br>&gt; + - reg &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : Offset and len=
gth of the register set for the device.
<br>&gt; + - compatible &nbsp; &nbsp; &nbsp;: Should one of the following:
<br>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; - "allwinner,sun7i-a20-ps2"
<br>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; - "allwinner,sun4i-a10-ps2"
<br>&gt; + - interrupts &nbsp; &nbsp; &nbsp;: The interrupt line connected =
to the PS2.
<br>&gt; + - clocks &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: The gate clk connec=
ted to the PS2.
<br>&gt; +
<br>&gt; +
<br>&gt; +Example:
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ps20: ps2@0x01c2a=
000 {
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible =3D "allwinner,sun7i-a20-ps2";
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg =3D &lt;0x01c2a000 0x400&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts =3D &lt;0 62 4&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;clocks =3D &lt;&amp;apb1_gates 6&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status =3D "disabled";
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};
<br>&gt; --=20
<br>&gt; 1.7.9.5
<br>&gt;=20
<br>
<br>--=20
<br>Maxime Ripard, Free Electrons
<br>Embedded Linux, Kernel and Android engineering
<br><a href=3D"http://free-electrons.com" target=3D"_blank" onmousedown=3D"=
this.href=3D'http://www.google.com/url?q\75http%3A%2F%2Ffree-electrons.com\=
46sa\75D\46sntz\0751\46usg\75AFQjCNGC8C9pT7xKJEabITLGL5cqtolifQ';return tru=
e;" onclick=3D"this.href=3D'http://www.google.com/url?q\75http%3A%2F%2Ffree=
-electrons.com\46sa\75D\46sntz\0751\46usg\75AFQjCNGC8C9pT7xKJEabITLGL5cqtol=
ifQ';return true;">http://free-electrons.com</a>
<br></blockquote></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_17_1415897803.1418120489014--

------=_Part_16_1457337234.1418120489014--
