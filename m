From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7] input: tegra-kbc - Add tegra keyboard driver
Date: Wed, 19 Jan 2011 23:29:48 -0800
Message-ID: <20110120072948.GA30522@core.coreip.homeip.net>
References: <1295485917-21278-1-git-send-email-riyer@nvidia.com>
 <4D37E265.9060304@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65029 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1ATH34 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 02:29:56 -0500
Content-Disposition: inline
In-Reply-To: <4D37E265.9060304@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: riyer@nvidia.com, pavel@ucw.cz, shubhrajyoti@ti.com, ccross@android.com, konkers@android.com, olof@lixom.net, achew@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Jan 20, 2011 at 12:51:09PM +0530, Trilok Soni wrote:
> Hi Rakesh,
> 
> On 1/20/2011 6:41 AM, riyer@nvidia.com wrote:
> > From: Rakesh Iyer <riyer@nvidia.com>
> > 
> > This patch adds support for the internal matrix keyboard controller for
> > Nvidia Tegra platforms.
> > 
> > Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
> > ---
> > Fixed the stupid loop variable change.
> > Fixed some code styling problems reported by checkpatch.pl.
> > 
> 
> Thanks a ton for creating quick revisions :)
> 
> >  arch/arm/mach-tegra/include/mach/kbc.h |   61 +++
> >  drivers/input/keyboard/Kconfig         |   10 +
> >  drivers/input/keyboard/Makefile        |    1 +
> >  drivers/input/keyboard/tegra-kbc.c     |  727 ++++++++++++++++++++++++++++++++
> >  4 files changed, 799 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-tegra/include/mach/kbc.h
> >  create mode 100644 drivers/input/keyboard/tegra-kbc.c
> > 
> > diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/arch/arm/mach-tegra/include/mach/kbc.h
> > new file mode 100644
> > index 0000000..60d646c
> > --- /dev/null
> > +++ b/arch/arm/mach-tegra/include/mach/kbc.h
> > @@ -0,0 +1,61 @@
> > +/*
> > + * Platform definitions for tegra-kbc keyboard input driver
> > + *
> > + * Copyright (c) 2010, NVIDIA Corporation.
> 
> Wearing my legal hat. You might want to do 2010-2011 ?

OK, Rakesh, if you want copyright adjusted please shout and I can fix it
up locally.

Trilok, I understand you are happy, right? Can I put you down as
reviewed-by?

Thanks.

-- 
Dmitry
