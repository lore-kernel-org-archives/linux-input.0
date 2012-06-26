From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/22 v4] Input: atmel_mxt_ts - set phys to i2c client
 adapter name
Date: Mon, 25 Jun 2012 18:27:51 -0700
Message-ID: <20120626012751.GB24705@core.coreip.homeip.net>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
 <1339992522-22073-2-git-send-email-djkurtz@chromium.org>
 <20120621084107.GB2193@core.coreip.homeip.net>
 <20120625081558.GA641@polaris.bitmath.org>
 <CAGS+omD5xp1PeXGMdsz6uP-QL2rU+sfoPBmOPGqi2p8NE9S4Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50250 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab2FZB2B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 21:28:01 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omD5xp1PeXGMdsz6uP-QL2rU+sfoPBmOPGqi2p8NE9S4Jw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org

On Mon, Jun 25, 2012 at 05:58:46PM +0800, Daniel Kurtz wrote:
> On Mon, Jun 25, 2012 at 4:15 PM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
> >
> > On Thu, Jun 21, 2012 at 01:41:07AM -0700, Dmitry Torokhov wrote:
> > > On Mon, Jun 18, 2012 at 12:08:21PM +0800, Daniel Kurtz wrote:
> > > > This allows userspace to more easily distinguish which bus a
> > > > particular
> > > > atmel_mxt_ts device is attached to.
> > > >
> > > > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > > > ---
> > > > =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 =A01 +
> > > > =A01 files changed, 1 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > b/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > index 42e6450..eda9eed 100644
> > > > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > @@ -1106,6 +1106,7 @@ static int __devinit mxt_probe(struct i2c=
_client
> > > > *client,
> > > > =A0 =A0 }
> > > >
> > > > =A0 =A0 input_dev->name =3D "Atmel maXTouch Touchscreen";
> > > > + =A0 input_dev->phys =3D client->adapter->name;
> > >
> > > Normally we set phys to 'xxx/input0' nstead of just the adaptor n=
ame.
> >
> > Daniel, will we be seeing another version of this patch?
>=20
> Yes.  Any guidance on "xxx" ?  atmel_mxt_ts?

What you have before (client->adapter->name) + "/input0" shoudl work
splendidly.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
