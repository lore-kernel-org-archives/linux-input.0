From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 9 Jun 2015 19:16:07 +0200
Message-ID: <20150609171607.GA4336@type.youpi.perso.aquilenet.fr>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609131955.GA3045@type>
 <20150609132734.GA3132@type>
 <20150609165052.GE6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]:53155 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbFIRQO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 13:16:14 -0400
Content-Disposition: inline
In-Reply-To: <20150609165052.GE6338@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Dmitry Torokhov, le Tue 09 Jun 2015 09:50:52 -0700, a =E9crit :
> On Tue, Jun 09, 2015 at 03:27:34PM +0200, Samuel Thibault wrote:
> > Samuel Thibault, le Tue 09 Jun 2015 15:19:55 +0200, a =E9crit :
> > > > +	[LED_NUML]	=3D { "num-lock", VT_TRIGGER("kbd-numlock") },
> > > > +	[LED_CAPSL]	=3D { "caps-lock", VT_TRIGGER("kbd-capslock") },
> > > > +	[LED_SCROLLL]	=3D { "scroll-lock", VT_TRIGGER("kbd-scrollock"=
) },
> > >=20
> > > I'd tend to think we'd want to harmonize the user-visible LED nam=
es and
> > > kbd trigger names,
> >=20
> > And perhaps fix that odd-looking "scrollock"?
>=20
> If you are talking about LED_SCROLLL

I mean kbd-scrollock in the above code which looks like a typo to me.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
