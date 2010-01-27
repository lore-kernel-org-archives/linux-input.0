From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 15:52:34 +0100
Message-ID: <19296.21298.394254.553268@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
	<19296.12024.559688.606548@ipc1.ka-ro>
	<1264603193.2463.75.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1264603193.2463.75.camel@realization>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

Alberto Panizzo writes:
> On mer, 2010-01-27 at 13:18 +0100, Lothar Wa=DFmann wrote:
> > Hi,
> > =

> > Alberto Panizzo writes:
> > > > > +	irq =3D platform_get_irq(pdev, 0);
> > > > > +	if (irq < 0) {
> > > > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > > > +		return -ENXIO;
> > > > > +	}
> > > > >
> > > > This should be -ENODEV.
> > > > =

> > > Lot of reference keyboard driver use -ENXIO..
> > > May should be better: return irq ?
> > > =

> > Yes, of course. If a function returns an error code that should be
> > promoted to the caller instead of inventing a new error code.
> > =

> > =

> > Lothar Wa=DFmann
> =

> But, errno.h say:
> #define ENXIO           6                // Device not configured
> #define ENODEV          19               // Operation not supported by de=
vice
> =

What errno.h file is that?
I have:
./include/asm-generic/errno-base.h:#define      ENXIO            6      /* =
No such device or address */
./include/asm-generic/errno-base.h:#define      ENODEV          19      /* =
No such device */

AFAIK ENXIO is used when actual I/O has been attempted. But in this
case the driver is still being configured and did not do any I/O yet.


Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
