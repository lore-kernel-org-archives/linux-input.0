From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] [PATCH] next: cyapa: fix inop touchpad after resume on
 Acer C720
Date: Wed, 3 Dec 2014 15:42:46 -0800
Message-ID: <20141203234246.GA10327@dtor-ws>
References: <20141124085059.GA15770@hudson.localdomain>
 <20141125100703.GA9287@hudson.localdomain>
 <af603da34acc4caca630ca58eda7eb1e@BN1PR06MB070.namprd06.prod.outlook.com>
 <20141126200238.GB27014@hudson.localdomain>
 <000d01d00a05$7ffe4970$7ffadc50$@gmail.com>
 <189CB621-DEBE-4C54-AE62-9441D50C7C55@gmail.com>
 <9d446cdf85214727b1cd02d7e1537e2b@BN1PR06MB070.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52079 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaLCXmv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 18:42:51 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so14726559iec.16
        for <linux-input@vger.kernel.org>; Wed, 03 Dec 2014 15:42:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9d446cdf85214727b1cd02d7e1537e2b@BN1PR06MB070.namprd06.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: 'Jeremiah Mahler' <jmmahler@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dudley,

On Fri, Nov 28, 2014 at 01:49:15AM +0000, Dudley Du wrote:
> Dmitry,
>=20
> Yes, I remebered the discussion, and I said it was working.
> At that time, I though it was the suggestion to my patches, so I merg=
ed the solution to my pathces,
> and verified on my pathces. But did not run test on the patch you att=
ached.
> Sorry for the misunderstood and the troubles to you. :)

Sorry I was not clear in my request. Anyway, I just applied the patch
(with a minor edit) and pushed it out. It shoudl make it's way into nex=
t
today or tomorrow.

Thanks.

>=20
> Regards,
> Dudley
>=20
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: 2014=E5=B9=B411=E6=9C=8828=E6=97=A5 2:16
> > To: Dudley Du; 'Jeremiah Mahler'
> > Cc: linux-kernel@vger.kernel.org; Dudley Du
> > Subject: RE: [BUG] [PATCH] next: cyapa: fix inop touchpad after res=
ume on Acer
> > C720
> >
> > On November 26, 2014 9:45:49 PM PST, Dudley Du <dudley.dulixin@gmai=
l.com>
> > wrote:
> > >Jeremiah,
> > >
> > >I didn't make the special patch for the linux-next before, so I do=
n't
> > >know why
> > >this patch is there and have issue.
> >
> > That was the patch we've discussed some times back and you mentione=
d it was
> > working for you so I applied it to next.
> >
> > I'll make sure to apply the fixup promptly.
> >
> > >Based on current code in the linux-next, I made below patch to fix=
 this
> > >issue.
> > >Could you please try again with attached patch fix.
> > >
> > >Thanks,
> > >Dudley
> > >
> > >> -----Original Message-----
> > >> From: Jeremiah Mahler [mailto:jmmahler@gmail.com]
> > >> Sent: 2014?11?27? 4:03
> > >> To: Dudley Du
> > >> Cc: linux-kernel@vger.kernel.org
> > >> Subject: Re: [BUG] [PATCH] next: cyapa: fix inop touchpad after
> > >resume on Acer
> > >> C720
> > >>
> > >> Dudley,
> > >>
> > >> On Wed, Nov 26, 2014 at 06:16:00AM +0000, Dudley Du wrote:
> > >> > More info: I did all testings based on kernel 3.14.0 on Acer C=
70.
> > >> >
> > >>
> > >> I am testing with linux-next 3.18-rc6 on an Acer C720.
> > >>
> > >> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/
> > >>
> > >> > Thanks,
> > >> > Dudley
> > >> >
> > >> []
> > >>
> > >> --
> > >> - Jeremiah Mahler
> > >
> > >From bb717b1c1525ef6b889f0ef735d920eed9e76e72 Mon Sep 17 00:00:00 =
2001
> > >From: Dudley Du <dudley.dulixin@gmail.com>
> > >Date: Thu, 27 Nov 2014 13:35:09 +0800
> > >Subject: [PATCH] input: cyapa: fix irq error issue in cyapa_resume
> > >To: dmitry.torokhov@gmail.com,
> > >    jmmahler@gmail.com
> > >Cc: bleung@google.com,
> > >    linux-input@vger.kernel.org
> > >
> > >This patch is aimed to fix the irq error happened on cyapa_resume =
when
> > >doing suspend/resume testing.
> > >The root cause of this issue is that the cyapa->irq has been remov=
ed
> > >but
> > >still used in the driver.
> > >
> > >Signed-off-by: Dudley Du <dudley.dulixin@gmail.com>
> > >---
> > > drivers/input/mouse/cyapa.c | 6 +++---
> > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cya=
pa.c
> > >index c84a9eb..caaba7b 100644
> > >--- a/drivers/input/mouse/cyapa.c
> > >+++ b/drivers/input/mouse/cyapa.c
> > >@@ -938,7 +938,7 @@ static int __maybe_unused cyapa_suspend(struct
> > >device *dev)
> > >  power_mode, error);
> > >
> > > if (device_may_wakeup(dev))
> > >-cyapa->irq_wake =3D (enable_irq_wake(cyapa->irq) =3D=3D 0);
> > >+cyapa->irq_wake =3D (enable_irq_wake(cyapa->client->irq) =3D=3D 0=
);
> > >
> > > mutex_unlock(&input->mutex);
> > >
> > >@@ -956,7 +956,7 @@ static int __maybe_unused cyapa_resume(struct
> > >device *dev)
> > > mutex_lock(&input->mutex);
> > >
> > > if (device_may_wakeup(dev) && cyapa->irq_wake)
> > >-disable_irq_wake(cyapa->irq);
> > >+disable_irq_wake(cyapa->client->irq);
> > >
> > > power_mode =3D input->users ? PWR_MODE_FULL_ACTIVE : PWR_MODE_OFF=
;
> > > error =3D cyapa_set_power_mode(cyapa, PWR_MODE_FULL_ACTIVE);
> > >@@ -964,7 +964,7 @@ static int __maybe_unused cyapa_resume(struct
> > >device *dev)
> > > dev_warn(dev, "resume: set power mode to %d failed: %d\n",
> > >  power_mode, error);
> > >
> > >-enable_irq(cyapa->irq);
> > >+enable_irq(cyapa->client->irq);
> > >
> > > mutex_unlock(&input->mutex);
> > >
> >
> > Hi Dudley,
> > Thanks.
> >
> > --
> > Dmitry
>=20
> This message and any attachments may contain Cypress (or its subsidia=
ries) confidential information. If it has been received in error, pleas=
e advise the sender and immediately delete this message.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
