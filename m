From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Thu, 27 Aug 2009 21:36:36 +0300
Message-ID: <20090827183636.GG26702@sci.fi>
References: <20090827045710.2d8a7010@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.welho.com ([213.243.153.40]:48547 "EHLO smtp6.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbZH0S52 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2009 14:57:28 -0400
Content-Disposition: inline
In-Reply-To: <20090827045710.2d8a7010@pedra.chehab.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

On Thu, Aug 27, 2009 at 04:57:10AM -0300, Mauro Carvalho Chehab wrote:
> After years of analyzing the existing code and receiving/merging patc=
hes
> related to IR, and taking a looking at the current scenario, it is cl=
ear to me
> that something need to be done, in order to have some standard way to=
 map and
> to give precise key meanings for each used media keycode found on
> include/linux/input.h.
>=20
> Just as an example, I've parsed the bigger keymap file we have
> (linux/media/common/ir-common.c). Most IR's have less than 40 keys, m=
ost are
> common between several different models. Yet, we've got almost 500 di=
fferent
> mappings there (and I removed from my parser all the "obvious" keys t=
hat there
> weren't any comment about what is labeled for that key on the IR).
>=20
> The same key name is mapped differently, depending only at the wish o=
f the
> patch author, as shown at:
>=20
> 	http://linuxtv.org/wiki/index.php/Ir-common.c
>=20
> It doesn't come by surprise, but currently, almost all media player
> applications don't care to properly map all those keys.
>=20
> I've tried to find comments and/or descriptions about each media keys=
 defined
> at input.h without success. Just a few keys are commented at the file=
 itself.
> (or maybe I've just seek them at the wrong places).
>=20
> So, I took the initiative of doing a proposition for standardizing th=
ose keys
> at:
>=20
> 	http://linuxtv.org/wiki/index.php/Proposal

I welcome this effort. It would be nice to have some kind of consistent
behaviour between devices. But just limiting the effort to IR devices
doesn't make sense. It shouldn't matter how the device is connected.

=46ASTWORWARD,REWIND,FORWARD and BACK aren't very clear. To me it would
make most sense if FASTFORWARD and REWIND were paired and FORWARD and
BACK were paired. I actually have those two a bit confused in
ati_remote2 too where I used FASTFORWARD and BACK. I suppose it should
be REWIND instead.

Also I should probably use ZOOM for the maximize/restore button (it's
=46RONT now), and maybe SETUP instead of ENTER for another. It has a
picture of a checkbox, Windows software apparently shows a setup menu
when it's pressed.

There are also a couple of buttons where no keycode really seems to
match. One is the mouse button drag. I suppose I could implement the
drag lock feature in the driver but I'm not sure if that's a good idea.
It would make that button special and unmappable. Currently I have that
mapped to EDIT IIRC.

The other oddball button has a picture of a stopwatch (I think, it's
not very clear). Currently it uses COFFEE, but maybe TIMER or something
like that should be added. The Windows software's manual just say it
toggles TV-on-demand, but I have no idea what that actually is.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
