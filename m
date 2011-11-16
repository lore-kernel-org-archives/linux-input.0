From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] Input: ucb1400_ts - convert to threaded IRQ
Date: Tue, 15 Nov 2011 23:47:02 -0800
Message-ID: <20111116074702.GB19407@core.coreip.homeip.net>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
 <1321259771-10925-5-git-send-email-dmitry.torokhov@gmail.com>
 <CAGS+omCkC4uwm2XFQmtHC5BwcnyTT5=rGJ9jhJfv7=BwZm8D+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55158 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab1KPHrI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 02:47:08 -0500
Received: by iage36 with SMTP id e36so234518iag.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 23:47:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGS+omCkC4uwm2XFQmtHC5BwcnyTT5=rGJ9jhJfv7=BwZm8D+g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: linux-input@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>

Hi Daniel,

On Wed, Nov 16, 2011 at 03:36:37PM +0800, Daniel Kurtz wrote:
`> Hi Dmitry,
>=20
> On Mon, Nov 14, 2011 at 4:36 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > =A0#ifdef CONFIG_PM_SLEEP
> > +static int ucb1400_ts_suspend(struct device *dev)
> > +{
> > + =A0 =A0 =A0 struct ucb1400_ts *ucb =3D dev->platform_data;
> > + =A0 =A0 =A0 struct input_dev *idev =3D ucb->ts_idev;
> > +
> > + =A0 =A0 =A0 mutex_lock(&idev->mutex);
> > +
> > + =A0 =A0 =A0 if (idev->users)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_start(ucb);
> > +
> > + =A0 =A0 =A0 mutex_unlock(&idev->mutex);
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > =A0static int ucb1400_ts_resume(struct device *dev)
> > =A0{
> > =A0 =A0 =A0 =A0struct ucb1400_ts *ucb =3D dev->platform_data;
> > + =A0 =A0 =A0 struct input_dev *idev =3D ucb->ts_idev;
> >
> > - =A0 =A0 =A0 if (ucb->ts_task) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Restart the TS thread to ensure =
the
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* TS interrupt mode is set up agai=
n
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* after sleep.
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->ts_restart =3D 1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&ucb->ts_wait);
> > - =A0 =A0 =A0 }
> > + =A0 =A0 =A0 mutex_lock(&idev->mutex);
> > +
> > + =A0 =A0 =A0 if (idev->users)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_stop(ucb);
> > +
> > + =A0 =A0 =A0 mutex_unlock(&idev->mutex);
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> > =A0#endif
>=20
> Do you need an #else here to set *_suspend/resume to NULL when
> CONFIG_PM_SLEEP is not defined?
> It seems to have gotten lost somewhere.

Without CONFIG_PM_SLEEP SIMPLE_DEV_PM_OPS simply ignores its 2nd and 3r=
d
arguments so the fact that they are missing does not matter.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
