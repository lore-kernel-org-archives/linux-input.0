From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Mon, 12 Jan 2009 22:36:21 +0000
Message-ID: <20090112223621.GA21489@cisco.com>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk> <20090109214357.GH5073@const.famille.thibault.fr> <20090109220144.6b99ed72@lxorguk.ukuu.org.uk> <20090109222341.GI5073@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ams-iport-1.cisco.com ([144.254.224.140]:43020 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762281AbZALWqw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 17:46:52 -0500
Content-Disposition: inline
In-Reply-To: <20090109222341.GI5073@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vg

On Fri, Jan 09, 2009 at 11:23:41PM +0100, Samuel Thibault wrote:
> Alan Cox, le Fri 09 Jan 2009 22:01:44 +0000, a =E9crit :
> > > > Surely that is just a new keymap ?
> > >=20
> > > No. That would mean a lot of keymapSSS. Doing it the keymap way
> >=20
> > Why - its an  algorithmic question about how to edit them - remembe=
r you
> > can edit keymaps in programs at runtime and live.
>=20
> Right. I'm still afraid by that: we'd need to know how to remap the
> various keycodes (amiga, atari, i386, mc, sun).

Err - just use EVIOCSKEYCODE to swap the keycodes around,  this works
in terms of the evdev keycodes.  I use it in a small program to swap
around a bunch of keys.

A bit more of a challange would be listening to evdev,  and when
detecting the 'swap' keycode,  doing the reload with the actual swaps.

I'm not sure w/o reading the code if the kernel will allow this to be
shared between the tty and evdev on the same vt,  but then one could
run a controller program talking through a pty and direct to the keyboa=
rd.

DF
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
