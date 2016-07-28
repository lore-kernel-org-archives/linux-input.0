From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 11:40:03 -0700
Message-ID: <20160728184003.GE16852@dtor-ws>
References: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
 <1469730656.3998.63.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34822 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbcG1SkG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 14:40:06 -0400
Content-Disposition: inline
In-Reply-To: <1469730656.3998.63.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 28, 2016 at 11:30:56AM -0700, Joe Perches wrote:
> On Thu, 2016-07-28 at 11:58 +0200, Benjamin Tissoires wrote:
> > The use of mixed psmouse_printk() and printk creates 2 lines in the=
 log,
> > while the use of %*ph solves everything.
> >=20
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > =A0drivers/input/mouse/elantech.c | 8 ++------
> > =A01 file changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/e=
lantech.c
> > index 615d23e..3461d04 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -222,12 +222,8 @@ static int elantech_write_reg(struct psmouse *=
psmouse, unsigned char reg,
> > =A0 */
> > =A0static void elantech_packet_dump(struct psmouse *psmouse)
> > =A0{
> > -	int	i;
> > -
> > -	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
> > -	for (i =3D 0; i < psmouse->pktsize; i++)
> > -		printk("%s0x%02x ", i ? ", " : " ", psmouse->packet[i]);
> > -	printk("]\n");
> > +	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [%*ph]",
> > +		=A0=A0=A0=A0=A0=A0=A0psmouse->pktsize, psmouse->packet);
> > =A0}
> > =A0
> > =A0/*
>=20
> This should add a newline "\n" format termination but

I added it, thanks for alerting me.

> how does the original produce multiple lines of output?
>=20
> It looks more like psmouse_printk should be removed altogether
> and dev_debug should be used instead.

That does not produce output by default whereas elantech driver uses
elantech_packet_dump() to drop unexpected packets.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
