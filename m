From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 7 Aug 2015 09:30:29 -0700
Message-ID: <20150807163029.GA30852@dtor-ws>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
 <55C468BC.60500@metafoo.de>
 <20150807133005.GG10301@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35945 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161003AbbHGQad (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 12:30:33 -0400
Received: by pacrr5 with SMTP id rr5so55989797pac.3
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2015 09:30:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150807133005.GG10301@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org

On Fri, Aug 07, 2015 at 02:30:05PM +0100, Mark Brown wrote:
> On Fri, Aug 07, 2015 at 10:13:48AM +0200, Lars-Peter Clausen wrote:
> > On 08/07/2015 12:55 AM, Dmitry Torokhov wrote:
> 
> > > Pull this out of #ifdef block and kill entire #else/endif along with
> > > WM97XX_PM_OPS define: SIMPLE_DEV_PM_OPS will result in an empty
> > > structure if CONFIG_PM_SLEEP is not set.
> 
> > It will create a struct dev_pm_ops full of NULLs. That's kind of
> > counterproductive to removing PM related data and functions from the kernel
> > if PM support is no enabled.
> 
> Indeed, a major goal of disabling PM support is to save space.

Then maybe we should adjust dev_pm_ops definition to omit members that
are not used if given state is not supported? We have a lot of drivers
that are not doing silly pointer #define games.

-- 
Dmitry
