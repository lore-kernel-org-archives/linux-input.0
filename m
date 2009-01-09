From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Fri, 9 Jan 2009 22:43:57 +0100
Message-ID: <20090109214357.GH5073@const.famille.thibault.fr>
References: <20090107005813.GA4987@const.famille.thibault.fr> <20090109212358.GG5073@const.famille.thibault.fr> <20090109213555.7f9275c9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:52016 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbZAIVn7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 16:43:59 -0500
Content-Disposition: inline
In-Reply-To: <20090109213555.7f9275c9@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Alan Cox, le Fri 09 Jan 2009 21:35:55 +0000, a =E9crit :
> Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
>=20
> > Came somebody have a look at this?  The need is real, the only ques=
tion
> > that comes to my mind is whether notifiers are allowed to modify th=
e
> > param they are given.  Since they are not marked const, I'd guess i=
t'd
> > be ok?
>=20
> The notifier code doesn't care.

I know, but I'm asking about current practice.

> > Make kbd_keycode() read param.value after calling the keyboard noti=
fication
> > chain, to let the callee change the translation on the fly. This fo=
r instance
> > permits to remap the physical positions of the keys independently o=
f the
> > configured keymap, for e.g. single-handed people.
>=20
> Surely that is just a new keymap ?

No. That would mean a lot of keymapSSS. Doing it the keymap way
would require to have us, us-revert-left, us-revert-right, en-uk,
uk-revert-left, uk-revert-right, etc. I really don't like that approach=
,
thus the "independently of the configured keymap".

This really is a problem that is orthogonal to keymaps: I'm here talkin=
g
about _physical_ keys remapping, not remapping what is printed on them
(which is done after that).

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
