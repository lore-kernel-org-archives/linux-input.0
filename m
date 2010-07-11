From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Sun, 11 Jul 2010 23:07:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007112306270.4741@pobox.suse.cz>
References: <878w5qaspq.fsf@troilus.org> <1278347288.2425.21.camel@cndougla>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41830 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab0GKVHM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jul 2010 17:07:12 -0400
In-Reply-To: <1278347288.2425.21.camel@cndougla>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org

On Mon, 5 Jul 2010, Chase Douglas wrote:

> On Mon, 2010-07-05 at 10:50 -0400, Michael Poole wrote:
> > The X and Y values have two more significant bits in the same byte
> > that contains click status.  Include these in the reported value.
> > Thanks to Iain Hibbert of NetBSD for pointing this out.
> > 
> > Signed-off-by: Michael Poole <mdpoole@troilus.org>
> > ---
> >  drivers/hid/hid-magicmouse.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> > index 0b89c1c..7cdda23 100644
> > --- a/drivers/hid/hid-magicmouse.c
> > +++ b/drivers/hid/hid-magicmouse.c
> > @@ -267,8 +267,8 @@ static int magicmouse_raw_event(struct hid_device *hdev,
> >  		 * to have the current touch information before
> >  		 * generating a click event.
> >  		 */
> > -		x = (signed char)data[1];
> > -		y = (signed char)data[2];
> > +		x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
> > +		y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
> >  		clicks = data[3];
> >  		break;
> >  	case 0x20: /* Theoretically battery status (0-100), but I have
> 
> Looks right to me.
> 
> Acked-by: Chase Douglas <chase.douglas@canonical.com>

Thanks. Applied to magicmouse branch now.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
