From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Wed, 13 Feb 2008 11:19:08 +0000
Message-ID: <20080213111907.GC31617@rakim.wolfsonmicro.main>
References: <20080212101738.GB21039@rakim.wolfsonmicro.main> <1202811705-2303-1-git-send-email-broonie@opensource.wolfsonmicro.com> <fot8b9$b6c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765913AbYBMLTV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fot8b9$b6c$1@ger.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 12, 2008 at 10:58:50PM +0000, Dmitry Baryshkov wrote:

> You used platform_device_register, but should be using platform_device_add,
> otherwise you get barfs with 2.6.25-rc1 (device is initialized twice). Also

Thanks for that.  I feel like I should knock up a patch to clarify the
platform API documentation here.

> as <sound/driver.h> got deprecated there is no point including it.

Indeed - this is bit rot due to the age of the driver.  Hopefully it
will make it into at least 2.6.26.

BTW, could you please keep at least me in the CC list when discussing
these patches?  It's easy to miss things on the lists and they're one of
the first things I stop reading when I'm busy.
