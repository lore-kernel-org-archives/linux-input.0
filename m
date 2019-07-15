From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/2] drm/bridge: sil_sii8620: make remote control optional.
Date: Mon, 15 Jul 2019 13:00:34 -0700
Message-ID: <CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com>
References: <20190419081926.13567-1-ronald@innovation.ch> <20190419081926.13567-2-ronald@innovation.ch>
 <CGME20190702135052eucas1p11e2621af0514505789c7947b84cf133c@eucas1p1.samsung.com>
 <2d0fe94c-a2c9-a8f6-967f-c33b53e86518@samsung.com> <20190703063956.GA32102@innovation.ch>
 <20190715180407.GB131063@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715180407.GB131063@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 15, 2019 at 11:04 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi,
>
> On Tue, Jul 02, 2019 at 11:39:56PM -0700, Life is hard, and then you die =
wrote:
> >
> > On Tue, Jul 02, 2019 at 03:50:49PM +0200, Andrzej Hajda wrote:
> > > On 19.04.2019 10:19, Ronald Tschal=C3=A4r wrote:
> > > > commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a depende=
ncy
> > > > of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> > > > However, this causes problems with other drivers, in particular an =
input
> > > > driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separat=
e
> > > > commit):
> > > >
> > > >   drivers/clk/Kconfig:9:error: recursive dependency detected!
> > > >   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MF=
D_INTEL_LPSS
> > > >   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected b=
y MFD_INTEL_LPSS_PCI
> > > >   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implie=
d by KEYBOARD_APPLESPI
> > > >   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI de=
pends on INPUT
> > > >   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL=
_SII8620
> > > >   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depe=
nds on DRM_BRIDGE
> > > >   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is select=
ed by DRM_PL111
> > > >   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on=
 COMMON_CLK
> > > >
> > > > According to the docs and general consensus, select should only be =
used
> > > > for non user-visible symbols, but both RC_CORE and INPUT are
> > > > user-visible. Furthermore almost all other references to INPUT
> > > > throughout the kernel config are depends, not selects. For this rea=
son
> > > > the first part of this change reverts commit d6abe6df706c.
> > > >
> > > > In order to address the original reason for commit d6abe6df706c, na=
mely
> > > > that not all boards use the remote controller functionality and hen=
ce
> > > > should not need have to deal with RC_CORE, the second part of this
> > > > change now makes the remote control support in the driver optional =
and
> > > > contingent on RC_CORE being defined. And with this the hard depende=
ncy
> > > > on INPUT also goes away as that is only needed if RC_CORE is define=
d
> > > > (which in turn already depends on INPUT).
> > > >
> > > > CC: Inki Dae <inki.dae@samsung.com>
> > > > CC: Andrzej Hajda <a.hajda@samsung.com>
> > > > CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch>
> > > > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > >
> > >
> > > Apparently this patch was not queued to kernel yet. If there are no
> > > objections I will queue it via drm-misc-next tree tomorrow.
> >
> > If this patch set won't be queued for 5.3 then I guess that would be a
> > good idea.
> >
> > But may I ask what is preventing this patch set from being queued for
> > upstream, so I can try and fix whatever the issue is?
>
> As I mentioned in my pull request to Linux I will be picking up the
> Apple keyboard driver for this merge window even though it was not in
> next (my fault).
>
> I created and immutable branch for this change if you'd like to pull it
> in so we do not duplicate commit and risk the conflicts (but I believe
> git should resolve it either way).
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git id/5.2-sil=
_sii8620-rc-optional

Sorry, that should have read:

https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
ib/5.2-sil_sii8620-rc-optional

Thanks.

--=20
Dmitry
