From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Mon, 05 Jul 2010 16:02:00 -0400
Message-ID: <1278360120.2425.97.camel@cndougla>
References: <878w5qaspq.fsf@troilus.org>
	 <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:38665 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab0GEUCG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 16:02:06 -0400
In-Reply-To: <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Michael Poole <mdpoole@troilus.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tue, 2010-07-06 at 03:54 +0800, Ping Cheng wrote:
> On Mon, Jul 5, 2010 at 10:50 PM, Michael Poole <mdpoole@troilus.org> wrote:
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
> >                 * to have the current touch information before
> >                 * generating a click event.
> >                 */
> > -               x = (signed char)data[1];
> > -               y = (signed char)data[2];
> > +               x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
> > +               y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
> 
> Will the following give us the same result?
> 
>  +               x = (int)(((data[3] & 0x0c) << 6) | data[1]);
>  +               y = (int)(((data[3] & 0x30) << 4) | data[2]);

I thought about this too, but there's a sign extension issue. If the X
coordinate is -1 (these are relative coordinates), then you will end up
with (int)(1023), which is no longer -1.

When you shift to the right, the bits are sign-extended. Thus, shifting
everything to the most significant bit of an integer, and then shifting
everything back to the least significant will properly sign extend.

(I actually wrote a test program just to verify this)

That's just a reason for the shifts. There very well could be a more
elegant solution.

-- Chase

