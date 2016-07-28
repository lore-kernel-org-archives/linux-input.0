From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 11:54:09 -0700
Message-ID: <20160728185409.GG16852@dtor-ws>
References: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
 <1469730656.3998.63.camel@perches.com>
 <20160728184003.GE16852@dtor-ws>
 <1469731797.3998.69.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35558 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046AbcG1SyR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 14:54:17 -0400
Content-Disposition: inline
In-Reply-To: <1469731797.3998.69.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 28, 2016 at 11:49:57AM -0700, Joe Perches wrote:
> On Thu, 2016-07-28 at 11:40 -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 28, 2016 at 11:30:56AM -0700, Joe Perches wrote:
> > >=20
> > > On Thu, 2016-07-28 at 11:58 +0200, Benjamin Tissoires wrote:
> > > >=20
> > > > The use of mixed psmouse_printk() and printk creates 2 lines in=
 the log,
> > > > while the use of %*ph solves everything.
> > > >=20
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.co=
m>
> > > > ---
> > > > =A0drivers/input/mouse/elantech.c | 8 ++------
> > > > =A01 file changed, 2 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mou=
se/elantech.c
> > > > index 615d23e..3461d04 100644
> > > > --- a/drivers/input/mouse/elantech.c
> > > > +++ b/drivers/input/mouse/elantech.c
> > > > @@ -222,12 +222,8 @@ static int elantech_write_reg(struct psmou=
se *psmouse, unsigned char reg,
> > > > =A0 */
> > > > =A0static void elantech_packet_dump(struct psmouse *psmouse)
> > > > =A0{
> > > > -	int	i;
> > > > -
> > > > -	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
> > > > -	for (i =3D 0; i < psmouse->pktsize; i++)
> > > > -		printk("%s0x%02x ", i ? ", " : " ", psmouse->packet[i]);
> > > > -	printk("]\n");
> > > > +	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [%*ph]",
> > > > +		=A0=A0=A0=A0=A0=A0=A0psmouse->pktsize, psmouse->packet);
> > > > =A0}
> > > > =A0
> > > > =A0/*
> > > This should add a newline "\n" format termination but
> > I added it, thanks for alerting me.
> >=20
> > >=20
> > > how does the original produce multiple lines of output?
> > >=20
> > > It looks more like psmouse_printk should be removed altogether
> > > and dev_debug should be used instead.
> > That does not produce output by default whereas elantech driver use=
s
> > elantech_packet_dump() to drop unexpected packets.
>=20
> So use dev_printk(KERN_DEBUG, etc...

#define psmouse_printk(level, psmouse, format, ...)	\
	dev_printk(level,				\
		   &(psmouse)->ps2dev.serio->dev,	\
		   psmouse_fmt(format), ##__VA_ARGS__)

I want to see current protocol module in th eoutput and I do not want t=
o
write "&(psmouse)->ps2dev.serio->dev" all the time.

>=20
>=20
> But I still don't see a mechanism for the original code to be
> emitted on multiple lines.

Message from another driver snuck in?

>=20
> How long is the longest packet?
>=20
> This might truncate it.

No, buffer is 8 bytes.

>=20
> Should this be ratelimited?

So far there wasn't a need.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
