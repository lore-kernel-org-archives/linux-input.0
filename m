From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v7] input: tegra-kbc - Add tegra keyboard driver
Date: Thu, 20 Jan 2011 09:55:31 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A008083@HQMAIL03.nvidia.com>
References: <1295485917-21278-1-git-send-email-riyer@nvidia.com>
 <4D37E265.9060304@codeaurora.org>
 <20110120072948.GA30522@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:1825 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab1ATR4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 12:56:06 -0500
In-Reply-To: <20110120072948.GA30522@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, Trilok Soni <tsoni@codeaurora.org>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "shubhrajyoti@ti.com" <shubhrajyoti@ti.com>, "ccross@android.com" <ccross@android.com>, "konkers@android.com" <konkers@android.com>, "olof@lixom.net" <olof@lixom.net>, Andrew Chew <AChew@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry, The copyright changes are okay, so you can do them and push them. 

Dmitry, Trilok, Pavel and Shubhraj thanks for the review and modifications.

Regards
Rakesh

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, January 19, 2011 11:30 PM
> To: Trilok Soni
> Cc: Rakesh Iyer; pavel@ucw.cz; shubhrajyoti@ti.com; ccross@android.com;
> konkers@android.com; olof@lixom.net; Andrew Chew; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-input@vger.kernel.org
> Subject: Re: [PATCH v7] input: tegra-kbc - Add tegra keyboard driver
> 
> On Thu, Jan 20, 2011 at 12:51:09PM +0530, Trilok Soni wrote:
> > Hi Rakesh,
> >
> > On 1/20/2011 6:41 AM, riyer@nvidia.com wrote:
> > > From: Rakesh Iyer <riyer@nvidia.com>
> > >
> > > This patch adds support for the internal matrix keyboard controller for
> > > Nvidia Tegra platforms.
> > >
> > > Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
> > > ---
> > > Fixed the stupid loop variable change.
> > > Fixed some code styling problems reported by checkpatch.pl.
> > >
> >
> > Thanks a ton for creating quick revisions :)
> >
> > >  arch/arm/mach-tegra/include/mach/kbc.h |   61 +++
> > >  drivers/input/keyboard/Kconfig         |   10 +
> > >  drivers/input/keyboard/Makefile        |    1 +
> > >  drivers/input/keyboard/tegra-kbc.c     |  727
> ++++++++++++++++++++++++++++++++
> > >  4 files changed, 799 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-tegra/include/mach/kbc.h
> > >  create mode 100644 drivers/input/keyboard/tegra-kbc.c
> > >
> > > diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/arch/arm/mach-
> tegra/include/mach/kbc.h
> > > new file mode 100644
> > > index 0000000..60d646c
> > > --- /dev/null
> > > +++ b/arch/arm/mach-tegra/include/mach/kbc.h
> > > @@ -0,0 +1,61 @@
> > > +/*
> > > + * Platform definitions for tegra-kbc keyboard input driver
> > > + *
> > > + * Copyright (c) 2010, NVIDIA Corporation.
> >
> > Wearing my legal hat. You might want to do 2010-2011 ?
> 
> OK, Rakesh, if you want copyright adjusted please shout and I can fix it
> up locally.
> 
> Trilok, I understand you are happy, right? Can I put you down as
> reviewed-by?
> 
> Thanks.
> 
> --
> Dmitry
