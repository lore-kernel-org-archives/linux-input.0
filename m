From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Tue, 13 Jan 2009 02:45:45 +0100
Message-ID: <20090113014545.GG5026@const.famille.thibault.fr>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk> <20090109214357.GH5073@const.famille.thibault.fr> <20090109220144.6b99ed72@lxorguk.ukuu.org.uk> <20090109222341.GI5073@const.famille.thibault.fr> <20090112223621.GA21489@cisco.com> <20090112225112.GE5026@const.famille.thibault.fr> <20090113010613.GA23244@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:53467 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbZAMBpr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 20:45:47 -0500
Content-Disposition: inline
In-Reply-To: <20090113010613.GA23244@cisco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derek Fawcus <dfawcus@cisco.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Derek Fawcus, le Tue 13 Jan 2009 01:06:13 +0000, a =E9crit :
> > Yes, that seems a bit unsafe to me.  Another solution is to just gr=
ab
> > all the keyboard devices, and reemit the wanted evdev keycodes.  Qu=
ite
> > clumsy.
>=20
> reemit?  as in inject back to the kernel?

Through uinput, yes.

> How does one prevent loops?

By not grabbing the evdev corresponding to your own uinput dev.  IIRC i=
t
can even work with several daemons doing so, the last being only able t=
o
grab the last uinput's evdev.  If a daemon hangs, no luck, however.

> > > I'm not sure w/o reading the code if the kernel will allow this t=
o be
> > > shared between the tty and evdev on the same vt,
> >=20
> > What do you mean by "this"?
>=20
> I was referring to being able to read the evdev data from the keyboar=
d
> while still allowing the vt to consume the data.  Can one filter out
> just keys of interest,  or will reading the /dev/input/eventX prevent
> the keys being fed to the vt and hence to /dev/ttyXX?

Grabbing does prevent it yes.  But feeding through uinput puts it back
to the console.

> > > but then one could run a controller program talking through a pty=
 and
> > > direct to the keyboard.
> >=20
> > Ugh.  I'd prefer grabing evdev rather that using a pty.
>=20
> Well using the pty is not too bad,  and some stuff seems unhappy unle=
ss
> fed from a tty of some form (default line buffering for stdin/stdout,
> job control with bash).

The problem with ptys too is that they manipulate letters, not physical
key position, thus loosing keyboard mapping independence.

> Anyway,  wouldn't this all be easier with a app running on X and
> XKEYBOARD/XKB manipulations?  Have the key that does left/right
> swapping simply be a group toggle action in the definition file.

Sure, but sometimes you're left without X, and that's not a reason for
suddenly completely loose typing speed.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
