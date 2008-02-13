From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Wed, 13 Feb 2008 10:11:22 +0000
Message-ID: <20080213101122.GB31617@rakim.wolfsonmicro.main>
References: <20080212101738.GB21039@rakim.wolfsonmicro.main> <1202811705-2303-1-git-send-email-broonie@opensource.wolfsonmicro.com> <65343.69.30.58.166.1202876923.squirrel@architechnical.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932232AbYBMKLq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <65343.69.30.58.166.1202876923.squirrel@architechnical.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Pete MacKay <linux01@architechnical.net>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Mike Arthur <mike.arthur@wolfsonmicro.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>, Stanley Cai <stanley.cai@intel.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 12, 2008 at 11:28:43PM -0500, Pete MacKay wrote:

> We're using the wm9712 codec with the sound/soc/pxa code configured in and
> came across this build error:

Which kernel version are you building against?  I've been testing with
v2.6.24 (and have just updated to v2.6.25-rc1 which is also building
fine for me) and...

>  #ifndef _LINUX_WM97XX_H
>  #define _LINUX_WM97XX_H
> 
> +#include <sound/driver.h>

...this header is deprecated so should never need to be included (yes,
there are other instances in there which need to be cleaned up) so I'm a
bit mystified as to what's going wrong for you here.  Which kernel
version are you using?
