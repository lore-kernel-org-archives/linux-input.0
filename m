From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v6 0/7] mfd: AXP20x: Add support for
 AXP202 and AXP209
Date: Thu, 22 May 2014 12:55:23 -0700
Message-ID: <20140522195523.GB7708@core.coreip.homeip.net>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
 <20140520222307.GK12304@sirena.org.uk>
 <CAOQ7t2aBc5tFYk2MkfL9QqvFf5fcebwKtO97F3S=WdJ2uFE_jg@mail.gmail.com>
 <20140521091456.GB6679@lee--X1>
 <CAOQ7t2bqeQ35WxXKCRgj1ijJic=2w8++9idip4-f_LnP6Ucb6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61120 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaEVTz1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 15:55:27 -0400
Content-Disposition: inline
In-Reply-To: <CAOQ7t2bqeQ35WxXKCRgj1ijJic=2w8++9idip4-f_LnP6Ucb6A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Hans De Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, wens Tsai <wens@csie.org>, sameo@linux.intel.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, linux-sunxi@googlegroups.com

On Thu, May 22, 2014 at 09:15:12PM +0200, Carlo Caione wrote:
> On Wed, May 21, 2014 at 11:14 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> >> This set of patches introduces the core driver and support for two different
> >> >> subsystems:
> >> >>       - Regulators
> >> >
> >> >>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
> >> >>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
> >> >>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >> >>  arch/arm/configs/multi_v7_defconfig                |   3 +
> >> >>  arch/arm/configs/sunxi_defconfig                   |   4 +
> >> >>  drivers/input/misc/Kconfig                         |  11 +
> >> >>  drivers/input/misc/Makefile                        |   1 +
> >> >>  drivers/input/misc/axp20x-pek.c                    | 281 +++++++++++++++++++++
> >> >>  drivers/mfd/Kconfig                                |  12 +
> >> >>  drivers/mfd/Makefile                               |   1 +
> >> >>  drivers/mfd/axp20x.c                               | 258 +++++++++++++++++++
> >> >>  include/linux/mfd/axp20x.h                         | 180 +++++++++++++
> >> >>  12 files changed, 856 insertions(+)
> >> >
> >> > The regulator changes don't appear to be showing up in the diffstat or
> >> > obviously in the series?
> >>
> >> Right. Cut-and-paste error.
> >> You have already applied the regulator patches so I didn't include
> >> them here (in theory I posted this series to be picked up by Lee).
> >
> > That's fine.  Just tell me which patches need to stay together and
> > which are able to be applied through their respective subsystem trees
> > separately.  Then, once I have all the Acks I can apply no problem.
> 
> Hi Lee,
> I'd say #1 for the MFD tree, #4 for the input subsystem, #2 #3 and #5
> are documentations, #6 and #7 defconfigs add-on.

I am fine with the input piece going through MFD tree, no need to split
it from the rest.

Thanks.

-- 
Dmitry
