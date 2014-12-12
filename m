From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 0/3] ARM:sunxi:ps2 Added support for
 A10/A20 ps2 controller.
Date: Fri, 12 Dec 2014 05:55:50 -0800 (PST)
Message-ID: <e46c1d5e-835f-466c-a26d-a94d23ea30c2@googlegroups.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
 <548AEA8E.6040100@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_548_930446024.1418392550442"
Return-path: <linux-sunxi+bncBD64TFVR3YIBBZ7HVOSAKGQEBH4BQPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <548AEA8E.6040100-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

------=_Part_548_930446024.1418392550442
Content-Type: multipart/alternative;
	boundary="----=_Part_549_30407914.1418392550442"

------=_Part_549_30407914.1418392550442
Content-Type: text/plain; charset=UTF-8

Hello Hans,
Thank you for testing it on A10 board. now we have PS2 working on A10 as 
well. :)

I'll include these in next version which I'm was about to send. 


On Friday, December 12, 2014 6:46:25 PM UTC+5:30, Hans de Goede wrote:
>
> Hi, 
>
> On 07-12-14 00:15, vishnupatekar wrote: 
> > Here is v2 of SUNXI PS2 controller support patch-set as with v1. 
>
> So as promised I've run this on an A10 board, with a small fix to 
> the interrupt property in the sun4i.dtsi file this works as is. 
>
> This means that the sun7i compat should be dropped, and the sun4i 
> compat used everywhere. 
>
> I've created 3 fixup patches to do this, note one also renames / moves 
> the bindings file as it is in the wrong place. 
>
> I've attached the 3 fixup patches, pleasesquash these into your 
> existing patches before posting the next version. 
>
> Thanks & Regards, 
>
> Hans 
>
>
> > 
> > Changes in v2: 
> > 1. added default n depends on ARCH_SUNXI || COMPILE_TEST in Kconfig. 
> > 2. handled errors and free resources on errors. 
> > 3. used BIT(x), DIV_ROUND_UP macros. 
> > 4. corrected style errors. 
> > 5. added support for A10 also, A10 and A2 have same properties of PS2 
> controller. 
> > 6. by default commented ps20 and ps21 nodes,as ps20 pins conflict with 
> HDMI 
> >     connector on Lime2 Board. 
> > 7. added compatible as allwinner,sun4i-a10-ps2. 
> > 8. corrected the possible race condition. 
> > 
> > Patch 0 Summary: Allwinner A10/A20 PS2 controller. These modifications 
> are 
> >         for PS2 host controller. IBM compliant IBM PS2 and AT-compatible 
> >         keyboard and mouse can be connected. 
> > 
> > Patch 1 device tree bindings. 
> > 
> > Patch 2 adds support for sun7i ps2 driver. 
> > 
> > Patch 3 device tree support for PS2 controller. 
> >   1) Added A10/A20 ps2 nodes to the dtsi 
> >   2) Added A10/A20 ps2 pinmux to the dtsi 
> >   3) Added ps2 nodes to the lime2 dts file 
> > 
> > vishnupatekar (3): 
> >    sunxi:dts-bindings:input:ps2 bindings for A10/A20 ps2. 
> >    sunxi:drivers:input:ps2 Added sunxi A10/A20 ps2 driver 
> >    ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2 controller. 
> > 
> >   .../bindings/input/allwinner,sunxi-ps2.txt         |   23 ++ 
> >   arch/arm/boot/dts/sun4i-a10.dtsi                   |   27 ++ 
> >   arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   13 + 
> >   arch/arm/boot/dts/sun7i-a20.dtsi                   |   29 ++ 
> >   drivers/input/serio/Kconfig                        |   10 + 
> >   drivers/input/serio/Makefile                       |    1 + 
> >   drivers/input/serio/sunxi-ps2.c                    |  364 
> ++++++++++++++++++++ 
> >   7 files changed, 467 insertions(+) 
> >   create mode 100644 
> Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt 
> >   create mode 100644 drivers/input/serio/sunxi-ps2.c 
> > 
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_549_30407914.1418392550442
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Hans,<div>Thank you for testing it on A10 board. now=
 we have PS2 working on A10 as well. :)</div><div><br></div><div>I'll inclu=
