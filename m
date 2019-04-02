From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v6 05/11] mfd: core: document mfd_add_devices()
Date: Tue, 2 Apr 2019 10:08:59 +0200
Message-ID: <CAMRc=Mekomya5A_tj3RKSeno1EaBoGNAFJajPfyB1cHP7c+L6w@mail.gmail.com>
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-6-brgl@bgdev.pl>
 <20190402074103.GG4187@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402074103.GG4187@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

wt., 2 kwi 2019 o 09:41 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Mon, 18 Mar 2019, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add a kernel doc for mfd_add_devices().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/mfd/mfd-core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 94e3f32ce935..0898a8db1747 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, i=
nt id,
> >       return ret;
> >  }
> >
> > +/**
> > + * mfd_add_devices - register a set of child devices
>
> "register child devices"
>
> > + *
> > + * @parent: Parent device for all sub-nodes.
> > + * @id: Platform device id. If >=3D 0, each sub-device will have its c=
ell_id
> > + *      added to this number and use it as the platform device id.
> > + * @cells: Array of mfd cells describing sub-devices.
> > + * @n_devs: Number of sub-devices to register.
> > + * @mem_base: Parent register range resource for sub-devices.
> > + * @irq_base: Base of the range of virtual interrupt numbers allocated=
 for
> > + *            this MFD device. Unused if @domain is specified.
> > + * @domain: Interrupt domain used to create mappings for HW interrupt =
numbers
> > + *          specificed in sub-devices' IRQ resources.
>
> Spelling.
>
> > + */
> >  int mfd_add_devices(struct device *parent, int id,
> >                   const struct mfd_cell *cells, int n_devs,
> >                   struct resource *mem_base,
>
> How about this:
>
> /**
>  * mfd_add_devices - register child devices
>  *
>  * @parent:     Pointer to parent device.
>  * @id:         Can be PLATFORM_DEVID_AUTO to let the Platform API take c=
are
>  *              of device numbering, or will be added to a device's cell_=
id.
>  * @cells:      Array of (struct mfd_cell)s describing child devices.
>  * @n_devs:     Number of child devices to register.
>  * @mem_base:   Parent register range resource for child devices.
>  * @irq_base:   Base of the range of virtual interrupt numbers allocated =
for
>  *              this MFD device. Unused if @domain is specified.
>  * @domain:     Interrupt domain to create mappings for hardware interrup=
ts.
>  */
>

Sure, looks good to me.

FYI the latest version of this series is v7, but the mfd driver didn't
change since v6.

Bart
