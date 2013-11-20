From: Martino Brandolini <martinobrandolini@gmail.com>
Subject: Re: [Ac100] [PATCH 00/31] ARM: tegra: use common reset and DMA
	bindings
Date: Wed, 20 Nov 2013 20:17:33 +0100
Message-ID: <CAOvQ+ewaVfBA5jjpoUVxqypwfYFaCc_WK=h9JAOq+Mkj9VF0SQ@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
	<201311201637.36733.arnd@arndb.de> <528CE71D.5090300@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0904339317=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <528CE71D.5090300@wwwdotorg.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org, ac100@lists.launchpad.net, devel@driverdev.osuosl.org, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, =?ISO-8859-1?Q?Terje_Bergstr=F6m?= <tbergstrom@nvidia.com>, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, treding@nvidia.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Julian Andres Klode <jak@jak-linux.org>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Mike Turquette <mturquette@linaro.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-input@vger.kernel.org

--===============0904339317==
Content-Type: multipart/alternative; boundary=047d7bdc0e3e114c7c04eba0a2b1

--047d7bdc0e3e114c7c04eba0a2b1
Content-Type: text/plain; charset=ISO-8859-1

Dear all,
My ac100 screen is flickering so much. I realized I'm not using it anymore.
So if anyone wants to have it for free would be for me a huge pleasure to
give it away. I'm based in milan and I'll be in London for the next week.
Maybe someone needs it.

Martino


2013/11/20 Stephen Warren <swarren@wwwdotorg.org>

> On 11/20/2013 08:37 AM, Arnd Bergmann wrote:
> > On Friday 15 November 2013, Stephen Warren wrote:
> >> This series implements a common reset framework driver for Tegra, and
> >> updates all relevant Tegra drivers to use it. It also removes the custom
> >> DMA bindings and replaced them with the standard DMA DT bindings.
> >
> > The series is rather long, so I may have missed it, but I think you need
> one
> > more patch to the apbdma binding to document the use of #dma-cells, what
> > value it has, and what the format of the dma specifiers in slave drivers
> > needs to be.
>
> Yes, you're right. I will fold the following into "ARM: tegra: document
> use of standard DMA DT bindings":
>
> > diff --git a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> > index 0b1e577ab9d3..0b0f9498e265 100644
> > --- a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
> > @@ -11,6 +11,10 @@ Required properties:
> >    See ../reset/reset.txt for details.
> >  - reset-names : Must include the following entries:
> >    - dma
> > +- #iommu-cells : Must be <1>. This dictates the length of DMA
> specifiers in
> > +  client nodes' dmas properties. The specifier represents the DMA
> request
> > +  select value for the peripheral. For more details, consult the Tegra
> TRM's
> > +  documentation of the APB DMA channel control register REQ_SEL field.
> >
> >  Examples:
> >
> > @@ -36,4 +40,5 @@ apbdma: dma@6000a000 {
> >       clocks = <&tegra_car 34>;
> >       resets = <&tegra_car 34>;
> >       reset-names = "dma";
> > +     #iommu-cells = <1>;
> >  };
>
>
> _______________________________________________
> Mailing list: https://launchpad.net/~ac100
> Post to     : ac100@lists.launchpad.net
> Unsubscribe : https://launchpad.net/~ac100
> More help   : https://help.launchpad.net/ListHelp
>

--047d7bdc0e3e114c7c04eba0a2b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear all,<div>My ac100 screen is flickering so much. I rea=
lized I&#39;m not using it anymore. So if anyone wants to have it for free =
would be for me a huge pleasure to give it away. I&#39;m based in milan and=
 I&#39;ll be in London for the next week. Maybe someone needs it.</div>
<div><br></div><div>Martino</div></div><div class=3D"gmail_extra"><br><br><=
div class=3D"gmail_quote">2013/11/20 Stephen Warren <span dir=3D"ltr">&lt;<=
a href=3D"mailto:swarren@wwwdotorg.org" target=3D"_blank">swarren@wwwdotorg=
.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 11/20/2013 08:37 AM, Arnd Bergmann wrote:=
<br>
&gt; On Friday 15 November 2013, Stephen Warren wrote:<br>
&gt;&gt; This series implements a common reset framework driver for Tegra, =
and<br>
&gt;&gt; updates all relevant Tegra drivers to use it. It also removes the =
custom<br>
&gt;&gt; DMA bindings and replaced them with the standard DMA DT bindings.<=
br>
&gt;<br>
&gt; The series is rather long, so I may have missed it, but I think you ne=
ed one<br>
&gt; more patch to the apbdma binding to document the use of #dma-cells, wh=
at<br>
&gt; value it has, and what the format of the dma specifiers in slave drive=
rs<br>
&gt; needs to be.<br>
<br>
Yes, you&#39;re right. I will fold the following into &quot;ARM: tegra: doc=
ument<br>
use of standard DMA DT bindings&quot;:<br>
<br>
&gt; diff --git a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt =
b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt<br>
&gt; index 0b1e577ab9d3..0b0f9498e265 100644<br>
&gt; --- a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt<br>
&gt; +++ b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt<br>
&gt; @@ -11,6 +11,10 @@ Required properties:<br>
&gt; =A0 =A0See ../reset/reset.txt for details.<br>
&gt; =A0- reset-names : Must include the following entries:<br>
&gt; =A0 =A0- dma<br>
&gt; +- #iommu-cells : Must be &lt;1&gt;. This dictates the length of DMA s=
pecifiers in<br>
&gt; + =A0client nodes&#39; dmas properties. The specifier represents the D=
MA request<br>
&gt; + =A0select value for the peripheral. For more details, consult the Te=
gra TRM&#39;s<br>
&gt; + =A0documentation of the APB DMA channel control register REQ_SEL fie=
ld.<br>
&gt;<br>
&gt; =A0Examples:<br>
&gt;<br>
&gt; @@ -36,4 +40,5 @@ apbdma: dma@6000a000 {<br>
&gt; =A0 =A0 =A0 clocks =3D &lt;&amp;tegra_car 34&gt;;<br>
&gt; =A0 =A0 =A0 resets =3D &lt;&amp;tegra_car 34&gt;;<br>
&gt; =A0 =A0 =A0 reset-names =3D &quot;dma&quot;;<br>
&gt; + =A0 =A0 #iommu-cells =3D &lt;1&gt;;<br>
&gt; =A0};<br>
<br>
<br>
_______________________________________________<br>
Mailing list: <a href=3D"https://launchpad.net/~ac100" target=3D"_blank">ht=
tps://launchpad.net/~ac100</a><br>
Post to =A0 =A0 : <a href=3D"mailto:ac100@lists.launchpad.net">ac100@lists.=
launchpad.net</a><br>
Unsubscribe : <a href=3D"https://launchpad.net/~ac100" target=3D"_blank">ht=
tps://launchpad.net/~ac100</a><br>
More help =A0 : <a href=3D"https://help.launchpad.net/ListHelp" target=3D"_=
blank">https://help.launchpad.net/ListHelp</a><br>
</blockquote></div><br></div>

--047d7bdc0e3e114c7c04eba0a2b1--

--===============0904339317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0904339317==--
