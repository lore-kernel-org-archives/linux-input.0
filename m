From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
Date: Wed, 28 Nov 2012 16:31:09 +0000
Message-ID: <20121128163105.GA28698@sirena.org.uk>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
 <20121128070332.GC23378@core.coreip.homeip.net>
 <20121128085731.GH2013@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121128085731.GH2013@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: linux-input@vger.kernel.org

On Wed, Nov 28, 2012 at 08:57:31AM +0000, Lee Jones wrote:

> > I applied these 3 patches, but for DT we also need to specify compatible
> > ID and set up of_match_table pointer. 

> Why do you need a compatible string?

The I2C subsystem guesses at a compatible string by default but it's
much better to explicitly set one as conflicts do arise from time to
time (eg, Wolfson parts are called WMxxxx but the WM prefix is also used
by at least WonderMedia).
