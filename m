From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 7 Aug 2015 09:32:13 -0700
Message-ID: <20150807163213.GB30852@dtor-ws>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
 <55C468BC.60500@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33483 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267AbbHGQcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 12:32:17 -0400
Received: by pabyb7 with SMTP id yb7so59114851pab.0
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2015 09:32:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55C468BC.60500@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org

On Fri, Aug 07, 2015 at 10:13:48AM +0200, Lars-Peter Clausen wrote:
> On 08/07/2015 12:55 AM, Dmitry Torokhov wrote:
> [...]
> >>  
> >> -#ifdef CONFIG_PM
> >> -static int wm97xx_suspend(struct device *dev, pm_message_t state)
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int wm97xx_suspend(struct device *dev)
> > 
> > While we are changing it please drop #ifdef CONFIG_PM_SLEEP and annotate
> > suspend and resume with __maybe_unused.
> 
> We know that it is used when CONFIG_PM_SLEEP is defined and we know that it
> is unused CONFIG_PM_SLEEP is not defined. Marking the function as
> __maybe_unused will cause the compiler to not generate a warning when the
> function is really unused. Making this explicit works much better.

It will also drop the code form the final image and having the functions
in provides better compile coverage.

Thanks.

-- 
Dmitry
