From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Thu, 15 Jan 2009 08:40:44 +0100
Message-ID: <20090115074044.GA1599@ucw.cz>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk> <20090109214357.GH5073@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36249 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937024AbZAPTM2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jan 2009 14:12:28 -0500
Content-Disposition: inline
In-Reply-To: <20090109214357.GH5073@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vg

On Fri 2009-01-09 22:43:57, Samuel Thibault wrote:
> Alan Cox, le Fri 09 Jan 2009 21:35:55 +0000, a =E9crit :
> > Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> >=20
> > > Came somebody have a look at this?  The need is real, the only qu=
estion
> > > that comes to my mind is whether notifiers are allowed to modify =
the
> > > param they are given.  Since they are not marked const, I'd guess=
 it'd
> > > be ok?
> >=20
> > The notifier code doesn't care.
>=20
> I know, but I'm asking about current practice.
>=20
> > > Make kbd_keycode() read param.value after calling the keyboard no=
tification
> > > chain, to let the callee change the translation on the fly. This =
for instance
> > > permits to remap the physical positions of the keys independently=
 of the
> > > configured keymap, for e.g. single-handed people.
> >=20
> > Surely that is just a new keymap ?
>=20
> No. That would mean a lot of keymapSSS. Doing it the keymap way
> would require to have us, us-revert-left, us-revert-right, en-uk,
> uk-revert-left, uk-revert-right, etc. I really don't like that approa=
ch,
> thus the "independently of the configured keymap".

=2E..and that is ok if you autogenerate those keymaps, right?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
