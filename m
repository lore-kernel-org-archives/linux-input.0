From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to mach
Date: Thu, 20 Sep 2012 15:41:45 +0200
Message-ID: <6194989.y5R5mbkCAc@acer>
References: <20120919205732.28074.43697.stgit@muffinssi> <20120919210543.28074.10214.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120919210543.28074.10214.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-input@vger.kernel.org

On Wed, 19 Sep 2012 14:05:43 Tony Lindgren wrote:
> This is only used by omap1.
> 
> And to fix things properly, this should not be included
> from the drivers at all.

Akced-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

I'll take care of updating the drivers when I have some spare time.

Thanks,
Janusz
