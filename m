From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Fri, 16 Jan 2009 20:36:03 +0100
Message-ID: <20090116193603.GA5401@const.famille.thibault.fr>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk> <20090109214357.GH5073@const.famille.thibault.fr> <20090115074044.GA1599@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:52045 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbZAPTgH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jan 2009 14:36:07 -0500
Content-Disposition: inline
In-Reply-To: <20090115074044.GA1599@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Pavel Machek, le Thu 15 Jan 2009 08:40:44 +0100, a =E9crit :
> On Fri 2009-01-09 22:43:57, Samuel Thibault wrote:
> > Alan Cox, le Fri 09 Jan 2009 21:35:55 +0000, a =E9crit :
> > > Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> > > > Came somebody have a look at this?  The need is real, the only =
question
> > > > that comes to my mind is whether notifiers are allowed to modif=
y the
> > > > param they are given.  Since they are not marked const, I'd gue=
ss it'd
> > > > be ok?
> > >=20
> > > The notifier code doesn't care.
> >=20
> > I know, but I'm asking about current practice.
> >=20
> > > > Make kbd_keycode() read param.value after calling the keyboard =
notification
> > > > chain, to let the callee change the translation on the fly. Thi=
s for instance
> > > > permits to remap the physical positions of the keys independent=
ly of the
> > > > configured keymap, for e.g. single-handed people.
> > >=20
> > > Surely that is just a new keymap ?
> >=20
> > No. That would mean a lot of keymapSSS. Doing it the keymap way
> > would require to have us, us-revert-left, us-revert-right, en-uk,
> > uk-revert-left, uk-revert-right, etc. I really don't like that appr=
oach,
> > thus the "independently of the configured keymap".
>=20
> ...and that is ok if you autogenerate those keymaps, right?
> 									Pavel

I have already answered that, see

http://marc.info/?l=3Dlinux-kernel&m=3D123153985127010&w=3D2

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
