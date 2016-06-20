From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Canonical has own Ubuntu driver for ALPS 73 03 28 devices
Date: Mon, 20 Jun 2016 10:37:57 -0700
Message-ID: <20160620173757.GB22426@dtor-ws>
References: <201606190143.46444@pali>
 <20160620101636.GA23462@infradead.org>
 <20160620102034.GI29844@pali>
 <CAE7LaDDBOqAaZP38tX4kuzd2108np+0xb0BgtcAoKFfo9QmikQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33247 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcFTRjA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 13:39:00 -0400
Content-Disposition: inline
In-Reply-To: <CAE7LaDDBOqAaZP38tX4kuzd2108np+0xb0BgtcAoKFfo9QmikQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anthony Wong <anthony.wong@canonical.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Christoph Hellwig <hch@infradead.org>, Ben Gamari <ben@smart-cactus.org>, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Ben Morgan <Ben_Morgan@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 21, 2016 at 01:29:41AM +0800, Anthony Wong wrote:
> On 20 June 2016 at 18:20, Pali Roh=E1r <pali.rohar@gmail.com> wrote:
> >
> > On Monday 20 June 2016 03:16:36 Christoph Hellwig wrote:
> > > On Sun, Jun 19, 2016 at 01:43:46AM +0200, Pali Roh??r wrote:
> > > > I do not understand it... Why Canonical is hidden and don't com=
municate
> > > > with rest of world? Otherwise touchpads could work out-of-box o=
n non
> > > > Ubuntu systems too with mainline kernel.
> > >
> >
> > It must be really frustrating for Ben and other people (me too) who=
 in
> > last months working on ALPS patches to support that touchpad as we =
know
> > that Canonical already had some working code for that touchpad...
>=20
> Hi Pali,
>=20
> The fix in the DKMS package you referenced was not written by
> Canonical but by ALPS, as it came from them I think it is reasonable
> they send it to upstream, isn't it? As you can see the patch is non-t=
rivial.
>=20
> After we got the patch from ALPS, we had follow-up conversation a few
> times with our contacts at Taiwan and asked if they would upstream it=
,
> but unfortunately to no avail. I am as desperate as you if the fix
> cannot land in mainline, which means many Linux users will not benefi=
t
> from it.  We also had opened this bug [1] for this particular issue,
> there is nothing to hide. If there is any code written by us, we
> happily submit them upstream.

Why couldn't you guys send it upstream yourselves?

>=20
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1571530
>=20
> > On Monday 20 June 2016 03:16:36 Christoph Hellwig wrote:
> > > Because Canonical doesn't collaborate with the upstream community
> > > in any meaninful way.  They've been a bad player since day 1 and =
will
> > > always be.
>=20
> This reminded me of this old thread [2]. How hard is it to run this
> command in your kernel git tree?
>=20
>     $ git log --pretty=3Doneline --author=3Dcanonical
>=20
> [2] https://www.spinics.net/lists/linux-bluetooth/msg47286.html
>=20
> Thanks,
> Anthony

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
