From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 2/6] Input: elantech - use firmware provided x, y ranges
Date: Fri, 19 Aug 2011 17:47:18 +0800
Message-ID: <87obzlu40p.fsf@emc.com.tw>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-3-git-send-email-jj_ding@emc.com.tw> <20110818074756.GE10093@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:12406 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab1HSJo4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 05:44:56 -0400
In-Reply-To: <20110818074756.GE10093@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Hi Dmitry,

Sorry for late reply. I missed this one somehow.

On Thu, 18 Aug 2011 00:47:56 -0700, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 18, 2011 at 09:57:05AM +0800, JJ Ding wrote:
> > +
> > +		i = (etd->fw_version > 0x020800 &&
> > +		     etd->fw_version < 0x020900) ? 1 : 2;
> > +		*x_max = (etd->capabilities[1] - i) * 64;
> > +		*y_max = (etd->capabilities[2] - i) * 64;
> > +		*y_2ft_max = (*y_max - i) * 64 / 4;
> 
> Hmm, we should have the same range for ST and MT data and scale MT data
> if it has lower resolution to match ST.
So I should just remove y_2ft_max and those ETP_2FT_XXXX in elantech.h,
and do the scale in elantech_report_absolute_v2?

If so, I will create another patch for this change.

Is this OK with you?

Thanks.
jj
> Thanks.
> 
> -- 
> Dmitry
