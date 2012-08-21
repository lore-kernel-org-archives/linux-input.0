From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 8/8] input: ab8500-ponkey: Rely on MFD core to convert
 IRQs to virtual
Date: Tue, 21 Aug 2012 10:23:29 +0100
Message-ID: <20120821092328.GC26899@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 14, 2012 at 10:31:08AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
>=20
> > There was a plan to place ab8500_irq_get_virq() calls in each AB850=
0
> > child device prior to requesting an IRQ, but as we're no longer usi=
ng
> > Device Tree to collect our IRQ numbers, it's actually better to all=
ow
> > the core to do this during device registration time. So the IRQ num=
ber
> > we pull from its resource has already been converted to a virtual I=
RQ.
> >
> > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > CC: linux-input@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> This is looking good, I guess you need all patches to go in at the
> same time so Dmitry's ACK is required.

Yep, just waiting for that now.
=20
> FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> BTW: this makes me suspect that the public ab8500_irq_get_virq()
> interface can be *deleted* and the function made static in the
> AB8500 driver, right?

Right. Already taken care of.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
