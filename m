From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] ARM: OMAP/ASoC: Zoom2: Let the codec to handle
 the hs_extmute GPIO
Date: Thu, 9 Aug 2012 23:28:00 -0700
Message-ID: <20120810062800.GO11011@atomide.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344418887-5262-8-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-input@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 02:42]:
> Remove the use of set_hs_extmute callback and let the codec driver to
> handle the extmute GPIO.

Acked-by: Tony Lindgren <tony@atomide.com>
