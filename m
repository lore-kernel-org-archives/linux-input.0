From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH V3 3/3] rtc: da9063: Add DA9062 RTC capability to DA9063
 RTC driver
Date: Wed, 5 Aug 2015 03:55:19 +0200
Message-ID: <20150805015519.GZ3486@piout.net>
References: <cover.1437474547.git.stwiss.opensource@diasemi.com>
 <b79c0b5d1b96bd06ab81a2459c493e68ec6b1971.1437474547.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b79c0b5d1b96bd06ab81a2459c493e68ec6b1971.1437474547.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 21/07/2015 at 11:29:07 +0100, S Twiss wrote :
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add DA9062 RTC support into the existing DA9063 RTC driver component by
> using generic access tables for common register and bit mask definitions.
> 
> The following change will add generic register and bit mask support to the
> DA9063 RTC. The changes are slightly complicated by requiring support for
> three register sets: DA9063-AD, DA9063-BB and DA9062-AA.
> 
> The following alterations have been made to the DA9063 RTC:
> 
> - Addition of a da9063_compatible_rtc_regmap structure to hold all generic
>   registers and bitmasks for this type of RTC component.
> - A re-write of struct da9063 to use pointers for regmap and compatible
>   registers/masks definitions
> - Addition of a of_device_id table for DA9063 and DA9062 defaults
> - Refactoring functions to use struct da9063_compatible_rtc accesses to
>   generic registers/masks instead of using defines from registers.h
> - Re-work of da9063_rtc_probe() to use of_match_node() and dev_get_regmap()
>   to provide initialisation of generic registers and masks and access to
>   regmap
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
