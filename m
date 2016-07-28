From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 11:49:57 -0700
Message-ID: <1469731797.3998.69.camel@perches.com>
References: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1469730656.3998.63.camel@perches.com> <20160728184003.GE16852@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:56178 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756855AbcG1SuB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 14:50:01 -0400
In-Reply-To: <20160728184003.GE16852@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-07-28 at 11:40 -0700, Dmitry Torokhov wrote:
> On Thu, Jul 28, 2016 at 11:30:56AM -0700, Joe Perches wrote:
> >=20
> > On Thu, 2016-07-28 at 11:58 +0200, Benjamin Tissoires wrote:
> > >=20
> > > The use of mixed psmouse_printk() and printk creates 2 lines in t=
he log,
> > > while the use of %*ph solves everything.
> > >=20
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > > =A0drivers/input/mouse/elantech.c | 8 ++------
> > > =A01 file changed, 2 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse=
/elantech.c
> > > index 615d23e..3461d04 100644
> > > --- a/drivers/input/mouse/elantech.c
> > > +++ b/drivers/input/mouse/elantech.c
> > > @@ -222,12 +222,8 @@ static int elantech_write_reg(struct psmouse=
 *psmouse, unsigned char reg,
> > > =A0 */
> > > =A0static void elantech_packet_dump(struct psmouse *psmouse)
> > > =A0{
> > > -	int	i;
> > > -
> > > -	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
> > > -	for (i =3D 0; i < psmouse->pktsize; i++)
> > > -		printk("%s0x%02x ", i ? ", " : " ", psmouse->packet[i]);
> > > -	printk("]\n");
> > > +	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [%*ph]",
> > > +		=A0=A0=A0=A0=A0=A0=A0psmouse->pktsize, psmouse->packet);
> > > =A0}
> > > =A0
> > > =A0/*
> > This should add a newline "\n" format termination but
> I added it, thanks for alerting me.
>=20
> >=20
> > how does the original produce multiple lines of output?
> >=20
> > It looks more like psmouse_printk should be removed altogether
> > and dev_debug should be used instead.
> That does not produce output by default whereas elantech driver uses
> elantech_packet_dump() to drop unexpected packets.

So use dev_printk(KERN_DEBUG, etc...


But I still don't see a mechanism for the original code to be
emitted on multiple lines.

How long is the longest packet?

This might truncate it.

Should this be ratelimited?

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
