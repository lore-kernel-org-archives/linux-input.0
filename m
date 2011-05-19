From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/6] input: misc: AD714x: The interrupt status
 registers should be read in row.
Date: Thu, 19 May 2011 01:00:43 -0700
Message-ID: <20110519080042.GA19405@core.coreip.homeip.net>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
 <544AC56F16B56944AEC3BD4E3D5917713AAF21C14E@LIMKCMBX1.ad.analog.com>
 <20110518071428.GA32284@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917713AAF21C871@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40117 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab1ESIAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 04:00:49 -0400
Received: by pzk9 with SMTP id 9so1073803pzk.19
        for <linux-input@vger.kernel.org>; Thu, 19 May 2011 01:00:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF21C871@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On Wed, May 18, 2011 at 08:10:09PM +0100, Hennerich, Michael wrote:
> Dmitry Torokhov wrote on 2011-05-18:
> > On Tue, May 17, 2011 at 12:01:27PM +0100, Hennerich, Michael wrote:
> >> Hi Dmitry,
> >>
> >> I noticed you added patches 2/6, 3/6, 4/6 and 5/6 to your next tree.
> >> But how about these ones?
> >>
> >> [PATCH v2 1/6] input: misc: AD714x: The interrupt status registers
> >> should be read in row. [PATCH v2 6/6] input: misc: AD714x: Fix
> >> endianness issues.
> >>
> >
> > Hi Michael,
> >
> > Still pondering these two, give me a couple of days please...
> >
> > Thanks.
> >
> 
> Hi Dmitry,
> 
> No Problem - let me know in case you need some further clarification.
> Both patches are tested on several platforms and addresses real issues.
> 
> BTW - are you going to merge the adp5589 driver anytime soon?
> Are there open issues you like to get addressed first?
> 

Oh, thanks for reminding me of it, I queued it for .40.

Thanks.

-- 
Dmitry
