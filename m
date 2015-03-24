From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v7 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
Date: Tue, 24 Mar 2015 17:10:58 +0100
Message-ID: <20150324161058.GJ28604@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-4-git-send-email-mpa@pengutronix.de>
 <54FB3740.6010908@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3749861383670816760=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54FB3740.6010908@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, Samuel Ortiz <sameo@linux.intel.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Denis Carikli <denis@eukrea.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--===============3749861383670816760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2015 at 05:37:04PM +0000, Jonathan Cameron wrote:
> On 03/03/15 07:58, Markus Pargmann wrote:
> > This is the touchscreen conversion queue binding documentation. It uses
> > the shared imx25 ADC.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Looks fine, one more general binding approach comment though.
> A lot of the vendor specific elements in here are awfully generic.
> Does it not make sense to have them as standard attributes for
> touch screen drivers?
> > ---
> >=20
> > Notes:
> >     Changes in v5:
> >      - Fix signed/unsigned comparison
> >      - Fix unused variable settling_time by putting it in the correct a=
rgument list
> >      - Use continous conversion queue with the repeat feature and a pro=
per
> >        repeat-wait. Previously the touchscreen caused massive number of=
 interrupts.
> >=20
> >  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 29 ++++++++++++++=
++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/fsl-mx25-tcq.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx=
25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-t=
cq.txt
> > new file mode 100644
> > index 000000000000..4214a99d197a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.=
txt
> > @@ -0,0 +1,29 @@
> > +Freescale mx25 TS conversion queue module
> > +
> > +mx25 touchscreen conversion queue module which controls the ADC unit o=
f the
> > +mx25 for attached touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tcq".
> > + - reg: Memory range of the device.
> > + - interrupts: Should be the interrupt number associated with this mod=
ule within
> > +   the tscadc unit (<0>).
> > + - interrupt-parent: Should be a phandle to the tscadc unit.
> > + - fsl,wires: Should be '<4>' or '<5>'
> > +
> > +Optional properties:
> > + - fsl,pen-debounce: Pen debounce time.
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> > + - fsl,settling-time: Settling time in nanoseconds.
> Obviously it's up to Dmitry etc, but are these not standard enough attrib=
utes to
> not be vendor specific?  I'd expect say touch-pen-debouce and touch-pen-t=
hreshold
> etc to be standard binding elements for touch screens.

Seems like a good idea. I just discovered that there is a 'touchscreen-fuzz=
-pressure'
which seems to be the same as fsl,pen-threshold. So this should be
replaced in my patches. The other properties do not exist.

Dmitry, what do you think about some standard properties for the
remaining?

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEYySAAoJEEpcgKtcEGQQOLAP+QFnOQA6/FPTVapckMK7i84b
7fhvPB12SsGH0mculX5SxmLgwEr0Ab9A+97HyiIn0rvuDxtKZ5kTvov4tOl8vspW
4H1aA6hfpe+2+G2QHIcoRIpk9ulwDtPOhgpv1FsdgkFOdQWiLIDTE0hWGJfKBgUo
tKBjBHFIP34nytS9Z16yB+k4+hG1elwZg1EKp67j4RUzvP4g8J/0Y5Jn1JA2KS55
C9hCSpxyLIvyzYD+bfyM1H2nm6GacysWtWgXEM4wrZCJgxpuMHcQFKUgLs2oV/YN
15opOvwLZFQVj6iKV2oVihXYykdNPHcwGCj9PeAz476/5hlacQlzpL907yAytqsT
EHoAlAMt8TOCMhC3/z6G3CLxTKW8+5NC5Q8ZKPiIjRDZntKiS5oY1s3fyq3W4sO1
yEijtAgxrGC6ES3lrHlg5ucP4sMU6yP6+sOSoocFk3Id63CZrPKeIzPWZ8SiMbYB
IBwQC42bBuIaLHzE43v1Q/199+xKXKS8uYgMp5RJKeh4Q/blSThKq9vHyjaAkMQX
AztlQDjJFwFROb+huOQmzZMTjgnut58hNAC2FgpdpkwUkyXBf0RJ3R6WRPTjc0hG
zBkN62q6G7ZeCD0coPLKCgASKd6D27bpFRn0ZotQMGFpzxW9LwBEFgDRQpU1IRgc
RmmKmDKcnMM8jotgkE5K
=DKoQ
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--


--===============3749861383670816760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3749861383670816760==--
