From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] UCB1400: enable touchscreen interrupt unconditionally
Date: Fri, 7 Aug 2009 23:34:09 -0700
Message-ID: <20090808070421.4A86F526EC9@mailhub.coreip.homeip.net>
References: <479e0fb40908070559o2f31a2dbh48c11328b78c734f@mail.gmail.com> <200908071504.47036.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:38362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbZHHGeN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Aug 2009 02:34:13 -0400
Received: by rv-out-0506.google.com with SMTP id f6so587812rvb.1
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2009 23:34:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200908071504.47036.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, Pavel Revak <palo@bielyvlk.sk>

On Fri, Aug 07, 2009 at 03:04:46PM +0200, Marek Vasut wrote:
> Dne P=E1 7. srpna 2009 14:59:52 Pavel Revak napsal(a):
> > Hi,
> >
> > Sometimes, when I using the touchscreen, it stops working till next=
 restart
> > and I see the following message:
> >  "ucb1400: unexpected IE_STATUS =3D 0x0"
> >
> > The following patch retriggers the touchscreen interrupt unconditio=
nally.
> > This prevents hanging of the touchscreen in case of bogus interrupt
> > occurence.
> >
> > Signed-off-by: Pavel Revak <palo@bielyvlk.sk>
> > ---
> > diff --git a/drivers/input/touchscreen/ucb1400_ts.c
> > b/drivers/input/touchscreen/ucb1400_ts.c
> > index 5498662..6752de5 100644
> > --- a/drivers/input/touchscreen/ucb1400_ts.c
> > +++ b/drivers/input/touchscreen/ucb1400_ts.c
> > @@ -168,11 +168,11 @@ static void ucb1400_handle_pending_irq(struct
> > ucb1400_ts *ucb)
> >         ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, isr);
> >         ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, 0);
> >
> > -       if (isr & UCB_IE_TSPX) {
> > +       if (isr & UCB_IE_TSPX)
> >                 ucb1400_ts_irq_disable(ucb->ac97);
> > -               enable_irq(ucb->irq);
> > -       } else
> > -               printk(KERN_ERR "ucb1400: unexpected IE_STATUS =3D =
%#x\n",
> > isr);
> > +       else
> > +               dev_dbg(&ucb->ts_idev->dev, "ucb1400: unexpected IE=
_STATUS
> > =3D %#x\n", isr);
> > +       enable_irq(ucb->irq);
> >  }
> >
> >  static int ucb1400_ts_thread(void *_ucb)
>=20
> Hi!
>=20
> looks OK to me, it's a bug that was introduced in the spliting proces=
s last=20
> year by me it seems.
>=20
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
>=20
> Dmitry, can we get this in before .32? Thanks!

It would be helpful if I could locate the original patch, fishing
it from quoted text is not pleasant. Also, do we really need to
fiddle with enabling/disabling interrupt at all? It seems to be
edge-triggered...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
