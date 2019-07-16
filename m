From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 16 Jul 2019 20:47:44 +0200
Message-ID: <20190716184744.GC1140@penguin>
References: <20190419081926.13567-1-ronald@innovation.ch>
 <20190419081926.13567-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419081926.13567-3-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Ronald,

On Fri, Apr 19, 2019 at 01:19:26AM -0700, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.

I applied the patch (but changed __u8 to u8 as that's preferred form for
inside the kernel, and added error handling for input_mt_init_slots) but
we need to do some more work on the driver.

My main issue is with registering touchpad device asynchronously,
independent from the probe() function. This means (as far as I can tell)
that any error is not really appropriately handled (as by that time it
is too late to signal errors from probe()) and devm functions are not
going to be called, leaving remnants of the resources in memory on
driver unload. It also brings in issues with suspend/resume (what
happens if you suspend really quickly while device is not registered
yet?), etc, etc.

Can we switch to calling DEV_INFO command synchronously from probe()? If
we are concerned about it taking relatively long time we can always
annotate the driver as having probe_type = PROBE_PREFER_ASYNCHRONOUS so
that other devices can be probed simultaneously with applespi.

Thanks.

-- 
Dmitry
