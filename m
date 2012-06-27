From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 01/22 v4] Input: atmel_mxt_ts - set phys to i2c client
 adapter name
Date: Tue, 26 Jun 2012 17:42:08 -0700
Message-ID: <CANLzEksg2ak9GMOWveMgU+QS-fM92ac-RV+_hNWKZe2gTpsbwQ@mail.gmail.com>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
	<1339992522-22073-2-git-send-email-djkurtz@chromium.org>
	<20120621084107.GB2193@core.coreip.homeip.net>
	<20120625081558.GA641@polaris.bitmath.org>
	<CAGS+omD5xp1PeXGMdsz6uP-QL2rU+sfoPBmOPGqi2p8NE9S4Jw@mail.gmail.com>
	<20120626012751.GB24705@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44966 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab2F0AmJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 20:42:09 -0400
Received: by qadb17 with SMTP id b17so2179754qad.19
        for <linux-input@vger.kernel.org>; Tue, 26 Jun 2012 17:42:08 -0700 (PDT)
In-Reply-To: <20120626012751.GB24705@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org

[oops. sorry for duplicate send... resending in plaintext]

Would it more sense to more completely describe the bus type, adapter,
and address in this case, rather than using the client->adapter->name?

Just to give an example from our system, client->adapter->name is
"i915 gmbus panel", so your suggestion would be "i915 gmbus
panel/input0"

How about this instead :
i2c-2-004a/input0

This seems to me more consistent with what is done with USB input
devices, which show a phys field like this :
usb-00:01.2-2.2/input0

Benson

On Mon, Jun 25, 2012 at 6:27 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Mon, Jun 25, 2012 at 05:58:46PM +0800, Daniel Kurtz wrote:
> > On Mon, Jun 25, 2012 at 4:15 PM, Henrik Rydberg <rydberg@euromail.s=
e>
> > wrote:
> > >
> > > On Thu, Jun 21, 2012 at 01:41:07AM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Jun 18, 2012 at 12:08:21PM +0800, Daniel Kurtz wrote:
> > > > > This allows userspace to more easily distinguish which bus a
> > > > > particular
> > > > > atmel_mxt_ts device is attached to.
> > > > >
> > > > > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > > > > ---
> > > > > =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 =A01 +
> > > > > =A01 files changed, 1 insertions(+), 0 deletions(-)
> > > > >
> > > > > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > > b/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > > index 42e6450..eda9eed 100644
> > > > > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > > > > @@ -1106,6 +1106,7 @@ static int __devinit mxt_probe(struct
> > > > > i2c_client
> > > > > *client,
> > > > > =A0 =A0 }
> > > > >
> > > > > =A0 =A0 input_dev->name =3D "Atmel maXTouch Touchscreen";
> > > > > + =A0 input_dev->phys =3D client->adapter->name;
> > > >
> > > > Normally we set phys to 'xxx/input0' nstead of just the adaptor
> > > > name.
> > >
> > > Daniel, will we be seeing another version of this patch?
> >
> > Yes. =A0Any guidance on "xxx" ? =A0atmel_mxt_ts?
>
> What you have before (client->adapter->name) + "/input0" shoudl work
> splendidly.
>
> Thanks.
>
> --
> Dmitry




--
Benson Leung
Software Engineer,=A0Chrom* OS
bleung@chromium.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
