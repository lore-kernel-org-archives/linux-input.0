From: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH] input: misc: pwm-vibra: Prevent unbalanced regulator
Date: Thu, 17 Jan 2019 09:44:51 +0100
Message-ID: <CAKpie0QcLf+M7YirVcX8AMXQYi8v+_kaKTSC7QZY1-0-op+aSQ@mail.gmail.com>
References: <20190116211131.18809-1-pawel.mikolaj.chmiel@gmail.com> <20190117070838.GA8109@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117070838.GA8109@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Bakker <xc-racer2@live.ca>
List-Id: linux-input@vger.kernel.org

czw., 17 sty 2019 o 08:08 Dmitry Torokhov <dmitry.torokhov@gmail.com>
napisa=C5=82(a):
>
> Hi Pawe=C5=82,
>
> On Wed, Jan 16, 2019 at 10:11:31PM +0100, Pawe=C5=82 Chmiel wrote:
> > From: Jonathan Bakker <xc-racer2@live.ca>
> >
> > pwm_vibrator_stop disables the regulator, but it can be called from
> > multiple places, even when the regulator is already disabled. Fix this
> > by using regulator_is_enabled check when starting and stopping device.
> >
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/input/misc/pwm-vibra.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vi=
bra.c
> > index 55da191ae550..66677ee770ca 100644
> > --- a/drivers/input/misc/pwm-vibra.c
> > +++ b/drivers/input/misc/pwm-vibra.c
> > @@ -42,10 +42,12 @@ static int pwm_vibrator_start(struct pwm_vibrator *=
vibrator)
> >       struct pwm_state state;
> >       int err;
> >
> > -     err =3D regulator_enable(vibrator->vcc);
> > -     if (err) {
> > -             dev_err(pdev, "failed to enable regulator: %d", err);
> > -             return err;
> > +     if (!regulator_is_enabled(vibrator->vcc)) {
>
> I do not think this is correct in case of shared supply, as this checks
> global state of regulator. That means that if there is another user, we
> may forego enabling regulator here, and that anther user may power it
> down and vibrator will stop working.
>
> I think you need a local flag here.
Ok will fix this (funny that in first version of patch there was such flag)=
.
>
> > +             err =3D regulator_enable(vibrator->vcc);
> > +             if (err) {
> > +                     dev_err(pdev, "failed to enable regulator: %d", e=
rr);
> > +                     return err;
> > +             }
> >       }
> >
> >       pwm_get_state(vibrator->pwm, &state);
> > @@ -76,7 +78,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vi=
brator)
> >
> >  static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
> >  {
> > -     regulator_disable(vibrator->vcc);
> > +     if (regulator_is_enabled(vibrator->vcc))
> > +             regulator_disable(vibrator->vcc);
>
> Looking at this, I wonder if we should not disable PWMs first and the
> disable regulator.
I will create and send separate patch for this.

Thanks for review
>
> >
> >       if (vibrator->pwm_dir)
> >               pwm_disable(vibrator->pwm_dir);
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry
