From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Mon, 12 Jan 2009 23:51:12 +0100
Message-ID: <20090112225112.GE5026@const.famille.thibault.fr>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk> <20090109214357.GH5073@const.famille.thibault.fr> <20090109220144.6b99ed72@lxorguk.ukuu.org.uk> <20090109222341.GI5073@const.famille.thibault.fr> <20090112223621.GA21489@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:55971 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbZALWvP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 17:51:15 -0500
Content-Disposition: inline
In-Reply-To: <20090112223621.GA21489@cisco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derek Fawcus <dfawcus@cisco.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Derek Fawcus, le Mon 12 Jan 2009 22:36:21 +0000, a =E9crit :
> On Fri, Jan 09, 2009 at 11:23:41PM +0100, Samuel Thibault wrote:
> > Alan Cox, le Fri 09 Jan 2009 22:01:44 +0000, a =E9crit :
> > > > > Surely that is just a new keymap ?
> > > >=20
> > > > No. That would mean a lot of keymapSSS. Doing it the keymap way
> > >=20
> > > Why - its an  algorithmic question about how to edit them - remem=
ber you
> > > can edit keymaps in programs at runtime and live.
> >=20
> > Right. I'm still afraid by that: we'd need to know how to remap the
> > various keycodes (amiga, atari, i386, mc, sun).
>=20
> Err - just use EVIOCSKEYCODE to swap the keycodes around,  this works
> in terms of the evdev keycodes.  I use it in a small program to swap
> around a bunch of keys.
>=20
> A bit more of a challange would be listening to evdev,  and when
> detecting the 'swap' keycode,  doing the reload with the actual swaps=
=2E

Yes, that seems a bit unsafe to me.  Another solution is to just grab
all the keyboard devices, and reemit the wanted evdev keycodes.  Quite
clumsy.

> I'm not sure w/o reading the code if the kernel will allow this to be
> shared between the tty and evdev on the same vt,

What do you mean by "this"?  The raw keycode -> input keycode
translation?  My guess is that it is recorded for the device itself, no=
t
related to things like VTs, and thus is global.

> but then one could run a controller program talking through a pty and
> direct to the keyboard.

Ugh.  I'd prefer grabing evdev rather that using a pty.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
