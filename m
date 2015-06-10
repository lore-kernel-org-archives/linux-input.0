From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 10 Jun 2015 08:34:43 +0200
Message-ID: <20150610063443.GA10886@amd>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609131955.GA3045@type>
 <20150609164935.GD6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59313 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbbFJGep (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2015 02:34:45 -0400
Content-Disposition: inline
In-Reply-To: <20150609164935.GD6338@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue 2015-06-09 09:49:35, Dmitry Torokhov wrote:
> On Tue, Jun 09, 2015 at 03:19:55PM +0200, Samuel Thibault wrote:
> > Hello,
> >=20
> > Dmitry Torokhov, le Mon 08 Jun 2015 14:43:08 -0700, a =E9crit :
> > > 1. Instead of making LED class devices part of the input device t=
hey are
> > > implemented as an input handler (and thus are completely separate=
 from
> > > input core).
> >=20
> > That's nicer indeed.  Not defining triggers per LED however does no=
t
> > permit to e.g. switch two leds of a keyboard independently of what
> > produces input events.  I'm personally fine with it, I just wanted =
to
> > mention it since this example of usage was cited at some point in t=
he
> > thread.
>=20
> I might have over-though the issue a bit in the past ;) But I think I=
 am
> happy with the current behavior, it separates input events and leds a=
nd
> just says that you can select what tgrigges led state change. And you
> shoudl still be able to do:
>=20
> echo "kbd-ctrlllock" > /sys/..../input22::caps-lock/trigger
> echo "heartbit" > /sys/..../input22::num-lock/trigger
> echo "kbd-numlock" > /sys/..../input22::scroll-lock/trigger
>=20
> But you can't say that pressing CapsLock on keyboard1 should light up
> ScrollLock led on keyboard2, nor do we want it I think. If such contr=
ol
> is truly needed userspace can take over and managed leds as it sees f=
it,
> like X does.

Ack. Please keep it simple.
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
