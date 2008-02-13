From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Wed, 13 Feb 2008 14:32:27 +0300
Message-ID: <bc64b4640802130332h50415be0s413430f917dfe07d@mail.gmail.com>
References: <20080212101738.GB21039@rakim.wolfsonmicro.main>
	 <1202811705-2303-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	 <fot8b9$b6c$1@ger.gmane.org>
	 <20080213111907.GC31617@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:14516 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756265AbYBMLcd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 06:32:33 -0500
Received: by wr-out-0506.google.com with SMTP id c48so5079923wra.23
        for <linux-input@vger.kernel.org>; Wed, 13 Feb 2008 03:32:32 -0800 (PST)
In-Reply-To: <20080213111907.GC31617@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

2008/2/13, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Feb 12, 2008 at 10:58:50PM +0000, Dmitry Baryshkov wrote:
>
> > You used platform_device_register, but should be using platform_device_add,
> > otherwise you get barfs with 2.6.25-rc1 (device is initialized twice). Also
>
> Thanks for that.  I feel like I should knock up a patch to clarify the
> platform API documentation here.

:)

> > as <sound/driver.h> got deprecated there is no point including it.
>
> Indeed - this is bit rot due to the age of the driver.  Hopefully it
> will make it into at least 2.6.26.

Hope so too. It  should be in the mainline since long ago.

> BTW, could you please keep at least me in the CC list when discussing
> these patches?  It's easy to miss things on the lists and they're one of
> the first things I stop reading when I'm busy.

Sorry. I often reply to the patchserie via gmane and it doesn't honour
non-ml addresses.

-- 
With best wishes
Dmitry
