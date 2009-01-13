From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Tue, 13 Jan 2009 01:06:13 +0000
Message-ID: <20090113010613.GA23244@cisco.com>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk> <20090109214357.GH5073@const.famille.thibault.fr> <20090109220144.6b99ed72@lxorguk.ukuu.org.uk> <20090109222341.GI5073@const.famille.thibault.fr> <20090112223621.GA21489@cisco.com> <20090112225112.GE5026@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ams-iport-1.cisco.com ([144.254.224.140]:24391 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZAMBGr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 20:06:47 -0500
Content-Disposition: inline
In-Reply-To: <20090112225112.GE5026@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Mon, Jan 12, 2009 at 11:51:12PM +0100, Samuel Thibault wrote:
> Derek Fawcus, le Mon 12 Jan 2009 22:36:21 +0000, a =E9crit :
> > On Fri, Jan 09, 2009 at 11:23:41PM +0100, Samuel Thibault wrote:
> > > Alan Cox, le Fri 09 Jan 2009 22:01:44 +0000, a =E9crit :
> > > > > > Surely that is just a new keymap ?
> > > > >=20
> > > > > No. That would mean a lot of keymapSSS. Doing it the keymap w=
ay
> > > >=20
> > > > Why - its an  algorithmic question about how to edit them - rem=
ember you
> > > > can edit keymaps in programs at runtime and live.
> > >=20
> > > Right. I'm still afraid by that: we'd need to know how to remap t=
he
> > > various keycodes (amiga, atari, i386, mc, sun).
> >=20
> > Err - just use EVIOCSKEYCODE to swap the keycodes around,  this wor=
ks
> > in terms of the evdev keycodes.  I use it in a small program to swa=
p
> > around a bunch of keys.
> >=20
> > A bit more of a challange would be listening to evdev,  and when
> > detecting the 'swap' keycode,  doing the reload with the actual swa=
ps.
>=20
> Yes, that seems a bit unsafe to me.  Another solution is to just grab
> all the keyboard devices, and reemit the wanted evdev keycodes.  Quit=
e
> clumsy.

reemit?  as in inject back to the kernel?  How does one prevent loops?

If one is able to in effect divert the event stream out of the kernel
and then back in to the normal evdev-> keyboard stream that would seem
a workable approach.

> > I'm not sure w/o reading the code if the kernel will allow this to =
be
> > shared between the tty and evdev on the same vt,
>=20
> What do you mean by "this"?

I was referring to being able to read the evdev data from the keyboard
while still allowing the vt to consume the data.  Can one filter out
just keys of interest,  or will reading the /dev/input/eventX prevent
the keys being fed to the vt and hence to /dev/ttyXX?
(Don't have source on this machine,  so can't easily check).

> The raw keycode -> input keycode
> translation?  My guess is that it is recorded for the device itself, =
not
> related to things like VTs, and thus is global.

Yup that is - my program for remapping affects all VTs - and more to
the point - X11 as well.

> > but then one could run a controller program talking through a pty a=
nd
> > direct to the keyboard.
>=20
> Ugh.  I'd prefer grabing evdev rather that using a pty.

Well using the pty is not too bad,  and some stuff seems unhappy unless
fed from a tty of some form (default line buffering for stdin/stdout,
job control with bash).

However,  having written a prog for some of the pty interaction,  it is
a lot larger that the diff you posted.

Anyway,  wouldn't this all be easier with a app running on X and
XKEYBOARD/XKB manipulations?  Have the key that does left/right
swapping simply be a group toggle action in the definition file.

DF
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
