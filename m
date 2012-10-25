From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Support Elan Touchscreen eKTF product.
Date: Thu, 25 Oct 2012 00:10:26 -0700
Message-ID: <20121025071026.GA23478@core.coreip.homeip.net>
References: <20121024181323.GA18122@core.coreip.homeip.net>
 <EA73774BB37B4F518A6EA9926BB96304@elan.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57366 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab2JYHKb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 03:10:31 -0400
Content-Disposition: inline
In-Reply-To: <EA73774BB37B4F518A6EA9926BB96304@elan.corp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>, 'Jesse' <jesse@emc.com.tw>, 'Vincent Wang' <vincent.wang@emc.com.tw>, 'Paul' <paul.liang@emc.com.tw>

On Thu, Oct 25, 2012 at 12:32:39PM +0800, =E5=8A=89=E5=98=89=E9=A7=BF w=
rote:
> Hi Dmitry,
> 	Thanks for review.
>=20
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Thursday, October 25, 2012 2:13 AM
> > To: Scott Liu
> > Cc: linux-input@vger.kernel.org; linux-i2c@vger.kernel.org;
> linux-kernel@vger.kernel.org;
> > Benjamin Tissoires; Jesse; Vincent Wang; Paul
> > Subject: Re: [PATCH v2] Support Elan Touchscreen eKTF product.
> >=20
> > Hi Scott,
> >=20
> > On Wed, Oct 24, 2012 at 09:41:43AM +0800, Scott Liu wrote:
> > > This patch is for Elan eKTF Touchscreen product, I2C adpater modu=
le.
> > >
> > > Signed-off-by: Scott Liu <scott.liu@emc.com.tw>
> > > ---
> > >
> > > Hi,
> > >         v2 revision I have fixed some bug as your advise.
> > >         1. To target the mainline
> > >         2. No Android dependency
> > >         3. reuse those duplication code from Henrik's patchset.
> > >                 (input_mt_sync_frame()  / input_mt_get_slot_by_ke=
y())
> >=20
> > Just a quick run through the code, so:
> >=20
> > - please remove polling support, it is not useful in production;
>=20
> OK.
>=20
> > - why do you need a separate probe work instead of doing what you
> >   need in elants_probe()
>=20
> will fix.
>=20
> > - it is not a good idea to register input device first and then
> >   allocating memory for MT handling.
>=20
> Ooop...will fix.
>=20
> > - I do not understand why kfifo is needed
>=20
> The firmware and the host would conflict by read command and finger r=
eport
> simultaneously. So I'm simply using kfifo in IRQ thread function.
>=20
> * read command: writing 4 bytes commands and the device asserts GPIO
> interrupt and then response 4 bytes data.
>=20
> There was an error if we do not use kfifo:
> 	With heavy loading by finger report / read command, the driver may
> get finger report as response data.
>=20
> So, do you understand my meaning?=20

No I don't. Most of my confusion stems from the fact that you only put
data into kfifo but not actually use it anywhere. You do fetch the data
in your "drop old" function, but that data is just dropped. So I really
do not see the point.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
