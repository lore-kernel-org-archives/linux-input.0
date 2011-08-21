From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/6] input: misc: AD714x: The interrupt status
 registers should be read in row.
Date: Sun, 21 Aug 2011 13:09:22 -0700
Message-ID: <20110821200921.GA17891@core.coreip.homeip.net>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
 <544AC56F16B56944AEC3BD4E3D5917713AAF21C14E@LIMKCMBX1.ad.analog.com>
 <20110518071428.GA32284@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917713AAF21C871@LIMKCMBX1.ad.analog.com>
 <20110519080042.GA19405@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D59177143003C5938@LIMKCMBX1.ad.analog.com>
 <20110804075426.GB31276@core.coreip.homeip.net>
 <4E44EB33.7090302@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:42483 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1HUUJ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 16:09:28 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so9091424iye.1
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 13:09:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E44EB33.7090302@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On Fri, Aug 12, 2011 at 10:58:27AM +0200, Michael Hennerich wrote:
> On 08/04/2011 09:54 AM, Dmitry Torokhov wrote:
> >On Wed, Aug 03, 2011 at 09:40:22AM +0100, Hennerich, Michael wrote:
> >>Hennerich, Michael wrote on 2011-07-13:
> >>>Dmitry Torokhov wrote on 2011-05-19:
> >>>>On Wed, May 18, 2011 at 08:10:09PM +0100, Hennerich, Michael wrote:
> >>>>>Dmitry Torokhov wrote on 2011-05-18:
> >>>>>>On Tue, May 17, 2011 at 12:01:27PM +0100, Hennerich, Michael wrote:
> >>>>>>>Hi Dmitry,
> >>>>>>>
> >>>>>>>I noticed you added patches 2/6, 3/6, 4/6 and 5/6 to your next tree.
> >>>>>>>But how about these ones?
> >>>>>>>
> >>>>>>>[PATCH v2 1/6] input: misc: AD714x: The interrupt status
> >>>>>>>registers should be read in row. [PATCH v2 6/6] input: misc:
> >>>>>>>AD714x: Fix endianness issues.
> >>>>>>>
> >>>>>>Hi Michael,
> >>>>>>
> >>>>>>Still pondering these two, give me a couple of days please...
> >>>>>>
> >>>>>>Thanks.
> >>>>>>
> >>>>>Hi Dmitry,
> >>>>>
> >>>>>No Problem - let me know in case you need some further clarification.
> >>>>>Both patches are tested on several platforms and addresses real issues.
> >>>>>
> >>>>>BTW - are you going to merge the adp5589 driver anytime soon?
> >>>>>Are there open issues you like to get addressed first?
> >>>>>
> >>>>Oh, thanks for reminding me of it, I queued it for .40.
> >>>>
> >>>>Thanks.
> >>>>
> >>>Hi Dmitry,
> >>>
> >>>Still pondering these two?
> >>>
> >>>[PATCH v2 1/6] input: misc: AD714x:
> >>>       The interrupt status registers should be read in row.
> >>>[PATCH v2 6/6] input: misc: AD714x: Fix endianness issues.
> >>>
> >>>Greetings,
> >>>Michael
> >>>
> >>Hi Dmitry,
> >>
> >>Are you going to apply these two missing patches?
> >>
> >Hi Michael,
> >
> >Yes, should be in the next pull (not todays one).
> >
> >Thanks.
> >
> Hi Dmitry,
> 
> Hmmm... Are you sure?
> I can't find it.

Hi Michael,

No, I haven't applied it yet, sorry. I was looking through the code and
realized that spi_write requires use of DMA-safe buffers. Also, if we
are concerned with performance we should not use spi_write_then_read,
but rather use the same buffer we'll be using for spi_write and avoid
locking and extra copying.

I'll be sending updated version out shortly and if I did not mess up and
it still works fro you then I swear I'll apply it ;)

Thanks.

-- 
Dmitry
