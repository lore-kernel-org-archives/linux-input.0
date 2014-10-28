From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: [PATCH] Input: i8042 - add mux quirk for HP EliteBook 8470p
Date: Tue, 28 Oct 2014 22:25:16 +0000
Message-ID: <20141028222516.GA4265@hercules>
References: <1414525704-8409-1-git-send-email-luis.henriques@canonical.com>
 <20141028201046.GB7461@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141028201046.GB7461@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 28, 2014 at 01:10:46PM -0700, Dmitry Torokhov wrote:
> Hi Luis,
>=20
> On Tue, Oct 28, 2014 at 07:48:24PM +0000, Luis Henriques wrote:
> > This laptop requires active multiplexing to be enabled in order to =
be able
> > to separate the PS/2 mouse and the touchpad.
> >=20
> > Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> > ---
> >  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/=
serio/i8042-x86ia64io.h
> > index a0bcbb64d06d..34b95e4268eb 100644
> > --- a/drivers/input/serio/i8042-x86ia64io.h
> > +++ b/drivers/input/serio/i8042-x86ia64io.h
> > @@ -220,6 +220,13 @@ static const struct dmi_system_id __initconst =
i8042_dmi_mux_table[] =3D {
> >  			DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
> >  		},
> >  	},
> > +	{
> > +		/* HP EliteBook 8470p */
> > +		.matches =3D {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8470p"),
>=20
> Hmm, so the tide is turning the other way ;) I think I'll be comforta=
ble
> extending this to all EliteBooks as I know 840 and 1040 work as well =
and
> I have not heard any other complaints about this model line.
>=20
> Cold you resend with match on "HP EliteBook" instead of "HP EliteBook
> 8470p"?
>=20

Sure, sending it in a minute.

Cheers,
--
Lu=EDs

> Thanks.
>=20
> --=20
> Dmitry
