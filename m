From: "Pete MacKay" <linux01@architechnical.net>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Tue, 12 Feb 2008 23:28:43 -0500 (EST)
Message-ID: <65343.69.30.58.166.1202876923.squirrel@architechnical.net>
References: <20080212101738.GB21039@rakim.wolfsonmicro.main>
    <1202811705-2303-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757326AbYBME2q@vger.kernel.org>
In-Reply-To: <1202811705-2303-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Mike Arthur <mike.arthur@wolfsonmicro.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>, Stanley Cai <stanley.cai@intel.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Pete MacKay <linux01@architechnical.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>
List-Id: linux-input@vger.kernel.org

> This patch series adds support for the touchscreen controllers provided
> by Wolfson Microelectronics WM97xx series chips in both polled and
> streaming modes.

We're using the wm9712 codec with the sound/soc/pxa code configured in and
came across this build error:

In file included from include/linux/wm97xx.h:9,
                 from drivers/input/touchscreen/wm97xx-core.c:50:
include/sound/core.h:281: error: `SNDRV_CARDS' undeclared here (not in a
function)

I had to apply the following one-line patch to the header:

Index: linux-2.6.24.labquest/include/linux/wm97xx.h
===================================================================
--- linux-2.6.24.labquest.orig/include/linux/wm97xx.h	2008-02-12
20:17:11.000000000 -0800
+++ linux-2.6.24.labquest/include/linux/wm97xx.h	2008-02-12
20:17:39.000000000 -0800
@@ -6,6 +6,7 @@
 #ifndef _LINUX_WM97XX_H
 #define _LINUX_WM97XX_H

+#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
