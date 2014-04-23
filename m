From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 01/24] input: Add ff-memless-next module
Date: Wed, 23 Apr 2014 08:59:24 -0700
Message-ID: <20140423155923.GB10531@core.coreip.homeip.net>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
 <1398175209-9565-2-git-send-email-madcatxster@devoid-pointer.net>
 <1398255179.32091.1.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398255179.32091.1.camel@linux-fkkt.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Michal =?iso-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 23, 2014 at 02:12:59PM +0200, Oliver Neukum wrote:
> On Tue, 2014-04-22 at 15:59 +0200, Michal Mal=FD wrote:
> > +/* Some devices might have a limit on how many uncombinable effect=
s
> > + * can be played at once */
> > +static int mlnx_upload_conditional(struct mlnx_device *mlnxdev,
> > +                                  const struct ff_effect *effect)
> > +{
> > +       struct mlnx_effect_command ecmd =3D {
> > +               .cmd =3D MLNX_UPLOAD_UNCOMB,
> > +               .u.uncomb.id =3D effect->id,
> > +               .u.uncomb.effect =3D effect
> > +       };
> > +       return mlnxdev->control_effect(mlnxdev->dev, mlnxdev->priva=
te,
> > &ecmd);
> > +}
> > +
>=20
> This mean you are building the structure on the stack
>=20
> 1. Are you sure nobody retains a reference?
> 2. That is needlessly inefficient

Why is it inefficient?

--=20
Dmitry
