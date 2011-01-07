From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch
 unification
Date: Thu, 6 Jan 2011 17:14:44 -0800
Message-ID: <20110107011444.GA7262@core.coreip.homeip.net>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
 <20110105174927.GB2146@polaris.bitmath.org>
 <AANLkTikCqufvOgYqqBZLjfmtSdsgyQV4L2HyvEP07+vf@mail.gmail.com>
 <alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64552 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab1AGBOw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jan 2011 20:14:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 06, 2011 at 04:11:46PM +0100, Jiri Kosina wrote:
> On Thu, 6 Jan 2011, Benjamin Tissoires wrote:
>=20
> > Hi Henrik,
> >=20
> > thanks for the future review ;)
> >=20
> > Well, patches n=B0 3,4,5,6 and 7 are only those sent by St=E9phane =
and
> > reviewed by you 3 months ago with small changes:
> >   - I took into account most of your comments
> >   - I inserted suspend/resume support
> >   - I implemented a way to find out the end of a mt report.
> >=20
> > Patch 1 (hid: add feature_mapping callback) is new but not very
> > dangerous I think: it only adds a hook. Thanks to it, I could retri=
eve
> > the magic number which is device-specific.
> >=20
> > Patch 2 (hid: set HID_MAX_FIELD at 128) may need further discussion=
s
> > (but is required to use Stantum panels)
> >=20
> > the last patches only introduce support for 3 devices, 1 of them is
> > new for the kernel.
> >=20
> > The point is that currently we have users that want to have a prope=
r
> > support for their device (PixCir, Cypress TrueTouch and GeneralTouc=
h),
> > and it's a shame to ask them to wait for 3 more months.
> >=20
> > Maybe a solution would be to make what we can here during this merg=
e
> > window to add support for at least the new devices. Then, in 2.6.39
> > and above, we could still migrate other devices, and eventually mod=
ify
> > some lines in the code.
> >=20
> > Jiri, Dmitry, what do you think?
>=20
> I still have to go through the patchset, my backlog has grown very ba=
dly=20
> recently, sorry.
>=20
> In case the patchset doesn't impose danger of regressions for already=
=20
> existing devices, we could merge this new 'unified' driver only for n=
ewly=20
> supported devices, and finish the unification in 2.6.39.
>=20

Yep, let's merge the dirver and all new devices in this round and then
get ready to convert already supported devices in next window.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
