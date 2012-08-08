From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Wed, 8 Aug 2012 12:40:38 +0100
Message-ID: <20120808114037.GB8227@gmail.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
 <20120808080411.GB4728@gmail.com>
 <20120808094952.GH16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120808094952.GH16861@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 08, 2012 at 10:49:52AM +0100, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 09:04:12AM +0100, Lee Jones wrote:
>=20
> > During non-DT boot:
> >  - Platform data is passed, which contains an IRQ base
> >  - If an IRQ base is requested we use it to register a Legacy IRQ D=
omain
> >  - MFD adds the IRQ base to the hwirq and registers it as a virq
>=20
> Just don't do this step - the only reason to do it is for mapping bac=
k
> into a linear domain but if you're going to do this...
>=20
> >  - AB8500 child devices use *_get_virq() to convert virq to virq - =
*ERROR*
>=20
> ...then it's redundant.  The mapping functions in the domain code
> replace this functionality.

No, the other way round. This is now required all the time.

Now we force the use of hwirq, the driver needs to convert that into a
virq before requesting the resource. So we need to put *_get_virq()'s i=
nto
every child device that requests an IRQ.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
