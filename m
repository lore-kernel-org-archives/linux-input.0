From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mousedev - fix regression of inverting axes
Date: Sat, 21 Aug 2010 09:49:29 -0700
Message-ID: <20100821164929.GA13677@core.coreip.homeip.net>
References: <20100820223316.4f6ac734@neptune.home>
 <20100821135002.GA3357@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63705 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0HUQte (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Aug 2010 12:49:34 -0400
Content-Disposition: inline
In-Reply-To: <20100821135002.GA3357@lovely.krouter>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 21, 2010 at 03:50:03PM +0200, Christoph Fritz wrote:
> On Fri, Aug 20, 2010 at 10:33:16PM +0200, Bruno Pr=E9mont wrote:
> > Somewhere between 2.6.35 and Linus's tree as of this writing gpm
> > started moving its cursor to the opposite direction of mouse moveme=
nt.
> >=20
> > e.g. moving mouse up causes cursor to move down, moving mouse left
> >      causes cursor to go right
> >=20
> > Under 2.6.35 the cursor moved into the same direction as the mouse.
> >=20
> > Note, mouse is synaptics touchpad (Acer TravelMate660):
> >   Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x9047=
13/0x4006/0x0
> >=20
> >=20
> > When I get around to it I will try to get more precise information =
as
> > to when this regression got introduced, eventually bisecting.
> >=20
> > Bruno
>=20
> Thanks Bruno,
>  I successfully tested the patch below with gpm.
>=20
> ---
> Introduced by 987a6c0298260b7aa40702b349282554d6180e4b a swap in max/=
min
> calculation gets fixed by this patch.
>=20
> Reported-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

Applied, thanks Christoph.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
