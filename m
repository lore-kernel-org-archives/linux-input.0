From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Thu, 20 Feb 2014 16:32:32 +0100
Message-ID: <1704627.ofpQG3zTEH@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <7140464.ckcuvrghVW@geidi-prime> <alpine.LNX.2.00.1402201616270.1192@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:34729 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbaBTPck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 10:32:40 -0500
In-Reply-To: <alpine.LNX.2.00.1402201616270.1192@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Simon Wood <simon@mungewell.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thursday 20 of February 2014 16:16:52 Jiri Kosina wrote:
> On Wed, 5 Feb 2014, Michal Mal=FD wrote:
> > > > We need to think carefully on this as a '+10' combined with '-1=
0'
> > > > force
> > > > will result in '0'; however we do not want to deactivate the wh=
eel
> > > > (no-resistance mode) as this will result in 'ticking' on the wh=
eel as
> > > > force transitions through 0.... ideally we'd need to know that =
there
> > > > are
> > > > no forces set.
> > >=20
> > > No problem Simon, this is thought about:
> > > If forces are active, and they cancel out, hid_lg4ff_start_combin=
ed is
> > > called with 0 force (scaled_x =3D 0x80), instead of
> > > hid_lg4ff_stop_combined
> > > as you assumed.
> >=20
> > Okay, so to set things straight: I should modify to patch to send 0=
x13
> > when
> > the effect is fully stopped and use 0x11 0x80 to only zeroize the f=
orce
> > when the overall force is zero? My DFP doesn't differentiate betwee=
n
> > these states so I cannot tell what is the right thing to do.
>=20
> Has there been any conclusion to this, please?

Yes the has and the necessary fix is already in place in my working cop=
y along=20
with another few fixed to the ff-memless-next. Do you consider our appr=
oach=20
sane and viable for mainlining? I've already explained to Joe Perches w=
hy I=20
propose ff-memless-next as a separate module rather than a patch to ff-=
memless=20
we have now. Unless anybody has any objections I'll check in with the r=
est of=20
the guys and submit a hopefully final version within a day or two.

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