de these in next version which I'm was about to send.&nbsp;</div><div><br><=
/div><div><br>On Friday, December 12, 2014 6:46:25 PM UTC+5:30, Hans de Goe=
de wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: =
0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>On 07-12-14 00:15, vishnupatekar wrote:
<br>&gt; Here is v2 of SUNXI PS2 controller support patch-set as with v1.
<br>
<br>So as promised I've run this on an A10 board, with a small fix to
<br>the interrupt property in the sun4i.dtsi file this works as is.
<br>
<br>This means that the sun7i compat should be dropped, and the sun4i
<br>compat used everywhere.
<br>
<br>I've created 3 fixup patches to do this, note one also renames / moves
<br>the bindings file as it is in the wrong place.
<br>
<br>I've attached the 3 fixup patches, pleasesquash these into your
<br>existing patches before posting the next version.
<br>
<br>Thanks &amp; Regards,
<br>
<br>Hans
<br>
<br>
<br>&gt;
<br>&gt; Changes in v2:
<br>&gt; 1. added default n depends on ARCH_SUNXI || COMPILE_TEST in Kconfi=
g.
<br>&gt; 2. handled errors and free resources on errors.
<br>&gt; 3. used BIT(x), DIV_ROUND_UP macros.
<br>&gt; 4. corrected style errors.
<br>&gt; 5. added support for A10 also, A10 and A2 have same properties of =
PS2 controller.
<br>&gt; 6. by default commented ps20 and ps21 nodes,as ps20 pins conflict =
with HDMI
<br>&gt; &nbsp; &nbsp; connector on Lime2 Board.
<br>&gt; 7. added compatible as allwinner,sun4i-a10-ps2.
<br>&gt; 8. corrected the possible race condition.
<br>&gt;
<br>&gt; Patch 0 Summary: Allwinner A10/A20 PS2 controller. These modificat=
ions are
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for PS2 host contr=
oller. IBM compliant IBM PS2 and AT-compatible
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;keyboard and mouse=
 can be connected.
<br>&gt;
<br>&gt; Patch 1 device tree bindings.
<br>&gt;
<br>&gt; Patch 2 adds support for sun7i ps2 driver.
<br>&gt;
<br>&gt; Patch 3 device tree support for PS2 controller.
<br>&gt; &nbsp; 1) Added A10/A20 ps2 nodes to the dtsi
<br>&gt; &nbsp; 2) Added A10/A20 ps2 pinmux to the dtsi
<br>&gt; &nbsp; 3) Added ps2 nodes to the lime2 dts file
<br>&gt;
<br>&gt; vishnupatekar (3):
<br>&gt; &nbsp; &nbsp;sunxi:dts-bindings:input:ps2 bindings for A10/A20 ps2=
.
<br>&gt; &nbsp; &nbsp;sunxi:drivers:input:ps2 Added sunxi A10/A20 ps2 drive=
r
<br>&gt; &nbsp; &nbsp;ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2 controller=
.
<br>&gt;
<br>&gt; &nbsp; .../bindings/input/allwinner,<wbr>sunxi-ps2.txt &nbsp; &nbs=
p; &nbsp; &nbsp; | &nbsp; 23 ++
<br>&gt; &nbsp; arch/arm/boot/dts/sun4i-a10.<wbr>dtsi &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; 27 ++
<br>&gt; &nbsp; arch/arm/boot/dts/sun7i-a20-<wbr>olinuxino-lime2.dts &nbsp;=
 &nbsp;| &nbsp; 13 +
<br>&gt; &nbsp; arch/arm/boot/dts/sun7i-a20.<wbr>dtsi &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; 29 ++
<br>&gt; &nbsp; drivers/input/serio/Kconfig &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; 10 +
<br>&gt; &nbsp; drivers/input/serio/Makefile &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp;1 +
<br>&gt; &nbsp; drivers/input/serio/sunxi-ps2.<wbr>c &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;364 ++++++++++++++++=
++++
<br>&gt; &nbsp; 7 files changed, 467 insertions(+)
<br>&gt; &nbsp; create mode 100644 Documentation/devicetree/<wbr>bindings/i=
nput/allwinner,<wbr>sunxi-ps2.txt
<br>&gt; &nbsp; create mode 100644 drivers/input/serio/sunxi-ps2.<wbr>c
<br>&gt;
<br></blockquote></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_549_30407914.1418392550442--

------=_Part_548_930446024.1418392550442--
