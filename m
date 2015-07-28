From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Tue, 28 Jul 2015 08:42:34 +0100
Message-ID: <20150728074234.GM21114@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728054024.GA4558@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: S Twiss <stwiss.opensource@diasemi.com>, DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Mon, 27 Jul 2015, Dmitry Torokhov wrote:

> On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > From: S Twiss <stwiss.opensource@diasemi.com>
> > >=20
> > > Add device tree bindings for the DA9062 OnKey driver component
> > >=20
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > >=20
> > > ---
> > > Changes in V3:
> > >  - Child driver specifics separated out into separate document
> > >    in this case ../input/da9062-onkey.txt
> > > Changes in V2:
> > >  - No change
> > >=20
> > > This patch applies against linux-next and next-20150708=20
> > >=20
> > >=20
> > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++=
++++++++++++++
> > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> >=20
> > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > 9063, folded into the onkey patch and applied.
>=20
> Argh, da9062 core is not in mainline yet... OK, below is the patch I
> had; if Lee does not pick it up I'll re-apply it when da9062 core hit=
s
> mainline.

I guess all 3 patches should be taken though one tree?  Happy to take
them through MFD if that's okay with you.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
