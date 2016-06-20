From: Anthony Wong <anthony.wong@canonical.com>
Subject: Re: Canonical has own Ubuntu driver for ALPS 73 03 28 devices
Date: Tue, 21 Jun 2016 01:29:41 +0800
Message-ID: <CAE7LaDDBOqAaZP38tX4kuzd2108np+0xb0BgtcAoKFfo9QmikQ@mail.gmail.com>
References: <201606190143.46444@pali> <20160620101636.GA23462@infradead.org> <20160620102034.GI29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34451 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbcFTRjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 13:39:00 -0400
Received: by mail-ob0-f169.google.com with SMTP id y7so543070obt.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2016 10:38:36 -0700 (PDT)
In-Reply-To: <20160620102034.GI29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ben Gamari <ben@smart-cactus.org>, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Ben Morgan <Ben_Morgan@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 20 June 2016 at 18:20, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote:
>
> On Monday 20 June 2016 03:16:36 Christoph Hellwig wrote:
> > On Sun, Jun 19, 2016 at 01:43:46AM +0200, Pali Roh??r wrote:
> > > I do not understand it... Why Canonical is hidden and don't commu=
nicate
> > > with rest of world? Otherwise touchpads could work out-of-box on =
non
> > > Ubuntu systems too with mainline kernel.
> >
>
> It must be really frustrating for Ben and other people (me too) who i=
n
> last months working on ALPS patches to support that touchpad as we kn=
ow
> that Canonical already had some working code for that touchpad...

Hi Pali,

The fix in the DKMS package you referenced was not written by
Canonical but by ALPS, as it came from them I think it is reasonable
they send it to upstream, isn't it? As you can see the patch is non-tri=
vial.

After we got the patch from ALPS, we had follow-up conversation a few
times with our contacts at Taiwan and asked if they would upstream it,
but unfortunately to no avail. I am as desperate as you if the fix
cannot land in mainline, which means many Linux users will not benefit
from it.  We also had opened this bug [1] for this particular issue,
there is nothing to hide. If there is any code written by us, we
happily submit them upstream.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1571530

> On Monday 20 June 2016 03:16:36 Christoph Hellwig wrote:
> > Because Canonical doesn't collaborate with the upstream community
> > in any meaninful way.  They've been a bad player since day 1 and wi=
ll
> > always be.

This reminded me of this old thread [2]. How hard is it to run this
command in your kernel git tree?

    $ git log --pretty=3Doneline --author=3Dcanonical

[2] https://www.spinics.net/lists/linux-bluetooth/msg47286.html

Thanks,
Anthony
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
