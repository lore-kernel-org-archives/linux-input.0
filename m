From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [PATCH v2 01/24] input: Add ff-memless-next module
Date: Wed, 23 Apr 2014 14:30:39 +0200
Message-ID: <12060887.UbTEf5RVBB@sigyn>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net> <1398175209-9565-2-git-send-email-madcatxster@devoid-pointer.net> <1398255179.32091.1.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398255179.32091.1.camel@linux-fkkt.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Wednesday 23 of April 2014 14:12:59 Oliver Neukum wrote:
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
Yes. The command is a one-shot thing so it makes no sense to hold a per=
sistent=20
reference to it. Should the HW-specific driver need to keep any data fr=
om the=20
command - if the uses a workqueue to submit data to the device for inst=
ance -=20
it should keep its own copy of the data. The idea is to keep MLNX and H=
W-
specific driver as separated as possible to prevent any race conditions=
=2E

> 2. That is needlessly inefficient
Are you suggesting I drop the 'consts' and keep the memory preallocated=
?

Thanks for the feedback,
Michal
